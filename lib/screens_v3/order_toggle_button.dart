import 'package:flutter/material.dart';

class OrderToggleButton extends StatefulWidget {
  // Add necessary parameters for your toggle button
  final bool defaultValue;
  final String normalImage;
  final String greyImage;
  final ValueChanged<bool>? onChanged;

  const OrderToggleButton({super.key, 
    required this.defaultValue,
    required this.normalImage,
    required this.greyImage,
    this.onChanged,
  });

  @override
  _OrderToggleButtonState createState() => _OrderToggleButtonState();
}

class _OrderToggleButtonState extends State<OrderToggleButton> {
  bool isToggled = false;

  @override
  void initState() {
    super.initState();
    isToggled = widget.defaultValue;
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
                  color: isToggled ? Colors.green[800] : Colors.grey.shade700,
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
                  color: isToggled ? Colors.green[800] : Colors.grey.shade700,
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
