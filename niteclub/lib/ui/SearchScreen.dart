import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:niteclub/core/lists/place_list.dart';
import 'package:niteclub/ui/utils/search_item.dart';
import 'package:niteclub/ui/utils/constant.dart';
import 'package:niteclub/ui/PlaceMini.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        //title: _appBar(),
      ),
      body: SearchBody(),
    );
  }

//  Widget _appBar() {
//    return Builder(
//      builder: (context) {
//        return Consumer<PlaceProvider>(
//          builder: (context, placeProvider, _) {
//
//            return SearchItem(
//              controller: searchController,
//              autoFocus: true,
//              onSubmit: (value) => placeProvider.getAllByKeyword(value, context),
//            );
//          },
//        );
//      },
//    );
//  }
}

class SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _placeCount(),
            _placesList(),
          ],
        ),
      ),
    );
  }


  Widget _placeCount() {
    return Builder(
      builder: (context) {
        return Consumer<PlaceProvider>(
          builder: (context, placeProvider, _) {

            if (placeProvider.placeByKeywordList == null) {
              return SizedBox();
            }

            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.location_on, color: primaryColor),
                    SizedBox(width: 10),
                    Text(
                      "${placeProvider.placeByKeywordList.length.toString()} place",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,

                      ),
                    ),
                  ],
                ),

                Divider(color: Colors.black12),
              ],
            );
          },
        );
      },
    );
  }

  Widget _placesList() {
    return Builder(
      builder: (context) {
        return Consumer<PlaceProvider>(
          builder: (context, placeProv, _) {

            //* If collection data null then fetch
            if (placeProv.placeByKeywordList == null && placeProv.onSearch == false) {
              return Center(
                child: Text("What are you looking for?"),
              );
            }

            if (placeProv.onSearch) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            //* If collection is not found
            if (placeProv.placeByKeywordList.length == 0) {
              return Center(
                child: Text(
                    "Place not found"
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: placeProv.placeByKeywordList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {

                var restaurant = placeProv.placeByKeywordList[index];
                return PlaceMiniItem(
                    place: restaurant
                );
              },
            );
          },
        );
      },
    );
  }
}