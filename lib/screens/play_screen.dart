import 'package:flutter/material.dart';
import 'widgets/order_toggle_button.dart';
import 'widgets/set_button.dart';
import 'widgets/common_widgets.dart';
import 'dart:math';

class Orders {
  int commandTokens = 0; // Default number of these is 4, set button creates their default
  int lieutenantOrders = 0;
  int regularOrders = 0;
  int irregularOrders = 0;
  int impetuousOrder = 0;

  Orders(); // Calls the default values

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
  final Orders _orders = Orders();  // Creates a copy of the default orders

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
        /*
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
        */
      ],
    );
  }

  // TOGGLE BUTTONS
  Widget createToggleColumns() {
    List<Widget> allOrderWidgets = [];
    // Create a list of OrderToggleButton widgets based on the order types in Orders
    allOrderWidgets.addAll(List.generate(_orders.commandTokens, (index) => orderToggleSwitch(OrderType.CommandToken)));
    allOrderWidgets.addAll(List.generate(_orders.lieutenantOrders, (index) => orderToggleSwitch(OrderType.Lieutenant)));
    allOrderWidgets.addAll(List.generate(_orders.regularOrders, (index) => orderToggleSwitch(OrderType.Regular)));
    allOrderWidgets.addAll(List.generate(_orders.irregularOrders, (index) => orderToggleSwitch(OrderType.Irregular)));
    allOrderWidgets.addAll(List.generate(_orders.impetuousOrder, (index) => orderToggleSwitch(OrderType.Impetuous)));

    // Determine the number of columns needed based on the total number of orders
    int numberOfColumns = (allOrderWidgets.length / 8).ceil();
    // debugPrint("The number of columns is: $numberOfColumns");

    // Create a list to hold the widgets for each column
    List<Widget> columns = [];

    // Generate columns
    for (int i = 0; i < numberOfColumns; i++) {
      // Determine the start and end index for each column
      int startIndex = i * 8;
      int endIndex = min((i + 1) * 8, allOrderWidgets.length);

      // Extract orders for the current column
      List<Widget> ordersInCurrentColumn = allOrderWidgets.sublist(startIndex, endIndex);

      // Create a column with orders and spacers
      List<Widget> columnChildren = [];
      for (var orderWidget in ordersInCurrentColumn) {
        columnChildren.add(orderWidget);
        columnChildren.add(const SizedBox(height: 14.0)); // Spacer
      }

      // Add the column to the list of columns
      columns.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(children: columnChildren)
        )
      );
    }
    

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: columns,
      ),
    );
  }

  Widget orderToggleSwitch(OrderType type) {
    switch(type) {
      case OrderType.CommandToken:
        return commandTokensToggle();
      case OrderType.Lieutenant:
        return lieutenantOrderToggle();
      case OrderType.Regular:
        return regularOrderToggle();
      case OrderType.Irregular:
        return irregularOrderToggle();
      case OrderType.Impetuous:
        return impetuousOrderToggle();
      default:
        debugPrint("ERROR: Not a valid type");
        return Container();
    }
  }

  // RESET BUTTON
  Widget resetToggleButtons(double h, double w) {
    CommonWidgets commonWidgets = CommonWidgets(); // For the button style, cuts down on code
    
    return ElevatedButton(
      onPressed: () {
        setState(() {
          for (var key in _toggleButtonKeys) {
            key.currentState?.reset();
          }
        });
      }, 
      style: commonWidgets.customButtonStyle(height: h, width: w),
      child: const Text('Reset')
    );
  }

  // ORDER TOGGLE BUTTON MAKERS
  Widget commandTokensToggle() {
    // GlobalKey<OrderToggleButtonState> key = GlobalKey<OrderToggleButtonState>();
    // _commandTokenKeys.add(key);

    return OrderToggleButton(
      // key: key,//As long as this is in here, reset also resets command tokens instead of leaving them be
      defaultValue: true,
      normalImage: "assets/tokens/command.png",
      greyImage: "assets/tokens/command_grey.png",
      orderType: OrderType.CommandToken,
      backgroundColor: Colors.purple.shade800,
    );
  }

  Widget lieutenantOrderToggle() {
    GlobalKey<OrderToggleButtonState> key = GlobalKey<OrderToggleButtonState>();
    _toggleButtonKeys.add(key);

    return OrderToggleButton(
      key: key, // Add key here
      defaultValue: true,
      normalImage: "assets/tokens/lieutenant.png",
      greyImage: "assets/tokens/lieutenant_grey.png",
      orderType: OrderType.Lieutenant,
      backgroundColor: Colors.blue.shade800,
    );
  }

  Widget regularOrderToggle() {
    GlobalKey<OrderToggleButtonState> key = GlobalKey<OrderToggleButtonState>();
    _toggleButtonKeys.add(key);

    return OrderToggleButton(
      key: key, // Add key here
      defaultValue: true,
      normalImage: "assets/tokens/regular.png",
      greyImage: "assets/tokens/regular_grey.png",
      orderType: OrderType.Regular,
      backgroundColor: Colors.green.shade800,
    );
  }

  Widget irregularOrderToggle() {
    GlobalKey<OrderToggleButtonState> key = GlobalKey<OrderToggleButtonState>();
    _toggleButtonKeys.add(key);

    return OrderToggleButton(
      key: key, // Add key here
      defaultValue: true,
      normalImage: "assets/tokens/irregular.png",
      greyImage: "assets/tokens/irregular_grey.png",
      orderType: OrderType.Irregular,
      backgroundColor: Colors.yellow.shade800,
    );
  }

  Widget impetuousOrderToggle() {
    GlobalKey<OrderToggleButtonState> key = GlobalKey<OrderToggleButtonState>();
    _toggleButtonKeys.add(key);

    return OrderToggleButton(
      key: key,// Add key here
      defaultValue: true,
      normalImage: "assets/tokens/impetuous.png",
      greyImage: "assets/tokens/impetuous_grey.png",
      orderType: OrderType.Impetuous,
      backgroundColor: Colors.red.shade800,
    );
  }
}