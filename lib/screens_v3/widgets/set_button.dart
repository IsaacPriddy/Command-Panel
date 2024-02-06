import 'package:flutter/material.dart';
import 'common_widgets.dart'; // Import PlayScreen to access the Orders class
import '../play_screen.dart';

ElevatedButton setButton(double h, double w, BuildContext context, VoidCallback onPressed, Orders orders, VoidCallback onSetPressed) {
  CommonWidgets commonWidgets = CommonWidgets(); // For the button style, cuts down on code

  // Actually builds the button that is called in play_screen
  return ElevatedButton(
    onPressed: () {
      // Display the SetScreen with orders data
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return _SetScreen(
            orders: orders,
            onSetPressed: onSetPressed,
          );
        },
      );
    },
    style: commonWidgets.customButtonStyle(height: h*1.8, width: w),
    child: const Text('Set Orders'),
  );
}

class _SetScreen extends StatefulWidget {
  final Orders orders;
  final Function()? onSetPressed;

  const _SetScreen({Key? key, required this.orders, this.onSetPressed}) : super(key: key);

  @override
  _SetScreenState createState() => _SetScreenState();
}

class _SetScreenState extends State<_SetScreen> {
  CommonWidgets commonWidgets = CommonWidgets(); // For the button style, cuts down on code
  late Orders _originalOrders; // To store a copy of the original orders

  @override
  void initState() {
    super.initState();
    // Initialize the copy of the original orders
    _originalOrders = Orders.copy(widget.orders);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Display the number of orders for each type
        children: [
          buildOrderRow("Lieutenant Orders", widget.orders.lieutenantOrders),
          buildOrderRow("Regular Orders", widget.orders.regularOrders),
          buildOrderRow("Irregular Orders", widget.orders.irregularOrders),
          buildOrderRow("Impetuous Orders", widget.orders.impetuousOrder),
        ],
      ),
      actions: [
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            // THE SET ORDERS BUTTON
            ElevatedButton(
              onPressed: () {
                // Handle set button press
                // Update the original orders
                _originalOrders = Orders.copy(widget.orders);

                // Invoke a callback
                widget.onSetPressed?.call();

                // Dismiss the dialog
                Navigator.pop(context);
              },
              style: commonWidgets.customButtonStyle(),
              child: const Text('Set'),
            ),
            // THE CLOSE BUTTON
            ElevatedButton(
              onPressed: () {
                // Handle close button press
                // Revert to the original orders when close is pressed
                widget.orders.lieutenantOrders = _originalOrders.lieutenantOrders;
                widget.orders.regularOrders = _originalOrders.regularOrders;
                widget.orders.irregularOrders = _originalOrders.irregularOrders;
                widget.orders.impetuousOrder = _originalOrders.impetuousOrder;

                // Dismiss the dialog
                Navigator.pop(context);
              },
              style: commonWidgets.customButtonStyle(),
              child: const Text('Close'),
            ),
          ]
        ),
      ],
    );
  }

  Widget buildOrderRow(String orderType, int orderCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$orderType: "),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  // Decrement the order count, but ensure it doesn't go below 0
                  switch (orderType) {
                    case "Lieutenant Orders":
                      widget.orders.lieutenantOrders =
                          widget.orders.lieutenantOrders > 0 ? widget.orders.lieutenantOrders - 1 : 0;
                      break;
                    case "Regular Orders":
                      widget.orders.regularOrders =
                          widget.orders.regularOrders > 0 ? widget.orders.regularOrders - 1 : 0;
                      break;
                    case "Irregular Orders":
                      widget.orders.irregularOrders =
                          widget.orders.irregularOrders > 0 ? widget.orders.irregularOrders - 1 : 0;
                      break;
                    case "Impetuous Orders":
                      widget.orders.impetuousOrder =
                          widget.orders.impetuousOrder > 0 ? widget.orders.impetuousOrder - 1 : 0;
                      break;
                  }
                });
              },
            ),
            Text("$orderCount"),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  // Increment the order count
                  switch (orderType) {
                    case "Lieutenant Orders":
                      widget.orders.lieutenantOrders++;
                      break;
                    case "Regular Orders":
                      widget.orders.regularOrders++;
                      break;
                    case "Irregular Orders":
                      widget.orders.irregularOrders++;
                      break;
                    case "Impetuous Orders":
                      widget.orders.impetuousOrder++;
                      break;
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
