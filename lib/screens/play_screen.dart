import 'package:flutter/material.dart';


class Orders{
  int commandTokens = 4; // default number everyone gets
  int lieutenantOrders = 0;
  int regularOrders = 0;
  int irregularOrders = 0;
  int impetuousOrder = 0;
}

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  PlayScreenState createState() => PlayScreenState();
}

class PlayScreenState extends State<PlayScreen> {
  final Orders _orders = Orders();

  @override
  Widget build(BuildContext context) {
    // These are here so that the size dynamically changes with the size of the phone
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    // debugPrint("The width is: $screenWidth\nThe height is: $screenHeight");

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
            const SizedBox(height: 16.0), // SPACER
            Row(
              // BUTTON ROW
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                setButton(screenHeight, screenWidth, 'Set'), 
                resetButton(screenHeight, screenWidth, 'Reset'),
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
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end, 
                  children: [
                    Text("Current Irregular Orders: ${_orders.irregularOrders}"), 
                    Text("Current Impetuous Order: ${_orders.impetuousOrder}")
                  ],
                ),
              ]
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
            content: Column(
              children: [
                // Add your content here
                buildOrderRow('Lieutenant Orders', _orders.lieutenantOrders),
                buildOrderRow('Regular Orders', _orders.regularOrders),
                buildOrderRow('Irregular Orders', _orders.irregularOrders),
                buildOrderRow('Impetuous Orders', _orders.impetuousOrder),
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
    // TODO: Change from reseting to defaults to untagging orders
    // Initially was to reset to default values
    // Instead will unTap all orders on the menu
    return createButton(
      h, w, buttonText,
      onPressed: () {
        setState(() {
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
        fixedSize: Size(h * 0.25, w * 0.12), // was 200, 50
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

  // SET VALUES IN POPUP WINDOW
  Widget buildOrderRow(String label, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, textAlign: TextAlign.start,),
        Row(
          children: [
            IconButton(onPressed: () => decreaseOrder(label), icon: const Icon(Icons.remove)),
            Text('$value', textAlign: TextAlign.end,),
            IconButton(onPressed: () => increaseOrder(label), icon: const Icon(Icons.add)),
          ],
        )
      ],
    );
  }

  void increaseOrder(String label) {
    setState(() {
      switch (label) {
        case 'Lieutenant Orders':
          _orders.lieutenantOrders++;
          break;
        case 'Regular Orders':
          _orders.regularOrders++;
          break;
        case 'Irregular Orders':
          _orders.irregularOrders++;
          break;
        case 'Impetuous Orders':
          _orders.impetuousOrder++;
          break;
      }
    });
  }

  void decreaseOrder(String label) {
    setState(() {
      switch (label) {
        case 'Lieutenant Orders':
          _orders.lieutenantOrders = (_orders.lieutenantOrders > 0) ? _orders.lieutenantOrders - 1 : 0;
          break;
        case 'Regular Orders':
          _orders.regularOrders = (_orders.regularOrders > 0) ? _orders.regularOrders - 1 : 0;
          break;
        case 'Irregular Orders':
          _orders.irregularOrders = (_orders.irregularOrders > 0) ? _orders.irregularOrders - 1 : 0;
          break;
        case 'Impetuous Orders':
          _orders.impetuousOrder = (_orders.impetuousOrder > 0) ? _orders.impetuousOrder - 1 : 0;
          break;
      }
    });
  }
}