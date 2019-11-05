import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/common/colors.dart';
import 'package:flutter_banking/model/branch.dart';
import 'package:flutter_banking/model/user_location.dart';
import 'package:flutter_banking/view/base_view.dart';
import 'package:flutter_banking/viewmodel/map_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  static List<Branch> branches = [
    Branch(
        id: '0',
        name: 'Oldenburg-Nadorst',
        type: 'Geldautomat',
        position: LatLng(53.155361, 8.2175729)),
    Branch(
        id: '1',
        name: 'Oldenburg-Bürgerfelde',
        type: 'Filiale',
        position: LatLng(53.1719524, 8.1928393)),
    Branch(
        id: '2',
        name: 'Oldenburg-Alexanderstraße',
        type: 'SB-Filiale',
        position: LatLng(53.1557353, 8.207197)),
    Branch(
        id: '3',
        name: 'Oldenburg-Gottorpstraße',
        type: 'Filiale',
        position: LatLng(53.1406419, 8.2158691)),
    Branch(
        id: '4',
        name: 'Oldenburg-Eversten',
        type: 'Filiale',
        position: LatLng(53.1330698, 8.1954535)),
  ];

  Set<Marker> markers = {};
  String _filter = 'Alle';

  @override
  void initState() {
    super.initState();

    Future<BitmapDescriptor> future = BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/institute/olb-small.png');
    future.then((markerIcon) => {

    });

    Set<Marker> _markers = branches.map((branch) {
      return Marker(
          markerId: MarkerId(branch.id),
          icon: BitmapDescriptor.defaultMarker,
          position: branch.position);
    }).toSet();

    setState(() {
      markers = _markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle dropdownButtonText = themeData.textTheme.title
        .copyWith(color: MyColor.darkGrey, fontSize: 16);

    return BaseView<MapModel>(
      builder: (context, model, child) {
        var userLocation = Provider.of<UserLocation>(context);
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
                        initialCameraPosition: CameraPosition(
                            zoom: 14.0,
                            target: LatLng(
                                userLocation.latitude, userLocation.longitude)),
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        padding: EdgeInsets.only(top: 96),
                        markers: markers,
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
                  backgroundColor: MyColor.lighterGrey,
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
                        child: Text(value, style: dropdownButtonText),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
