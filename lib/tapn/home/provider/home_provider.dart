import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:tapn_assignment/tapn/home/model/latlng.dart';
import 'package:tapn_assignment/tapn/home/widget/marker.dart';

class HomeProvider extends ChangeNotifier {
  final Set<Marker> _markerList = <Marker>{};
  Set<Marker> get getMarkerListValue => _markerList;

  bool _isBalloonVisible = false;
  bool get isBalloonVisibleValue => _isBalloonVisible;

  bool _isZoomIn = false;
  bool get isisZoomInValue => _isZoomIn;

  void addMarker(ScreenCoordinate sourceCoOrdinate, Widget buildSourceWidget,
      ScreenCoordinate destinationCoOrdinate, Widget buildDestinationWidget,
      {Function()? onCloseTap}) {
    //  we will create the Marker for Source and Destination

    final source = createMarker(sourceCoOrdinate,
        LatLng(lat: 40.712772, lng: -74.006058), "source", buildSourceWidget);

    final destination = createMarker(
        destinationCoOrdinate,
        LatLng(lat: 40.706005, lng: -74.008827),
        "destination",
        buildDestinationWidget,
        onCloseTap: onCloseTap);

    // Add the new marker to list
    _markerList.add(source);

    _markerList.add(destination);

    // Trigger ui refresh
    notifyListeners();
  }

  Marker createMarker(ScreenCoordinate sourceCoOrdinate, LatLng geoCoordinate,
      String id, Widget child,
      {Function()? onCloseTap}) {
    // We create the marker widget with the required data

    return Marker(
      position: sourceCoOrdinate, // the screen position
      geoCoordinate: geoCoordinate, // the geospatial position
      id: id, // the id (feel free to change)
      onCloseTap: onCloseTap, // the close Tap on BottomNavigation
      child: child, // My Widget I want to show on the map
    );
  }

  Future<void> updateMarkersPosition(
      MapboxMap? mapboxMap, BuildContext context) async {
    // We check if any marker is present
    if (_markerList.isNotEmpty) {
      for (var m in _markerList) {
        /* For ever marker previously added
          we ask the mapboxcontroller to give the screenCoordinate corresponding to the geospatial coordinate
         */
        final screenCoordinate = await mapboxMap?.pixelForCoordinate(Point(
                coordinates: Position(m.geoCoordinate.lng, m.geoCoordinate.lat))
            .toJson());

        m.screenPosition.value = screenCoordinate!;
        // And finally we request a ui refresh
        notifyListeners();
      }
    }
  }

  void isBalloonVisible(bool value) {
    _isBalloonVisible = value;
    notifyListeners();
  }

  void isZoomInVisible(bool value) {
    _isZoomIn = value;
    notifyListeners();
  }
}
