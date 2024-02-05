import 'package:flutter/material.dart';
// import 'order_toggle_button.dart';
import 'set_button.dart';

class Orders {
  int commandTokens = 4;
  int lieutenantOrders = 0;
  int regularOrders = 0;
  int irregularOrders = 0;
  int impetuousOrder = 0;
}

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  PlayScreenState createState() => PlayScreenState();
}

class PlayScreenState extends State<PlayScreen> {
  final Orders _orders = Orders();

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                createButton(screenHeight, screenWidth, "Set", onPressed: () => _openOrderSetDialog()),
                createButton(screenHeight, screenWidth, "Reset", onPressed: () => _resetOrders()),
              ],
            ),
            const SizedBox(height: 16.0), // SPACER
            const Text("A Row of 2-3 Columns goes here"),
            // Button test placement
          ]
        ),
      ),
      bottomNavigationBar: Container(
        // Here to be used for whatever I might need in the future
        height: screenHeight * 0.0878, // was 60.0
      ),
    );
  }

  // TOP ROW BUTTONS
  void _openOrderSetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SetButton(
          initialLieutenantOrders: _orders.lieutenantOrders,
          initialRegularOrders: _orders.regularOrders,
          initialIrregularOrders: _orders.irregularOrders,
          initialImpetuousOrder: _orders.impetuousOrder,
          onLieutenantOrdersChanged: (newCount) {
            setState(() {
              _orders.lieutenantOrders = newCount;
            });
          },
          onRegularOrdersChanged: (newCount) {
            setState(() {
              _orders.regularOrders = newCount;
            });
          },
          onIrregularOrdersChanged: (newCount) {
            setState(() {
              _orders.irregularOrders = newCount;
            });
          },
          onImpetuousOrderChanged: (newCount) {
            setState(() {
              _orders.impetuousOrder = newCount;
            });
          },
        );
      },
    );
  }

  void _resetOrders() {
    // Implement order reset logic here
    setState(() {
      // Reset orders to default values
      _orders.regularOrders = 0;
      // Reset other orders if needed
    });
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
}