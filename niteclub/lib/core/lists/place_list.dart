import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:niteclub/core/models/place_model.dart';
import 'package:niteclub/ui/router/routing.dart';
import 'package:niteclub/core/services/place_service.dart';
import 'package:niteclub/injector.dart';
import 'package:niteclub/core/lists/location_list.dart';


class PlaceProvider extends ChangeNotifier {
  //* ----------------------------
  //* This is side for property data
  //* ----------------------------

  //* Restaurant list variable
  List<PlaceModel> _placeList;
  List<PlaceModel> get placetList => _placeList;

  //* Restaurant list by specific keyword
  List<PlaceModel> _placeByKeywordList;
  List<PlaceModel> get placeByKeywordList => _placeByKeywordList;

  //* To handle event search
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  //* Dependency Injection
  PlaceService placeServices = locator<PlaceService>();

  //* ----------------------------
  //* Function field
  //* ----------------------------

  /// Function to get all restaurant by coordinate
//  void getAll(BuildContext context) async {
//    //final locationProv = Provider.of<LocationProvider>(context, listen: false);
//    _placeList = await placeServices.getAll(context);
//    notifyListeners();
//  }

  // Function to search location
//  void getAllByKeyword(String keyword, BuildContext context) async {
//
//    //* Set search state to active
//    setOnSearch(true);
//
//    //* Clear previous history
//    await clearPlaceSearch();
//
//    //* Then fetch new keyword
//    final locationProv = Provider.of<LocationProvider>(context, listen: false);
//    _placeByKeywordList = await placeServices.getAllByKeyword(
//        keyword, locationProv.latitude.toString(),
//        locationProv.longitude.toString(), context);
//
//    //* Set search state to deactive
//    setOnSearch(false);
//    notifyListeners();
//  }

  /// Function to handle onsearch state
  void setOnSearch(bool status) {
    _onSearch = status;
    notifyListeners();
  }

  /// Function to clear restaurant list by collection
  void clearPlaceSearch() {
    _placeByKeywordList = null;
    notifyListeners();
  }

  /// Function to navigate to search restaurant
  void goToSearchPlace(BuildContext context) async {
    await clearPlaceSearch();
    Navigator.pushNamed(context, RouterGenerator.routePlaceSearch);
  }
}

