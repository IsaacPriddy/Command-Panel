import 'package:flutter/material.dart';


// ignore: constant_identifier_names
enum OrderType { CommandToken, Regular, Lieutenant, Irregular, Impetuous }

extension OrderTypeExtension on OrderType {
  String get imagePath {
    switch (this) {
      case OrderType.CommandToken:
        return "assets/tokens/command.png";
      case OrderType.Lieutenant:
        return "assets/tokens/lieutenant.png";
      case OrderType.Regular:
        return "assets/tokens/regular.png";
      case OrderType.Irregular:
        return "assets/tokens/irregular.png";
      case OrderType.Impetuous:
        return "assets/tokens/impetuous.png";
    }
  }

  String get greyImagePath {
    switch (this) {
      case OrderType.CommandToken:
        return "assets/tokens/command_grey.png";
      case OrderType.Lieutenant:
        return "assets/tokens/lieutenant_grey.png";
      case OrderType.Regular:
        return "assets/tokens/regular_grey.png";
      case OrderType.Irregular:
        return "assets/tokens/irregular_grey.png";
      case OrderType.Impetuous:
        return "assets/tokens/impetuous_grey.png";
    }
  }

  Color get backgroundColor {
    switch (this) {
      case OrderType.CommandToken:
        return Colors.purple.shade800;
      case OrderType.Lieutenant:
        return Colors.blue.shade800;
      case OrderType.Regular:
        return Colors.green.shade800;
      case OrderType.Irregular:
        return Colors.yellow.shade800;
      case OrderType.Impetuous:
        return Colors.red.shade800;
    }
  }
}


class OrderToggleButton extends StatefulWidget {
  // Add necessary parameters for your toggle button
  final bool defaultValue;
  final String normalImage;
  final String greyImage;
  final OrderType orderType;
  final Color backgroundColor;
  final ValueChanged<bool>? onChanged;

  const OrderToggleButton({
    Key? key,
    required this.defaultValue,
    required this.normalImage,
    required this.greyImage,
    required this.orderType,
    required this.backgroundColor,
    this.onChanged,
  }) : super(key: key);

  @override
  OrderToggleButtonState createState() => OrderToggleButtonState();
}

class OrderToggleButtonState extends State<OrderToggleButton> {
  bool isToggled = false; // Is later set by defaultValue

  @override
  void initState() {
    super.initState();
    isToggled = widget.defaultValue;
  }

  @override
  void didUpdateWidget(covariant OrderToggleButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.defaultValue != widget.defaultValue) {
      isToggled = widget.defaultValue;
    }
  }

  void reset() {
    setState(() {
      isToggled = widget.defaultValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isToggled = !isToggled;
          widget.onChanged?.call(isToggled);
        });
      },
      child: Container(
        width: 90.0,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey,
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0.0,
              right: 0.0,
              child: Container(
                width: 90.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: isToggled ? widget.backgroundColor : Colors.grey.shade700,
                ),
              ),
            ),
            Positioned(
              left: isToggled ? 0.0 : 45.0,
              child: Container(
                width: 45.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: isToggled ? widget.backgroundColor : Colors.grey.shade700,
                ),
                child: Center(
                  child: Image.asset(
                    isToggled ? widget.normalImage : widget.greyImage,
                    width: 30.0,
                    height: 30.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
