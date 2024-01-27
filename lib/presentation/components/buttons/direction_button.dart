import 'package:alco_meter_flutter/data/enums/direction.dart';
import 'package:flutter/material.dart';

class DirectionButton extends StatelessWidget {
  final void Function() onPressed;
  final Direction arrowDirection;
  final String title;

  const DirectionButton(
      {super.key,
      required this.arrowDirection,
      required this.onPressed,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        children: arrowDirection == Direction.next
            ? [
                Text(title),
                const Icon(Icons.arrow_forward_ios),
              ]
            : [
                const Icon(Icons.arrow_back_ios),
                Text(title),
              ],
      ),
    );
  }
}
