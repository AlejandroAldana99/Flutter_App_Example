import 'package:flutter/material.dart';
import 'package:niteclub/ui/utils/custom_rating.dart';
import 'package:provider/provider.dart';

import 'package:niteclub/core/models/place_model.dart';
import 'package:niteclub/ui/router/routing.dart';
import 'package:niteclub/ui/utils/constant.dart';


class PlaceItem extends StatefulWidget {
  PlaceModel place;
  PlaceItem({
    @required this.place
  });

  @override
  _PlaceItemState createState() => _PlaceItemState();
}

class _PlaceItemState extends State<PlaceItem> {

  bool isLongPress = false;
  double marginVertical = 10;
  double marginHorizontal = 0;
  void onLongPress() {
    setState(() {
      isLongPress = true;
      marginVertical = 25;
      marginHorizontal = 15;
    });
  }

  void onLongPressEnd() {
    setState(() {
      marginVertical = 10;
      marginHorizontal = 0;
    });
  }

  //* On click restaurant item then navigate to restaurant detail
  //* but we must clear previous review first
  void onClick() async {
    //await Provider.of<PlaceProvider>(context, listen: false).clearReview();
    Navigator.pushNamed(context, RouterGenerator.routeDetailPlace,
        arguments: widget.place);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      width: deviceWith(context),
      margin: EdgeInsets.symmetric(vertical: marginVertical, horizontal: marginHorizontal),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 9,
                spreadRadius: 1,
                color: Colors.black12.withOpacity(0.1)
            )
          ]
      ),
      child: GestureDetector(
        onTap: () => onClick(),
        onLongPress: () => onLongPress(),
        onLongPressEnd: (val) => onLongPressEnd(),
        child: Column(
          children: <Widget>[
            _imageCover(),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _title(),
                  SizedBox(height: 5),
                  CustomRating(
                    rating: widget.place.Rate.toDouble(),
                    //review: widget.place.review,
                  ),
                  SizedBox(height: 5),
                  _cuisines(),
                  SizedBox(height: 5),
                  _price()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageCover() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
              image: NetworkImage(widget.place.ImgRef),
              fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8)
          )
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
          fontSize: 16
      ),
    );
  }

  Widget _cuisines() {
    return Text(
      widget.place.Type,
      style: TextStyle(
          color: Colors.black45,
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
}