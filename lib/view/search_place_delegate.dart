import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking/model/place.dart';
import 'package:flutter_banking/view/search_suggestion_list.dart';

class SearchPlaceDelegate extends SearchDelegate<PlaceNew> {
  String PLACES_API_KEY = 'AIzaSyA5By6RbOWhe0mBLyhxD5IS5S2r1JMfv7k';

  final List<String> _data = [
    'Ammerländer Heerstraße',
    'Aachener Straße',
    'Widukindstraße'
  ];
  final List<String> _history = ['Ehnernstraße'];

  Timer _throttle;

  // TODO: SearchDelegate doesn't respect theme
  // Workaround from https://github.com/flutter/flutter/issues/32180
  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context);

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return query.isNotEmpty
        ? [
            IconButton(
              tooltip: 'Clear',
              icon: Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
          ]
        : null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = _history;

    return FutureBuilder(
      future: getPlaceData(query),
      builder: (context, AsyncSnapshot<List<PlaceNew>> snapshot) {
        if (snapshot.hasData) {
          final List<PlaceNew> places = snapshot.data;
          List<Suggestion> suggestions = places.map((e) {
            return Suggestion(id: e.documentID, name: e.description);
          }).toList();

          if (places != null) {
            return SearchSuggestionListView(
              query: query,
              items: suggestions,
              onTap: (Suggestion value) async {
                PlaceNew place = await getPlaceDetails(value.id);
                this.close(context, place);
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        }

        return Container(
          child: Text('No Data'),
        );
      },
    );
  }

  Future<List<PlaceNew>> getPlaceData(String query) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String type = 'address';
    // TODO: Add session token

    String request = '$baseURL?input=$query&key=$PLACES_API_KEY&type=$type';
    Response response = await Dio().get(request);

    final List predictions = response.data['predictions'];
    List<PlaceNew> suggestedPlaces = predictions.map((prediction) {
      return PlaceNew(
          documentID: prediction['place_id'],
          description: prediction['description']);
    }).toList();

    return suggestedPlaces;
  }

  Future<PlaceNew> getPlaceDetails(String placeId) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/details/json';
    String fields = 'address_component';
    // TODO: Add session token

    String request = '$baseURL?place_id=$placeId&key=$PLACES_API_KEY&fields=$fields';
    Response response = await Dio().get(request);

    var result = response.data['result'];
    List addressComponents = result['address_components'];

    Address address = Address();
    for(int i = 0; i < addressComponents.length; i++) {

      var component = addressComponents[i];
      List typesArray = component['types'];

      for (int j = 0; j < typesArray.length; j++) {
        switch (typesArray[j]) {
          case 'street_number':
            address.streetNumber = component['long_name'];
            break;
          case 'route':
            address.street = component['long_name'];
            break;
          case 'postal_code':
            address.postalCode = component['long_name'];
            break;
          case 'locality':
            address.city = component['long_name'];
            break;
          case 'country':
            address.country = component['long_name'];
            break;
          default:
            break;
        }
      }
    }

    return PlaceNew(address: address);
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }
}
