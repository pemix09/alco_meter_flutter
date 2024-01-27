import 'package:alco_meter_flutter/data/enums/direction.dart';
import 'package:alco_meter_flutter/presentation/components/texts/small_text.dart';
import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  final void Function() onPressed;
  final Direction arrowDirection;

  const ArrowButton(
      {super.key, required this.onPressed, required this.arrowDirection});

  @override
  Widget build(BuildContext context) {
    return arrowDirection == Direction.next
        ? Row(
            children: [
              const SmallText(text: 'go next'),
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.arrow_forward_ios),
                color: Colors.white,
              ),
            ],
          )
        : Row(
            children: [
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
              ),
              const SmallText(text: 'go back')
            ],
          );
  }
}
