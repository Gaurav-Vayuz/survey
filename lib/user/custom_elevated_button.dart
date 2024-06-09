import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final dynamic onTap;
  final String text;
  const CustomElevatedButton({super.key, required this.onTap, this.text = 'Submit'});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        surfaceTintColor: Colors.blue, // Button background color
        backgroundColor: Colors.white, // Button text color
        shadowColor: Colors.blueAccent, // Shadow color
        elevation: 5, // Elevation of the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Rounded corners
        ),
        padding: EdgeInsets.symmetric(vertical: 15.0), // Vertical padding
        minimumSize: Size(double.infinity, 50), // Button width and height
      ),
      child: Text(text, style: GoogleFonts.lato()),
    );
  }
}
