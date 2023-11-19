import 'package:flutter/material.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

class SourceDetail extends StatefulWidget {
  final bool? isChanged;
  const SourceDetail(this.isChanged, {super.key});

  @override
  State<SourceDetail> createState() => _SourceDetailState();
}

class _SourceDetailState extends State<SourceDetail> {
  @override
  Widget build(BuildContext context) {
    return ShapeOfView(
      shape: BubbleShape(
          position: BubblePosition.Top,
          arrowPositionPercent: 0.5,
          borderRadius: 80,
          arrowHeight: 10,
          arrowWidth: 10),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: Image.asset(
                "assets/image/avatar_vector.png",
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Visibility(
              visible: !widget.isChanged!,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "You are here",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Farmsville says hi",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
