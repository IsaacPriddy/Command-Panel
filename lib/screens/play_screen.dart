import 'package:flutter/material.dart';
import 'widgets/order_toggle_button.dart';
import 'widgets/set_button.dart';
import 'widgets/common_widgets.dart'; // For button style
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
  
  @override
  void initState() {
    super.initState();
    updateToggleKeys();
  }

  void updateToggleKeys() {
    _toggleButtonKeys.clear();
    _toggleButtonKeys.addAll(List.generate(
      _orders.regularOrders,
      (index) => GlobalKey<OrderToggleButtonState>(),
    ));
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
        // TODO: Possibly change the bottom box color
        decoration: BoxDecoration(color: Colors.blueGrey.shade200), // Was blueGrey.shade500, then Color.fromRGBO(232, 122, 22, 1.0)
        height: screenHeight * 0.08,
      ),
    );
  }

  Widget playScreenMainBody(double h, double w) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: h * 0.014), // SPACER, WAS 12.0
        // THE SET AND RESET BUTTON
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            setButton(h*0.8, w, context, () {}, _orders, () {setState(() {});}),
            resetToggleButtons(h*0.8, w),
          ],
        ),
        SizedBox(height: h * 0.014), // SPACER, WAS 12.0
        // THE COMMAND TOKENS
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int index = 0; index < _orders.commandTokens; index++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: commandTokensToggle(),
            ),
          ],
        ),
        SizedBox(height: h * 0.004),  // SPACER
        Divider(thickness: 4.0,indent: 16.0, endIndent: 16.0, color: Colors.blueGrey.shade200,), // WAS const SizedBox(height: 16.0),
        SizedBox(height: h * 0.004),  // SPACER
        // THE TOGGLE BUTTONS ROW/COLUMNS
        // createToggleRows(), // If changed in the future: Change this so it creates rows instead of columns so that a user can scroll down instead of across
        createToggleColumns(),
      ],
    );
  }

  // TOGGLE BUTTONS
  Widget createToggleColumns() {
    int tokensPerColumn = 7;  // If there is 1/no combat groups
    List<Widget> allOrderWidgets = [];
    // Create a list of OrderToggleButton widgets based on the order types in Orders
    // allOrderWidgets.addAll(List.generate(_orders.commandTokens, (index) => orderToggleSwitch(OrderType.CommandToken)));
    allOrderWidgets.addAll(List.generate(_orders.lieutenantOrders, (index) => orderToggleSwitch(OrderType.Lieutenant)));
    allOrderWidgets.addAll(List.generate(_orders.regularOrders, (index) => orderToggleSwitch(OrderType.Regular)));
    allOrderWidgets.addAll(List.generate(_orders.irregularOrders, (index) => orderToggleSwitch(OrderType.Irregular)));
    allOrderWidgets.addAll(List.generate(_orders.impetuousOrder, (index) => orderToggleSwitch(OrderType.Impetuous)));

    // Determine the number of columns needed based on the total number of orders
    int numberOfColumns = (allOrderWidgets.length / tokensPerColumn).ceil();

    // Create a list to hold the widgets for each column
    List<Widget> columns = [];

    // Generate columns
    for (int i = 0; i < numberOfColumns; i++) {
      // Determine the start and end index for each column
      int startIndex = i * tokensPerColumn;
      int endIndex = min((i + 1) * tokensPerColumn, allOrderWidgets.length);

      // Extract orders for the current column
      List<Widget> ordersInCurrentColumn = allOrderWidgets.sublist(startIndex, endIndex);

      // Create a column with orders and spacers
      List<Widget> columnChildren = [];
      double spaceBetweenToggles = MediaQuery.of(context).size.height * 0.020;
      for (var orderWidget in ordersInCurrentColumn) {
        columnChildren.add(orderWidget);
        columnChildren.add(SizedBox(height: spaceBetweenToggles)); // Spacer, WAS 14
      }

      // Add the column to the list of columns
      columns.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(children: columnChildren)
        )
      );
    }
    
    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: columns,
        ),
      )
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