import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(const MyApp());
}

// TODO LIST
//  1. Get a 1024x1024 icon to replace the background image and be used for the logo/phone icon
//    - Current idea is a box with rounded edges, some circles that look like Toggle in them
//      and maybe the words command panel slapped over top them.
//  2. (DONE v1.0) Replace the font to something that is actually available for commercial use
//    - Not sure if I am happy with the new elnath font for now, but it'll do for the time being
//  3. (DONE v1.0) Create a sidescroll for if the user maxes out their orders
//  4. (FAILED v1.0) Remove the plus and minus button and instead of a field users can type into
//      the plus and minus buttons are annoying to continuously tap...
//      - Tried a tap in field, it sucked. On the plus side, fixed a bug with the popup screen
//  5. Make it so that the state of the app is saved when the app is closed and opened again
//  6. Connect the AD service thing to my bottom appbar
//  7. What should I do if the user has two combat groups?
//    - Change my set orders to have two groups of the buttons, one for group 1 and one for group 2
//    - Make it so that the command tokens are the top row, the next section is group 1, and the
//      section after that is group 2. BUT, if there is only one group then use all the space for it.
//  8. A way to keep score maybe?
//  9. A library of the hidden objective cards? (Might be stepping on companies toes if I do this though)
//  10. Do not allow users to unToggle the buttons (except command tokens) without pressing the reset button

//  NOTES:
//  1. Currently have it set so that if there are no orders then there will be no command tokens
//    but if there are any orders then the 4 command tokens show up. May have to revisit later.
//  2. May need to change the limit of orders in set_button.dart. I know regular orders cap out
//    at 15 but the others I am unsure of. For now I have added horizontal scrolling to fix it.
//    May need to revisit this later.