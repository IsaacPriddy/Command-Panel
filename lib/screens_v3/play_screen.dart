import 'package:flutter/material.dart';
import 'order_toggle_button.dart';
// import 'set_button.dart';


class Orders {
  int commandTokens = 4;
  int lieutenantOrders = 0;
  int regularOrders = 0;
  int irregularOrders = 0;
  int impetuousOrder = 0;
}

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  // VARIABLES, INITIALIZERS AND UPPDATERS
  List<OrderToggleButton> orderToggleButtons = [];
  final List<GlobalKey<OrderToggleButtonState>> _toggleButtonKeys = [];
  final Orders _orders = Orders();

  void updateToggleKeys() {
    _toggleButtonKeys.clear();
    _toggleButtonKeys.addAll(List.generate(
      _orders.regularOrders,
      (index) => GlobalKey<OrderToggleButtonState>(),
    ));
  }
  
  @override
  void initState() {
    super.initState();
    updateToggleKeys();
  }

  // THE BUILD
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
            resetToggleButtons(h, w, "Reset"),
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
                lieutenantOrderToggle(),
                const SizedBox(height: 16.0), // SPACER
                lieutenantOrderToggle(),
                const SizedBox(height: 16.0), // SPACER
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
                const SizedBox(height: 16.0), // SPACER
                irregularOrderToggle(),
                const SizedBox(height: 16.0), // SPACER
                irregularOrderToggle(),
                const SizedBox(height: 16.0), // SPACER
                impteuousOrderToggle(),
                const SizedBox(height: 16.0), // SPACER
              ],
            ),                
          ],
        ),
        const SizedBox(height: 16.0), // SPACER
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

  Widget resetToggleButtons(double h, double w, String buttonText) {
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

  // ORDER BUTTONS
  Widget lieutenantOrderToggle() {
    OrderToggleButton toggleButton = OrderToggleButton(
      key: GlobalKey<OrderToggleButtonState>(), // Add key here
      defaultValue: true,
      normalImage: "assets/tokens/lieutenant.png",
      greyImage: "assets/tokens/lieutenant_grey.png",
      orderType: OrderType.Lieutenant,
      backgroundColor: Colors.blue.shade800,
    );

    _toggleButtonKeys.add(GlobalKey<OrderToggleButtonState>()); // Add key to the list

    return toggleButton;
  }

  Widget regularOrderToggle() {
    OrderToggleButton toggleButton = OrderToggleButton(
      key: GlobalKey<OrderToggleButtonState>(), // Add key here
      defaultValue: true,
      normalImage: "assets/tokens/regular.png",
      greyImage: "assets/tokens/regular_grey.png",
      orderType: OrderType.Regular,
      backgroundColor: Colors.green.shade800,
    );

    _toggleButtonKeys.add(GlobalKey<OrderToggleButtonState>()); // Add key to the list

    return toggleButton;
  }

  Widget irregularOrderToggle() {
    OrderToggleButton toggleButton = OrderToggleButton(
      key: GlobalKey<OrderToggleButtonState>(), // Add key here
      defaultValue: true,
      normalImage: "assets/tokens/irregular.png",
      greyImage: "assets/tokens/irregular_grey.png",
      orderType: OrderType.Irregular,
      backgroundColor: Colors.yellow.shade800,
    );

    _toggleButtonKeys.add(GlobalKey<OrderToggleButtonState>()); // Add key to the list

    return toggleButton;
  }

  Widget impteuousOrderToggle() {
    OrderToggleButton toggleButton = OrderToggleButton(
      key: GlobalKey<OrderToggleButtonState>(), // Add key here
      defaultValue: true,
      normalImage: "assets/tokens/impetuous.png",
      greyImage: "assets/tokens/impetuous_grey.png",
      orderType: OrderType.Impetuous,
      backgroundColor: Colors.red.shade800,
    );

    _toggleButtonKeys.add(GlobalKey<OrderToggleButtonState>()); // Add key to the list

    return toggleButton;
  }

}
