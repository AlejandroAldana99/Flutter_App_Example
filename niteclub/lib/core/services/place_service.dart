import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';

import 'package:niteclub/core/models/place_model.dart';
import 'package:niteclub/core/utils/clouddb.dart';
import 'package:niteclub/core/utils/localdb.dart';


GetIt setup = GetIt.instance;

final String table_place = "CREATE TABLE places ( fireId TEXT, id INTEGER PRIMARY KEY, Name TEXT, "
    " ImgRef TEXT, AveragePrice INTEGER, Cover INTEGER, Rate INTEGER, Email TEXT, PublicEmail TEXT, Latitud REAL,"
    " Longitud REAL, Music TEXT, Phone TEXT, Type TEXT ) ";

final String table_address = "CREATE TABLE placesAddress ( idAddress INTEGER PRIMARY KEY, "
    "cp INTEGER, neighborhood TEXT, street TEXT ); ";

final String table_menu = "CREATE TABLE placesMenu ( id INTEGER, name TEXT, price REAL ); ";

final String table_hrs = "CREATE TABLE placesHrs ( id INTEGER PRIMARY KEY, monday TEXT, "
    " tuesday TEXT, wednesday TEXT, thursday TEXT, friday TEXT, saturday TEXT, sunday TEXT ); ";

class PlaceService {
  API _api = new API("places");
  List<PlaceModel> places;
  localDatabase _db = localDatabase();
  Database sqlite_db;
  final Firestore _fireStore = Firestore.instance;

//   Future main() async {
//    //var data = getAll();
//    print("Inicio de inyeccion");
//    //if (getAll() == null){
//      var results = await _api.getDataCollection();
//      places = results.documents.map((doc) => PlaceModel.fromFire(doc.data, doc.documentID))
//        .toList();
//
//      _db.initDB(table_place,"Places.db");
////      _db.initDB(table_address,"Places.db");
////      _db.initDB(table_menu,"Places.db");
////      _db.initDB(table_hrs,"Places.db");
//
////      Map<String, dynamic> place = PlaceModel.fromMap(places) as Map<String, String>;
////
////      print(place);
////
////    _db.insert_db("places", place);
//
//      places.forEach((element) {
//        var data = element.toJson();
//
//        Map<String, dynamic> menu = data['Menu'];
//        Map<String, dynamic> address = data['Address'];
//        Map<String, dynamic> hrs = data['Schudule'];
//        Map<String, dynamic> pla = element.toPlace();
//
//        print(pla);
//
////        _db.insert_db(address, "placesAddress");
////        _db.insert_db(menu, "placesMenu");
////        _db.insert_db(hrs, "placesHrs");
//        _db.insert_db("places", pla);
//
//      });
//
//    }
////    else {
////      print("No vacio");
////      print(getAll());
////    }
//  }

  getData() async {
    return await _fireStore.collection("customers").document("mexico")
        .collection("guanajuato").document("leon")
        .collection("places")
        .getDocuments();
  }
}
//  Future<List<PlaceModel>> getAll(BuildContext context) async {
//    var results = await _api.getDataCollection();
//    places = results.documents
//        .map((doc) => PlaceModel.fromFire(doc.data, doc.documentID))
//        .toList();
//    var placeList = new List<PlaceModel>();
//    places.forEach((element) {
//      var data = element.toJson();
//      print(data);
//      //placeList.add(PlaceModel.fromMap(data));
//    });
//    //print(placeList);
//    return places;
//  }

//  Future<List<PlaceModel>> getAllByKeyword(String keyword, String latitude, String longitude, BuildContext context) async {
//    var resp = await request(Api.instance.searchRestaurantByKeyword
//        .replaceAll("%latitude%", latitude)
//        .replaceAll("%longitude%", longitude)
//        .replaceAll("%keyword%", keyword),
//        RequestType.GET, context,
//        useToken: true);
//
//    var placeList = new List<PlaceModel>();
//    //* Check if response contains restaurant list
//    if (resp.containsKey("restaurants")) {
//      resp["restaurants"].forEach((val) {
//        placeList.add(RestaurantModel.fromJson(val["restaurant"]));
//      });
//    }
//
//    return placeList;
//  }
//
//  Future<List<PlaceModel>> getAllByCollection(String collectionID, BuildContext context) async {
//    var resp = await request(Api.instance.getRestaurantByCollection
//        .replaceAll("%collection_id%", collectionID),
//        RequestType.GET, context,
//        useToken: true);
//
//    var placeList = new List<PlaceModel>();
//    //* Check if response contains restaurant list
//    if (resp.containsKey("restaurants")) {
//      resp["restaurants"].forEach((val) {
//        placeList.add(PlaceModel.fromJson(val["restaurant"]));
//      });
//    }
//
//    return placeList;
//  }

//  Future<List<PlaceModel>> getAll() async {
//    List<Map<String, dynamic>> results = await sqlite_db.query("places");
//    return results.map((map) => PlaceModel.fromMap(map));
//  }
//}
