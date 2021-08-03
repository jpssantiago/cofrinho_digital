import 'package:flutter/material.dart';

const double itemWidth = 180;
const double itemHeight = 122;

class GoalItem extends StatelessWidget {
  const GoalItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: itemWidth,
        height: itemHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              color: Colors.black.withOpacity(.25),
            ),
          ],
        ),
      ),
    );
  }
}
