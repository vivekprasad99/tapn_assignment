import 'package:flutter/widgets.dart';
import 'package:tapn_assignment/tapn/home/widget/marker.dart';

class MapMarkers extends StatelessWidget {
  final List<Marker> markers;
  const MapMarkers({super.key, required this.markers});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: markers,
    );
  }
}
