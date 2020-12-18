import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banking/common/dimens.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/common/colors.dart';
import 'package:flutter_banking/model/place.dart';
import 'package:flutter_banking/model/user_location.dart';
import 'package:flutter_banking/view/base_view.dart';
import 'package:flutter_banking/viewmodel/map_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/services.dart' show rootBundle;

class AtmMapView extends StatefulWidget {
  @override
  _AtmMapViewState createState() => _AtmMapViewState();
}

class _AtmMapViewState extends State<AtmMapView> {
  MapModel _model;

  GoogleMapController _mapController;
  String _nightStyle;
  bool _nightMode;

  List<Place> _places;
  Set<Marker> markers = {};
  String _filter = 'All';
  bool _showATM = false;
  bool _showCDM = false;
  bool _showOffice = false;
  bool _showAll = true;

  UserLocation _userLocation =
      UserLocation(latitude: 53.158017, longitude: 8.213230);

  void _onFilterChanged(String value) {
    // reset
    _showATM = false;
    _showCDM = false;
    _showOffice = false;
    _showAll = false;

    switch (value) {
      case 'ATM':
        _showATM = true;
        break;
      case 'CDM':
        _showCDM = true;
        break;
      case 'Offices':
        _showOffice = true;
        break;
      case 'All':
        _showAll = true;
        break;
      default:
        _showAll = true;
    }

    setState(() {
      initPlaces();
      _filter = value;
    });
  }

  void initPlaces() {
    _places = _model.getPlaces(
        showATM: _showATM, showCDM: _showCDM, showOffice: _showOffice);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    // sets dark theme
    _nightMode = theme.brightness == Brightness.dark;

    return BaseView<MapModel>(
      onModelReady: (model) {
        this._model = model;
        _places = model.getPlaces(
            showATM: _showATM, showCDM: _showCDM, showOffice: _showOffice);
      },
      builder: (context, model, child) {
        return StreamBuilder(
            initialData: _userLocation,
            stream: model.locationStream,
            builder: (_, AsyncSnapshot<UserLocation> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              _userLocation = snapshot.data;

              return Stack(
                children: [
                  AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                      statusBarColor: MyColor.transparentStatusBarColor,
                    ),
                    child: Scaffold(
                      body: _buildBody(),
                      floatingActionButton: _buildFloatingActionButton(),
                    ),
                  ),
                  _buildAppBar(theme),
                ],
              );
            });
      },
    );
  }

  Positioned _buildAppBar(ThemeData theme) {
    final TextStyle searchBarText =
        theme.textTheme.headline6.copyWith(fontSize: 16);
    final Color searchBarColor = theme.bottomAppBarColor;

    return Positioned(
      top: 10,
      right: 10,
      left: 10,
      child: SafeArea(
        child: AppBar(
          iconTheme: theme.iconTheme,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: searchBarColor,
          elevation: 2,
          primary: true,
          title: DropdownButton<String>(
            value: _filter,
            icon: Icon(Icons.filter_list),
            isExpanded: true,
            onChanged: _onFilterChanged,
            items: ['All', 'Offices', 'ATM', 'CDM']
                .map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: searchBarText),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_model.state == ViewState.DataFetched) initMarkers();

    return _model.state == ViewState.Busy
        ? _buildLoadingUi()
        : _buildGoogleMap();
  }

  Center _buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  GoogleMap _buildGoogleMap() {
    return GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: CameraPosition(
          zoom: 14.0,
          target: LatLng(_userLocation.latitude, _userLocation.longitude)),
      mapToolbarEnabled: false,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      padding: EdgeInsets.only(top: 96),
      markers: markers,
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() => _mapController = controller);

    // load night style
    if (_nightMode) {
      _nightStyle =
          await rootBundle.loadString('assets/styles/maps_night_mode.json');
      setState(() => _mapController.setMapStyle(_nightStyle));
    }
  }

  void initMarkers() async {
    /* TODO: Parameter size does nothing. Maybe related to https://github.com/flutter/flutter/issues/40699
                   For now use a smaller version of the image */

    initPlaces();

    BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(16, 16)),
        'assets/images/marker-icon.png');

    Set<Marker> _markers = _places.map((place) {
      return Marker(
          markerId: MarkerId(place.documentID),
          onTap: () => _buildBottomSheet(place),
          infoWindow: InfoWindow(
            title: place.name,
          ),
          icon: markerIcon ?? BitmapDescriptor.defaultMarker,
          position: place.position);
    }).toSet();

    setState(() => markers = _markers);
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        final CameraUpdate camera = CameraUpdate.newLatLng(
            LatLng(_userLocation.latitude, _userLocation.longitude));
        _mapController.animateCamera(camera);
      },
      child: Icon(Icons.gps_fixed),
    );
  }

  Future _buildBottomSheet(Place place) {
    final ThemeData theme = Theme.of(context);
    final TextStyle headline = theme.textTheme.headline6;
    final TextStyle body =
        theme.textTheme.subtitle2.copyWith(color: Colors.grey);

    return showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            height: 164,
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.listItemPaddingHorizontal,
                vertical: Dimens.listItemPaddingVertical),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(place.name, style: headline),
                SizedBox(
                  height: 2,
                ),
                Text(place.type, style: body),
                Text(place.address, style: body),
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
