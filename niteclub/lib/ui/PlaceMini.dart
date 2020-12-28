import 'package:flutter/material.dart';
import 'package:niteclub/ui/utils/custom_rating.dart';

import 'package:niteclub/core/models/place_model.dart';
import 'package:niteclub/ui/router/routing.dart';
import 'package:niteclub/ui/utils/constant.dart';

class PlaceMiniItem extends StatefulWidget {

  PlaceModel place;
  PlaceMiniItem({
    @required this.place
  });

  @override
  _PlaceMiniItemState createState() => _PlaceMiniItemState();
}

class _PlaceMiniItemState extends State<PlaceMiniItem> {

  bool isLongPress = false;
  double marginVertical = 5;
  double marginHorizontal = 0;
  void onLongPress() {
    setState(() {
      isLongPress = true;
      marginVertical = 25;
      marginHorizontal = 25;
    });
  }

  void onLongPressEnd() {
    setState(() {
      marginVertical = 5;
      marginHorizontal = 0;
    });
  }

  void onClick() async {
    //await Provider.of<PlaceProvider>(context, listen: false).clearReview();
    Navigator.pushNamed(context, RouterGenerator.routeDetailPlace,
        arguments: widget.place);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      onLongPress: () => onLongPress(),
      onLongPressEnd: (val) => onLongPressEnd(),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        width: deviceWith(context),
        margin: EdgeInsets.symmetric(vertical: marginVertical, horizontal: marginHorizontal),
        // margin: EdgeInsets.only(bottom: 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _imageRestaurant(),
                SizedBox(width: 10),
                _content()
              ],
            ),
            Divider(color: Colors.black12),
          ],
        ),
      ),
    );
  }

  Widget _imageRestaurant() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
              image: NetworkImage(widget.place.ImgRef),
              fit: BoxFit.cover
          )
      ),
    );
  }

  Widget _content() {
    var x = widget.place.Address;
    String direction = x["Street"];
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.place.Name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: 5),
          CustomRating(
            rating: widget.place.Rate.toDouble(),
            useReview: false,
          ),
          SizedBox(height: 5),
          Text(
            direction,
            style: TextStyle(
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}