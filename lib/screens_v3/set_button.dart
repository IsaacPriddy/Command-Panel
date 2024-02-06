// set_button.dart

import 'package:flutter/material.dart';

Widget setButton(BuildContext context, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    child: const Text('Set'),
  );
}

class SetScreen extends StatelessWidget {
  const SetScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set Orders'),
      content: const Column(
        // Add UI elements for regular, lieutenant, irregular, and impetuous orders
      ),
      actions: [
        setButton(
          context,
          () {
            // Handle set button press
            // You may need to pass data back to PlayScreen
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          onPressed: () {
            // Handle close button press
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
