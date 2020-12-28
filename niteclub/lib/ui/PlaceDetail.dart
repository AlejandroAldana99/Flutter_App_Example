import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:niteclub/core/models/place_model.dart';
//import 'package:niteclub/core/utils/currency_utils.dart';
//import 'package:resto/core/viewmodels/restaurant_provider.dart';
import 'package:niteclub/ui/utils/highlight.dart';
import 'package:niteclub/ui/utils/custom_rating.dart';

class PlaceDetailScreen extends StatelessWidget {
  PlaceModel place;
  PlaceDetailScreen({
    @required this.place
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      body: PlaceDetailBody(
        place: place,
      ),
    );
  }
}

class PlaceDetailBody extends StatefulWidget {
  PlaceModel place;
  PlaceDetailBody({
    @required this.place
  });

  @override
  _PlaceDetailBodyState createState() => _PlaceDetailBodyState();
}

class _PlaceDetailBodyState extends State<PlaceDetailBody> {

  Color iconBackColor = Colors.white;
  Color textColor = Colors.white;
  Color backgroundColor = Colors.transparent;

  ScrollController scrollController;
  _scrollListener() {
    if (scrollController.offset >= 100) {
      setState(() {
        iconBackColor = Colors.black87;
        textColor = Colors.black87;
        backgroundColor = Colors.white;
      });
    } else {
      setState(() {
        iconBackColor = Colors.white;
        textColor = Colors.white;
        backgroundColor = Colors.transparent;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(_scrollListener);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            controller: scrollController,
            child: _content()
        ),
        _appBar(),
      ],
    );
  }

  Widget _appBar() {
    return Builder(
      builder: (context) {
        return Column(
          children: <Widget>[
            Container(
              height: 24,
              color: backgroundColor,
            ),
            Container(
              height: 50,
              color: backgroundColor,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: iconBackColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      widget.place.Name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _content() {
    return Container(
      child: Column(
        children: <Widget>[
          _imageCover(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 5),
                CustomRating(
                  rating: widget.place.Rate.toDouble(),
                  review: 180,
                ),
                SizedBox(height: 15),
                _title(),
                SizedBox(height: 5),
                _type(),
                SizedBox(height: 5),
                _address(),
                SizedBox(height: 5),
                _price(),
                Divider(color: Colors.black12),
                _tops(),
                SizedBox(height: 5),
                Highlight(
                  highlight: widget.place.Menu,
                ),
                Divider(color: Colors.black12),
                SizedBox(height: 10),
                _addressFull(),
                SizedBox(height: 15),
                _openTime(),
                SizedBox(height: 10),
                Divider(color: Colors.black12),
                SizedBox(height: 15),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _imageCover() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
            image: NetworkImage(widget.place.ImgRef),
            fit: BoxFit.cover
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      widget.place.Name,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 18
      ),
    );
  }

  Widget _type() {
    return Text(
      widget.place.Type,
      style: TextStyle(
          color: Colors.black87,
          fontSize: 12
      ),
    );
  }

  Widget _address() {
    Map<String, dynamic> x = widget.place.Address;
    String direction = x["Street"];
    return Text(
      direction,
      style: TextStyle(
          color: Colors.black87,
          fontSize: 12
      ),
    );
  }

  Widget _price() {
    return Text(
      "${widget.place.Cover} / person",
      style: TextStyle(
          color: Colors.green,
          fontSize: 14,
          fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _tops() {
    return Text(
      "Destacados",
      style: TextStyle(
        color: Colors.black87,
        fontSize: 15,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _addressFull() {
    Map<String, dynamic> x = widget.place.Address;
    String direction = x["Street"] + ", " + x["Neighborhood"] + ", " + x["CP"].toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Dirección",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 5),
        Text(
          direction,
          style: TextStyle(
              color: Colors.black87,
              fontSize: 12
          ),
        ),
      ],
    );
  }

  Widget _openTime() {
    var x = widget.place.Schudule;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Horario",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 5),
        Text(
          "Monday: ${x["Monday"]}",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 12
          ),
        ),
        Text(
          "Tuesday: ${x["Tuesday"]}",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 12
          ),
        ),
        Text(
          "Wednesday: ${x["Wednesday"]}",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 12
          ),
        ),
        Text(
          "Thursday: ${x["Thursday"]}",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 12
          ),
        ),
        Text(
          "Friday: ${x["Friday"]}",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 12
          ),
        ),
        Text(
          "Saturday: ${x["Saturday"]}",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 12
          ),
        ),
        Text(
          "Sunday: ${x["Sunday"]}",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 12
          ),
        ),
      ],
    );
  }

}