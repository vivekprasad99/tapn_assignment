import 'package:flutter/material.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

class DestinationDetail extends StatelessWidget {
  const DestinationDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return ShapeOfView(
      shape: BubbleShape(
          position: BubblePosition.Bottom,
          arrowPositionPercent: 0.5,
          borderRadius: 40,
          arrowHeight: 10,
          arrowWidth: 10),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: const Padding(
          padding: EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CircleAvatar(
              radius: 3,
              backgroundColor: Colors.red,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              "Wednesday - Farmers Market",
              style: TextStyle(color: Colors.black),
            ),
          ]),
        ),
      ),
    );
  }
}
