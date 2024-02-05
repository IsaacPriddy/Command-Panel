import 'package:flutter/material.dart';
import 'toggle_button_old.dart';


class Orders{
  int commandTokens = 4; // default number everyone gets
  int lieutenantOrders = 0;
  int regularOrders = 0;
  int irregularOrders = 0;
  int impetuousOrder = 0;
}

enum OrderType { Regular, Lieutenant, Irregular, Impetuous }

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  PlayScreenState createState() => PlayScreenState();
}

class PlayScreenState extends State<PlayScreen> {
  final Orders _orders = Orders();
  final List<GlobalKey<CustomToggleButtonState>> _toggleButtonKeys = [];

  void updateToggleKeys() {
    _toggleButtonKeys.clear();
    _toggleButtonKeys.addAll(List.generate(
      _orders.regularOrders,
      (index) => GlobalKey<CustomToggleButtonState>(),
    ));
  }
  
  @override
  void initState() {
    super.initState();
    updateToggleKeys();
  }

  @override
  Widget build(BuildContext context) {
    // These are here so that the size dynamically changes with the size of the phone
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Command Panel'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          // Decoration for background image
          image: DecorationImage(
            image: AssetImage("assets/logos/logo_15.png"), 
            fit: BoxFit.contain,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8.0), // SPACER
            Row(
              // BUTTON ROW
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                setButton(screenHeight, screenWidth, 'Set'), 
                resetButton(screenHeight, screenWidth, 'Reset'),
                buildPopupMenuButton(context, OrderType.Regular),
              ]
            ),
            const SizedBox(height: 16.0), // SPACER
            Text('Command Tokens: ${_orders.commandTokens}'),
            Row(
              // ELEMENTS COLUMNS (The orders)
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Text("Current Lieutenant Orders: ${_orders.lieutenantOrders}"),
                    Text("Current Regular Orders: ${_orders.regularOrders}"),
                    Text("Current Irregular Orders: ${_orders.irregularOrders}"), 
                    Text("Current Impetuous Order: ${_orders.impetuousOrder}")
                  ],
                )
              ]
            ),
            // TODO: Fix below
            const SizedBox(height: 16.0), // SPACER
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < _toggleButtonKeys.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: CustomToggleButton(
                      key: _toggleButtonKeys[i],
                      value: true,
                      coloredImagePath: "assets/tokens/regular.png",
                      greyedOutImagePath: "assets/tokens/regular_grey.png",
                    ),
                  )
              ],
            ),
          ],
        )
      ),
      bottomNavigationBar: Container(
        // Here to be used for whatever I might need in the future
        height: screenHeight * 0.0878, // was 60.0
      ),
    );
  }

  // BUTTONS FOR SETTING VALUES AND RESETING
  Widget setButton(double h, double w, String buttonText) {
    return createButton(
      h, w, buttonText,
      onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text('Commands')),
            content: const Column(
              children: [
                // Add your content here
                Text("Stuff here"),
                Text("Stuff here"),
                Text("Stuff here"),
                Text("Stuff here"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the popup
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
    );
  }

  Widget resetButton(double h, double w, String buttonText) {
    return createButton(
      h, w, buttonText,
      onPressed: () {
        setState(() {
          for (var key in _toggleButtonKeys) {
            key.currentState?.reset();
          }

          _orders.commandTokens = 4;
          _orders.regularOrders = 0;
          _orders.lieutenantOrders = 0;
          _orders.irregularOrders = 0;
          _orders.impetuousOrder = 0;
        });
      }
    );
  }

  Widget createButton(double h, double w, String buttonText, {void Function()? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed, 
      style: ElevatedButton.styleFrom(
        fixedSize: Size(h * 0.18, w * 0.10),
        padding: EdgeInsets.all(w * 0.0234), // was 16
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.amber.shade50, width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.blueGrey.shade200,
        textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontFamily: 'Aquire',
        ),
      ),
      child: Text(buttonText)
    );
  }

  // FOR THE POPUP MENU
  Widget buildPopupMenuButton(BuildContext context, OrderType orderType) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: buildPopupMenuContent(context, orderType),
          ),
        ];
      },
    );
  }

  Widget buildPopupMenuContent(BuildContext context, OrderType orderType) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  // Use a switch statement to handle different order types
                  switch (orderType) {
                    case OrderType.Regular:
                      if (_orders.regularOrders > 0) {
                        _orders.regularOrders--;
                        updateToggleKeys(); // Call to update the toggle keys
                      }
                      break;
                    case OrderType.Lieutenant:
                      // Handle lieutenant orders
                      break;
                    case OrderType.Irregular:
                      // Handle irregular orders
                      break;
                    case OrderType.Impetuous:
                      // Handle impetuous orders
                      break;
                  }
                });
              },
            ),
            // Display order type and count
            Text("${orderType.toString().split('.').last} Orders: ${getOrderCount(orderType)}"),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  // Use a switch statement to handle different order types
                  switch (orderType) {
                    case OrderType.Regular:
                      _orders.regularOrders++;
                      updateToggleKeys(); // Call to update the toggle keys
                      break;
                    case OrderType.Lieutenant:
                      // Handle lieutenant orders
                      break;
                    case OrderType.Irregular:
                      // Handle irregular orders
                      break;
                    case OrderType.Impetuous:
                      // Handle impetuous orders
                      break;
                  }
                });
              },
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the popup
          },
          child: const Text('Done'),
        ),
      ],
    );
  }

  int getOrderCount(OrderType orderType) {
    switch (orderType) {
      case OrderType.Regular:
        return _orders.regularOrders;
      case OrderType.Lieutenant:
        return _orders.lieutenantOrders;
      case OrderType.Irregular:
        return _orders.irregularOrders;
      case OrderType.Impetuous:
        return _orders.impetuousOrder;
    }
  }
}