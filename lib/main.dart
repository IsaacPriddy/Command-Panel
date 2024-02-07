import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(const MyApp());
}

// TODO LIST
//  1. Get a 1024x1024 icon to replace the background image and be used for the logo/phone icon
//  2. Replace the font to something that is actually available for commercial use
//  3. (DONE) Create a sidescroll for if the user maxes out their orders
//  4. Remove the plus and minus button and instead of a field users can type into
//      the plus and minus buttons are annoying to continuously tap...
//      - Tried a tap in field, it sucked. On the plus side, fixed a bug with the popup screen

//  NOTES:
//  1. Currently have it set so that if there are no orders then there will be no command tokens
//    but if there are any orders then the 4 command tokens show up. May have to revisit later.
//  2. May need to change the limit of orders in set_button.dart. I know regular orders cap out
//    at 15 but the others I am unsure of. For now I have added horizontal scrolling to fix it.
//    May need to revisit this later.