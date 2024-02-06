import 'package:flutter/material.dart';
import 'order_toggle_button.dart';
import 'orders.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  List<OrderToggleButton> orderToggleButtons = [];
  final Orders _orders = Orders(); // FOR TESTING TODO: Remove later

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
        child: playScreenMainBody(screenHeight, screenWidth)
      ),
      bottomNavigationBar: Container(
        // Here to be used for whatever I might need in the future
        height: screenHeight * 0.0878, // was 60.0
      ),
    );
  }

  Widget playScreenMainBody(double h, double w) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8.0), // SPACER
        // THE SET AND RESET BUTTON
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            createButton(h, w, "Set", onPressed: () => ''),
            createButton(h, w, "Reset", onPressed: () => ''),
          ],
        ),
        const SizedBox(height: 16.0), // SPACER
        // THE TOGGLE BUTTONS ROW/COLUMNS
        Row(
          // TODO: Make the number of columns and toggle buttons dynamic
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                regularOrderToggle(),
                const SizedBox(height: 16.0), // SPACER
                regularOrderToggle(),
                const SizedBox(height: 16.0), // SPACER
                regularOrderToggle(),
              ],
            ),
            Column(
              children: [
                regularOrderToggle(),
                const SizedBox(height: 16.0), // SPACER
                regularOrderToggle(),
                const SizedBox(height: 16.0), // SPACER
                regularOrderToggle(),
              ],
            ),                
          ],
        ),
        const SizedBox(height: 16.0), // SPACER
        Column(
          children: [
            Text("The current lieutenantOrders: ${_orders.lieutenantOrders}"),
            Text("The current regularOrders: ${_orders.regularOrders}"),
            Text("The current irregularOrders: ${_orders.irregularOrders}"),
            Text("The current impetuousOrder: ${_orders.impetuousOrder}"),
          ],
        ),
        createButton(h*2, w, "Add Regular", onPressed: addRegularOrder) // NOT CURRENTLY WORKING TODO: Remove
      ],
    );
  }

  // OTHER FUNCTIONS
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

  Widget regularOrderToggle() {
    return const OrderToggleButton(
      defaultValue: true,
      normalImage: "assets/tokens/regular.png",
      greyImage: "assets/tokens/regular_grey.png",
      orderType: OrderType.Regular,
    );
  }

  // TODO: Remove this when Add Regular button is removed
  void addRegularOrder() {
    setState(() {
      _orders.regularOrders++;
    });
  }
}
