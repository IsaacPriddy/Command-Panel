import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(const MyApp());
}

// TODO LIST
//  1. Get a 1024x1024 icon to replace the background image and be used for the logo/phone icon
//    - Current idea is a box with rounded edges, some circles that look like Toggle in them
//      and maybe the words command panel slapped over top them.
//  2. (DONE) Replace the font to something that is actually available for commercial use
//    - Not sure if I am happy with the new elnath font for now, but it'll do for the time being
//  3. (DONE) Create a sidescroll for if the user maxes out their orders
//  4. (FAILED) Remove the plus and minus button and instead of a field users can type into
//      the plus and minus buttons are annoying to continuously tap...
//      - Tried a tap in field, it sucked. On the plus side, fixed a bug with the popup screen
//  5. Make it so that the state of the app is saved when the app is closed and opened again
//  6. Connect the AD service thing to my bottom appbar

//  NOTES:
//  1. Currently have it set so that if there are no orders then there will be no command tokens
//    but if there are any orders then the 4 command tokens show up. May have to revisit later.
//  2. May need to change the limit of orders in set_button.dart. I know regular orders cap out
//    at 15 but the others I am unsure of. For now I have added horizontal scrolling to fix it.
//    May need to revisit this later.