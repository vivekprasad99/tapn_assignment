import 'package:flutter/material.dart';

void showDestinationBottomSheet(BuildContext context, Function() onCloseTap) {
  showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (_) {
        return ShowBottomSheet(onCloseTap);
      });
}

class ShowBottomSheet extends StatelessWidget {
  final Function() onCloseTap;
  const ShowBottomSheet(this.onCloseTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
        padding: const EdgeInsets.fromLTRB(
          32,
          32,
          16,
          32,
        ),
        child: buildTextandButton());
  }

  Widget buildTextandButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Bottom Sheet Container",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0XFFFFD2D2)),
            onPressed: () {
              onCloseTap();
            },
            child: const Text(
              "CLOSE",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    );
  }
}
