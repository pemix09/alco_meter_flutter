import 'package:alco_meter_flutter/app/enums/direction.dart';
import 'package:flutter/material.dart';

class DirectionButton extends StatelessWidget {
  final void Function() onPressed;
  final Direction arrowDirection;

  const DirectionButton(
      {super.key, required this.arrowDirection, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: arrowDirection == Direction.next
          ? const Row(
              children: [
                Text('next'),
                Icon(Icons.arrow_forward_ios),
              ],
            )
          : const Row(
              children: [
                Icon(Icons.arrow_back_ios),
                Text('previous'),
              ],
            ),
    );
  }
}
