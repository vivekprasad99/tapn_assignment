import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:tapn_assignment/tapn/core/utils/constants.dart';
import 'package:tapn_assignment/tapn/home/provider/home_provider.dart';
import 'package:tapn_assignment/tapn/home/widget/destinationDetail.dart';
import 'package:tapn_assignment/tapn/home/widget/marker_list.dart';
import 'package:tapn_assignment/tapn/home/widget/sourceDetail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  MapboxMap? mapboxMap;
  late AnimationController _controller;
  late Animation<Offset> _animation;
  final StreamController<bool> isScrolledStream = StreamController<bool>();
  double zoomValue = 14.0;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, -1),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map Box SDK"),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Stack(
      children: [
        buildMapWidget(context),
        builMapMarkersdWidget(),
        buildBalloonAnimationWidget()
      ],
    );
  }

  Widget buildMapWidget(BuildContext context) {
    return MapWidget(
      resourceOptions: ResourceOptions(
        accessToken: Constants.mapBoxSdkPublicKey,
      ),
      onCameraChangeListener: (cameraChangedEventData) {
        context.read<HomeProvider>().updateMarkersPosition(mapboxMap, context);
        mapboxMap?.getCameraState().then((value) {
          if (value.zoom > zoomValue) {
            context.read<HomeProvider>().isZoomInVisible(true);
          }
        });
      },
      onScrollListener: (scrollListner) {
        isScrolledStream.sink.add(true);
      },
      mapOptions:
          MapOptions(pixelRatio: MediaQuery.of(context).devicePixelRatio),
      styleUri: MapboxStyles.MAPBOX_STREETS,
      cameraOptions: CameraOptions(
        zoom: zoomValue,
        center: Point(coordinates: Position(-74.006058, 40.712772)).toJson(),
      ),
      textureView: true,
      onMapCreated: _onMapCreated,
    );
  }

  Widget builMapMarkersdWidget() {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider value, Widget? child) {
        return MapMarkers(
          markers: value.getMarkerListValue.toList(),
        );
      },
    );
  }

  Widget buildSourceWidget() {
    return Column(
      children: [
        Image.asset(
          "assets/image/circle.png",
          height: 28,
          width: 28,
        ),
        StreamBuilder<bool>(
            stream: isScrolledStream.stream,
            builder: (context, snapshot) {
              return SourceDetail(snapshot.hasData ? snapshot.data : false);
            }),
      ],
    );
  }

  Widget buildBalloonAnimationWidget() {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider value, Widget? child) {
        return value.isBalloonVisibleValue
            ? SlideTransition(
                position: _animation,
                child: Image.asset(
                  'assets/image/balloon.png',
                  height: 100,
                  width: 100,
                ),
              )
            : const SizedBox();
      },
    );
  }

  Widget buildDestinationWidget() {
    return Consumer<HomeProvider>(
        builder: (BuildContext context, HomeProvider value, Widget? child) {
      return value.isisZoomInValue
          ? const DestinationDetail()
          : Image.asset(
              "assets/image/tree.png",
              height: 40,
              width: 40,
            );
    });
  }

  _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;

    // I have put the dummy Source CoOrdinate with the help of mapboxMap Controller
    final sourceCoOrdinate = await mapboxMap.pixelForCoordinate(
        Point(coordinates: Position(-74.006058, 40.712772)).toJson());

    // I have put the dummy Destination CoOrdinate with the help of mapboxMap Controller
    final destinationCoOrdinate = await mapboxMap.pixelForCoordinate(
        Point(coordinates: Position(-74.008827, 40.706005)).toJson());

    //  we will add the marker
    context.read<HomeProvider>().addMarker(sourceCoOrdinate,
        buildSourceWidget(), destinationCoOrdinate, buildDestinationWidget(),
        onCloseTap: onCloseTap);
  }

  onCloseTap() {
    Navigator.pop(context);
    context.read<HomeProvider>().isBalloonVisible(true);
    _controller.reset();
    _controller.forward();
  }
}
