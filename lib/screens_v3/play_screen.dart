import 'package:flutter/material.dart';
import 'widgets/order_toggle_button.dart';
import 'widgets/set_button.dart';
import 'widgets/common_widgets.dart';

class Orders {
  int commandTokens = 4;
  int lieutenantOrders = 0;
  int regularOrders = 0;
  int irregularOrders = 0;
  int impetuousOrder = 0;

  Orders();

  Orders.copy(Orders other) {
    commandTokens = other.commandTokens;
    lieutenantOrders = other.lieutenantOrders;
    regularOrders = other.regularOrders;
    irregularOrders = other.irregularOrders;
    impetuousOrder = other.impetuousOrder;
  }
}

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  // VARIABLES, INITIALIZERS AND UPPDATERS
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
            setButton(h, w, context, () {}, _orders, () {setState(() {});}),
            resetToggleButtons(h, w),
          ],
        ),
        const SizedBox(height: 16.0), // SPACER
        // THE TOGGLE BUTTONS ROW/COLUMNS
        createToggleColumns(),
        const SizedBox(height: 16.0), // SPACER
        Column(
          // TODO: Delete this once SET is working
          children: [
            Text("Current number of Lieutenant orders: ${_orders.lieutenantOrders}"),
            Text("Current number of Regular orders: ${_orders.regularOrders}"),
            Text("Current number of Irregular orders: ${_orders.irregularOrders}"),
            Text("Current number of Impetuous orders: ${_orders.impetuousOrder}"),
          ],
        )
      ],
    );
  }

  Widget createToggleColumns() {
    /*
    double columnMath = 
      (_orders.lieutenantOrders + 
      _orders.regularOrders + 
      _orders.irregularOrders + 
      _orders.impetuousOrder) / 2;
    int totalOrdersPerColumn = columnMath.ceil();
    */
    
    // TODO: create a for loop the creates a number of buttons per row equal to totalOrdersPerColumn
    // May have to be two for loops or a nested for loop
    // 8 is the max (on test phone) that I can have per column
    // Able to have 4 columns wide comfortably

    return Row(
      // TODO: Make the number of columns and toggle buttons dynamic
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            commandTokensToggle(),
            const SizedBox(height: 16.0), // SPACER
            commandTokensToggle(),
            const SizedBox(height: 16.0), // SPACER
            lieutenantOrderToggle(),
            const SizedBox(height: 16.0), // SPACER
            lieutenantOrderToggle(),
            const SizedBox(height: 16.0), // SPACER
            regularOrderToggle(),
            const SizedBox(height: 16.0), // SPACER
            regularOrderToggle(),
            /*
            const SizedBox(height: 16.0), // SPACER
            regularOrderToggle(),
            const SizedBox(height: 16.0), // SPACER
            regularOrderToggle(),
            */
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
            regularOrderToggle(),
            const SizedBox(height: 16.0), // SPACER
            regularOrderToggle(),
            const SizedBox(height: 16.0), // SPACER
            regularOrderToggle(),
            /*
            const SizedBox(height: 16.0), // SPACER
            regularOrderToggle(),
            const SizedBox(height: 16.0), // SPACER
            regularOrderToggle(),
            */
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
            regularOrderToggle(),
            const SizedBox(height: 16.0), // SPACER
            regularOrderToggle(),
            const SizedBox(height: 16.0), // SPACER
            regularOrderToggle(),
            /*
            const SizedBox(height: 16.0), // SPACER
            regularOrderToggle(),
            const SizedBox(height: 16.0), // SPACER
            regularOrderToggle(),
            */
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
            regularOrderToggle(),
            const SizedBox(height: 16.0), // SPACER
            regularOrderToggle(),
            const SizedBox(height: 16.0), // SPACER
            regularOrderToggle(),
            /*
            const SizedBox(height: 16.0), // SPACER
            regularOrderToggle(),
            const SizedBox(height: 16.0), // SPACER
            regularOrderToggle(),
            */
          ],
        ),
      ],
    );
  }

  // RESET
  Widget resetToggleButtons(double h, double w) {
    CommonWidgets commonWidgets = CommonWidgets(); // For the button style, cuts down on code
    
    return ElevatedButton(
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
      }, 
      style: commonWidgets.customButtonStyle(height: h, width: w),
      child: const Text('Reset')
    );
  }

  // ORDER BUTTONS
  Widget commandTokensToggle() {
    OrderToggleButton toggleButton = OrderToggleButton(
      defaultValue: true,
      normalImage: "assets/tokens/command.png",
      greyImage: "assets/tokens/command_grey.png",
      orderType: OrderType.Lieutenant,
      backgroundColor: Colors.purple.shade800,
    );

    return toggleButton;
  }

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