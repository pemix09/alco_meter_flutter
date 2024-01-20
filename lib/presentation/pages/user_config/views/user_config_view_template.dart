import 'package:alco_meter_flutter/app/enums/direction.dart';
import 'package:alco_meter_flutter/presentation/components/buttons/direction_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class UserConfigViewTemplate extends StatelessWidget {
  final void Function(Direction) onChangeViewClicked;
  final String title;
  final Widget content;

  const UserConfigViewTemplate({
    super.key,
    required this.title,
    required this.content,
    required this.onChangeViewClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(title),
          content,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DirectionButton(
                  onPressed: () => onChangeViewClicked(Direction.previous),
                  arrowDirection: Direction.previous),
              DirectionButton(
                  onPressed: () => onChangeViewClicked(Direction.next), arrowDirection: Direction.next), 
            ],
          ).padding(all: 10)
        ],
      ),
    );
  }
}
