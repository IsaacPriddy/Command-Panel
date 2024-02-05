import 'package:flutter/material.dart';

class CustomToggleButton extends StatefulWidget {
  final bool value;
  final String coloredImagePath;
  final String greyedOutImagePath;
  final ValueChanged<bool>? onChanged;

  const CustomToggleButton({
    Key? key,
    required this.value,
    required this.coloredImagePath,
    required this.greyedOutImagePath,
    this.onChanged,
  }) : super(key: key);

  @override
  CustomToggleButtonState createState() => CustomToggleButtonState();
}

class CustomToggleButtonState extends State<CustomToggleButton> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant CustomToggleButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _value = widget.value;
    }
  }

  void reset() {
    setState(() {
      _value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _value = !_value;
          widget.onChanged?.call(_value);
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
                  color: _value ? Colors.green[800] : Colors.grey.shade700,
                ),
              ),
            ),
            Positioned(
              left: _value ? 0.0 : 45.0,
              child: Container(
                width: 45.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: _value ? Colors.green[800] : Colors.grey.shade700,
                ),
                child: Center(
                  child: Image.asset(
                    _value ? widget.coloredImagePath : widget.greyedOutImagePath,
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
