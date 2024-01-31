import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _commandTokens = 4; // default number everyone gets
  int _regularOrders = 0;
  int _lieutenantOrders = 0;
  int _irregularOrders = 0;
  int _impetuousOrder = 0;

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
        // Decoration for background image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/logos/logo_15.png"), 
            fit: BoxFit.contain,
          ),
        ),
        // Child for the actual content of Container
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [startGame(screenHeight, screenWidth),]
          ),
        ),
      ),
      bottomNavigationBar: Container(
        // Here to be used for whatever I might need
        height: screenHeight * 0.0878, // was 60.0
      ),
    );
  }

  Widget startGame(double h, double w) {
    return ElevatedButton(
      onPressed: () {
        
      },
      style: ElevatedButton.styleFrom(
        // General settings of the buttons
        fixedSize: Size(h * 0.293, w * 0.122), // was 200, 50
        padding: EdgeInsets.all(w*0.0234), // was 16
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.amber.shade50, width: 0.5),
          borderRadius: BorderRadius.circular(10)
        ),
        // Text settings for the buttons
        foregroundColor: Colors.black, 
        backgroundColor: Colors.blueGrey.shade200,
        textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontFamily: 'Aquire'
        ),
      ),
      child: const Text("Start Game"),
    );
  }
}