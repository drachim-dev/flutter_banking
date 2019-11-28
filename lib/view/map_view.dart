import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banking/common/dimensions.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/common/colors.dart';
import 'package:flutter_banking/model/place.dart';
import 'package:flutter_banking/model/user_location.dart';
import 'package:flutter_banking/view/base_view.dart';
import 'package:flutter_banking/viewmodel/map_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/services.dart' show rootBundle;

class MapView extends StatefulWidget {
  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  static List<Place> places = [
    Place(
        id: '0',
        name: 'Oldenburg-Nadorst',
        type: 'Geldautomat',
        position: LatLng(53.155361, 8.2175729)),
    Place(
        id: '1',
        name: 'Oldenburg-Bürgerfelde',
        type: 'Filiale',
        position: LatLng(53.1719524, 8.1928393)),
    Place(
        id: '2',
        name: 'Oldenburg-Alexanderstraße',
        type: 'SB-Filiale',
        position: LatLng(53.1557353, 8.207197)),
    Place(
        id: '3',
        name: 'Oldenburg-Gottorpstraße',
        type: 'Filiale',
        position: LatLng(53.1406419, 8.2158691)),
    Place(
        id: '4',
        name: 'Oldenburg-Eversten',
        type: 'Filiale',
        position: LatLng(53.1330698, 8.1954535)),
  ];

  GoogleMapController _mapController;
  String _nightStyle;
  bool _nightMode;

  Set<Marker> markers = {};
  String _filter = 'Alle';

  @override
  void initState() {
    super.initState();

    initMarkers();
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      _mapController = controller;
    });

    // load night style
    if (_nightMode) {
      _nightStyle =
          await rootBundle.loadString('assets/styles/maps_night_mode.json');
      setState(() {
        _mapController.setMapStyle(_nightStyle);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle searchBarText =
        theme.textTheme.title.copyWith(fontSize: 16);
    final Color searchBarColor = theme.bottomAppBarColor;

    // sets dark theme
    _nightMode = theme.brightness == Brightness.dark;

    return BaseView<MapModel>(
      builder: (context, model, child) {
        return StreamBuilder(
            initialData: UserLocation(latitude: 53.158017, longitude: 8.213230),
            stream: model.locationStream,
            builder: (context, AsyncSnapshot<UserLocation> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              var userLocation = snapshot.data;

              return Stack(
                children: <Widget>[
                  AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                      statusBarColor: MyColor.transparentStatusBarColor,
                    ),
                    child: Scaffold(
                      body: model.state == ViewState.Busy
                          ? Center(child: CircularProgressIndicator())
                          : GoogleMap(
                              onMapCreated: onMapCreated,
                              initialCameraPosition: CameraPosition(
                                  zoom: 14.0,
                                  target: LatLng(userLocation.latitude,
                                      userLocation.longitude)),
                              mapToolbarEnabled: false,
                              myLocationEnabled: true,
                              myLocationButtonEnabled: false,
                              padding: EdgeInsets.only(top: 96),
                              markers: markers,
                            ),
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          final CameraUpdate camera = CameraUpdate.newLatLng(
                              LatLng(userLocation.latitude,
                                  userLocation.longitude));
                          _mapController.animateCamera(camera);
                        },
                        child: Icon(Icons.gps_fixed),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    left: 10,
                    child: SafeArea(
                      child: AppBar(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: searchBarColor,
                        elevation: 2,
                        primary: true,
                        title: DropdownButton<String>(
                          value: _filter,
                          icon: Icon(Icons.filter_list),
                          isExpanded: true,
                          onChanged: (String value) {
                            setState(() {
                              _filter = value;
                            });
                          },
                          items: <String>[
                            'Alle',
                            'Filialen',
                            'Geldautomaten',
                            'Geldeinzahlautomaten'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: searchBarText),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            });
      },
    );
  }

  void initMarkers() async {
    /* TODO: Parameter size does nothing. Maybe related to https://github.com/flutter/flutter/issues/40699
       For now use a smaller version of the image */

    BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(16, 16)),
        'assets/images/institute/olb-small.png');

    Set<Marker> _markers = places.map((place) {
      return Marker(
          markerId: MarkerId(place.id),
          onTap: () => _buildBottomSheet(place),
          infoWindow: InfoWindow(
            title: place.name,
          ),
          icon: markerIcon ?? BitmapDescriptor.defaultMarker,
          position: place.position);
    }).toSet();

    setState(() {
      markers = _markers;
    });
  }

  Future _buildBottomSheet(Place place) {
    final ThemeData theme = Theme.of(context);
    final TextStyle headline = theme.textTheme.title;
    final TextStyle body =
        theme.textTheme.subtitle.copyWith(color: Colors.grey);

    return showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            height: 164,
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.listItemPaddingHorizontal,
                vertical: Dimensions.listItemPaddingVertical),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(place.name, style: headline),
                SizedBox(
                  height: 2,
                ),
                Text(place.type, style: body),
                Text(place.position.toString(), style: body),
                SizedBox(
                  height: 12,
                ),
                RaisedButton(
                  onPressed: () => _startNavigation(place.position),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text('Route'),
                )
              ],
            ),
          );
        });
  }

  void _startNavigation(LatLng location) async {
    final url =
        'google.navigation:q=${location.latitude},${location.longitude}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
