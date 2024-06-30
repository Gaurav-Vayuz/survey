import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/user/feedback_screen.dart';

import 'sign_in_screen.dart';

class ThankYouScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.teal,
        title: Text('Thank You', style: GoogleFonts.lato()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 120),
              Image.asset(
                'asset/thank_you.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => FeedbackScreen(),
                      ));
                  // Form is valid, proceed with your logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  surfaceTintColor: Colors.blue, // Button background color
                  backgroundColor: Colors.white, // Button text color
                  shadowColor: Colors.blueAccent, // Shadow color
                  elevation: 5, // Elevation of the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15.0), // Vertical padding
                  minimumSize: const Size(double.infinity, 50), // Button width and height
                ),
                child: Text('Rate Us Again', style: GoogleFonts.lato()),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                 Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => LoginPage(),), (route) => false);
                  // Form is valid, proceed with your logic
                 
                },
                style: ElevatedButton.styleFrom(
                  surfaceTintColor: Colors.blue, // Button background color
                  backgroundColor: Colors.white, // Button text color
                  shadowColor: Colors.blueAccent, // Shadow color
                  elevation: 5, // Elevation of the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15.0), // Vertical padding
                  minimumSize: const Size(double.infinity, 50), // Button width and height
                ),
                child: Text('Done', style: GoogleFonts.lato()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
