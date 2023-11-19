import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as map;
import 'package:tapn_assignment/tapn/core/widget/bottom_sheet/show_bottom_sheet.dart';
import 'package:tapn_assignment/tapn/home/model/latlng.dart';

class Marker extends StatefulWidget {
  // The widget position on the UI
  final ValueNotifier<map.ScreenCoordinate> screenPosition;
  // The Marker id
  final String id;
  // The marker geo data
  final LatLng geoCoordinate;
  // Your widget which you want to show
  final Widget child;
  final Function()? onCloseTap;

  Marker({
    super.key,
    required map.ScreenCoordinate position,
    required this.geoCoordinate,
    required this.child,
    required this.id,
    this.onCloseTap,
  }) : screenPosition = ValueNotifier(position);

  @override
  MarkerState createState() => MarkerState();
}

class MarkerState extends State<Marker> {
  MarkerState();
  bool? isVisible = true;

  @override
  void dispose() {
    widget.screenPosition.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.screenPosition,
      builder: (context, pos, child) {
        return Positioned(
          left: pos.x,
          top: pos.y,
          child: InkWell(
            onTap: () {
              if (widget.id == "destination") {
                showDestinationBottomSheet(context, widget.onCloseTap!);
              }
            },
            child: widget.child,
          ),
        );
      },
    );
  }
}
