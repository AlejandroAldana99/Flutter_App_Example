import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
//import 'package:flutter_instagram_stories/flutter_instagram_stories.dart';

import 'package:niteclub/core/services/place_service.dart';
import 'package:niteclub/core/models/place_model.dart';
import 'package:niteclub/ui/PlaceItem.dart';
import 'package:niteclub/ui/router/routing.dart';
import 'package:niteclub/ui/utils/constant.dart';


class Home extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: Colors.white,
//      appBar: AppBar(
//        brightness: Brightness.light,
//        elevation: 0,
//        backgroundColor: Colors.white,
//        title: _appBar(),
//      ),
      body: HomeBody()
    );
  }
//  Widget _appBar() {
//    return Builder(
//      builder: (context) {
//        return Consumer<PlaceProvider>(
//          builder: (context, placeProvider, _) {
//            return SearchItem(
//              controller: searchController,
//              onClick: () => placeProvider.goToSearchPlace(context),
//              readOnly: true,
//            );
//          },
//        );
//      },
//    );
//  }
}


class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            _locationWidget(),
            SizedBox(height: 10),
            _nameWidget(),
            SizedBox(height: 10),
            _placeList(),
          ],
        ),
      ),
    );
  }

//  Widget _locationWidget() {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.center,
//      children: <Widget>[
//        Row(
//          children: <Widget>[
//            Icon(Icons.location_on, color: primaryColor, size: 25),
//            SizedBox(width: 5),
//            Consumer<LocationProvider>(
//              builder: (context, locationProv, _) {
//                //* If location address stil null
//                if (locationProv.address == null) {
//                  return CircularProgressIndicator();
//                }
//                var x = locationProv.address;
//                String direction = x[0] + ", " + x[1] + ", " + x[2];
//                return Expanded(
//                  child: Text(
//                    direction,
//                    maxLines: 1,
//                    overflow: TextOverflow.ellipsis,
//                    style: TextStyle(
//                        color: Colors.black54
//                    ),
//                  ),
//                );
//              },
//            )
//
//          ],
//        ),
//        Divider(color: Colors.black12),
//      ],
//    );
//  }

  Widget _nameWidget() {
    return Text(
      "Places",
      style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 18
      ),
    );
  }

  List<PlaceModel> _getDataPlace() {
    List<PlaceModel> data;
    PlaceService service = new PlaceService();
    List<DocumentSnapshot> placeData;
    service.getData().then((val){
      if( val.documents.length > 0) {
        placeData = val.documents;
        data = placeData.map((e) => PlaceModel.fromFire(e.data, e.documentID)).toList();
      }
    });
    return data;
  }

  Widget _placeList() {
    PlaceService service = new PlaceService();
    List<PlaceModel> listPlace = _getDataPlace();
//    listPlace = service.getData().then((val){
//      List<PlaceModel> data;
//      if(val.documents.length > 0) {
//        data = val.documents.map((e) => PlaceModel.fromFire(e.data, e.documentID)).toList();
//      }
//      return data;
//    });

    return Builder(
      builder: (context) {
        if (listPlace == null) {
          return Center(
            child: LinearProgressIndicator(),
          );
        }
        //* If collection is not found
        if (listPlace.length == 0) {
          return Center(
            child: Text(
                "No Places Found"
            ),
          );
        }
        else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: listPlace.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var place = listPlace[index];
              return PlaceItem(
                  place: place
              );
            },
          );
        }
      },
    );
  }
}

//class newsFeed extends StatefulWidget {
//  @override
//  _newsFeed createState() => _newsFeed();
//}

//class _newsFeed extends State<newsFeed> {
//  PlaceService place = PlaceService();
//
//  @override
//  Widget build(BuildContext context) {
//    return Positioned(
//        top: 150.0,
//        child: Container(
//          height: MediaQuery.of(context).size.height,
//          width: MediaQuery.of(context).size.width,
//          color: Colors.black,
//          child: ListView(
//            scrollDirection: Axis.vertical,
//            children: <Widget>[
//              Center(
//                child: Container(
//                  margin: EdgeInsets.symmetric(vertical: 8),
//                  height: 150.0,
//                  width: 350.0,
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                  ),
//                ),
//              ),
//              Center(
//                child: Container(
//                  child: Text("Lugar"),
//                  margin: EdgeInsets.symmetric(vertical: 8),
//                  height: 150.0,
//                  width: 350.0,
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ),
//
//    );
//  }

//  _showPlace(BuildContext context) {
//    FutureBuilder(
//      future: place.getAll(),
//      builder: (BuildContext context, AsyncSnapshot<List<PlaceModel>> snapshot) {
//        for(PlaceModel model in snapshot.data ) {
//          return Text(model.name);
//        }
//      },
//    );
//  }


