import 'package:flutter/material.dart';

class OrderToggleButton extends StatefulWidget {
  final bool value;
  final String coloredImagePath;
  final String greyedOutImagePath;

  const OrderToggleButton({
    Key? key,
    required this.value,
    required this.coloredImagePath,
    required this.greyedOutImagePath,
  }) : super(key: key);

  @override
  _OrderToggleButtonState createState() => _OrderToggleButtonState();
}

class _OrderToggleButtonState extends State<OrderToggleButton> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _value = !_value;
        });
      },
      child: _value
          ? Image.asset(widget.coloredImagePath)
          : Image.asset(widget.greyedOutImagePath),
    );
  }

  void reset() {
    setState(() {
      _value = false;
    });
  }
}
