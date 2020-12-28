import 'package:flutter/material.dart';

import 'package:niteclub/core/models/place_model.dart';
import 'package:niteclub/ui/PlaceDetail.dart';
import 'package:niteclub/ui/SearchScreen.dart';

class RouterGenerator {

  //* Routing list
  static const routeDetailPlace = "PlaceDetail";
  static const routePlaceSearch = "SearchScreen";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch(settings.name) {
      case routePlaceSearch:
        return MaterialPageRoute(builder: (_) => SearchScreen());
        break;
      case routeDetailPlace:
        if (args is PlaceModel) {
          return MaterialPageRoute(builder: (_) => PlaceDetailScreen(place: args,));
        }
        break;
    }
  }
}