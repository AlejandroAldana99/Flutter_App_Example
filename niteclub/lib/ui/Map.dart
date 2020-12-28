import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:niteclub/ui/PlaceDetail.dart';

import 'package:niteclub/core/models/place_model.dart';
import 'package:niteclub/core/services/place_service.dart';
import 'package:niteclub/ui/router/routing.dart';


class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Completer<GoogleMapController> _controller = Completer();

  List<PlaceModel> cList;
  final Set<Marker> mapMarkets = new Set();
  Position _currentPosition;
  String _currentAddress;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.71427,-74.00597),
    zoom: 11,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
  }

  _initData() async {
    PlaceService service = new PlaceService();
    List<DocumentSnapshot> placeData;
    service.getData().then((val){
      if(val.documents.length > 0) {
        placeData = val.documents;
        cList = placeData.map((e) => PlaceModel.fromFire(e.data, e.documentID)).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        markers: cList.map((e) =>
            Marker(
                markerId: MarkerId(e.fireId),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                position: LatLng(e.Latitud, e.Longitud),
                infoWindow: InfoWindow(
                    title: e.Name,
                    snippet: "Type: ${e.Type} | Music: ${e.Music}",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PlaceDetailScreen(place: e)
                      ));
                    }
                )
            ),
        ).toSet(),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _getCameraOnMe();
          if(_currentPosition != null) {
            //_getCurrentLocation();
            _getCameraOnMe();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCameraOnMe,
        child: Icon(Icons.my_location),
        backgroundColor: Colors.black,
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  _getCurrentLocation() {
    geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
      setState(() {
        print(position);
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        _currentAddress =
        "${place.name},${place.locality}, ${place.administrativeArea},${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  _getCameraOnMe() async {
    final GoogleMapController controller = await _controller.future;
    geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
      final mePosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16.00,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(mePosition));
    });
  }

  _getMarkets() {
    //List<PlaceModel> listPlace = cList;
//    listPlace.forEach((element) {
//      var place = element.toJson();
//      mapMarkets.add(
//        Marker(
//          markerId: MarkerId(place["fireId"]),
//          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
//          position: LatLng(
//            place["Latitud"],
//            place["Longitud"]
//          ),
//          infoWindow: InfoWindow(
//            title: place["Name"],
//            snippet: "Type: ${place["Type"]} | Music: ${place["Music"]}",
//            onTap: () {
//              Navigator.push(context, MaterialPageRoute(
//                builder: (context) => PlaceDetailScreen(place: element)
//              ));
//            }
//          ),
//        )
//      );
//      print(element.toJson());
//    });
    //return mapMarkets;
  }

}