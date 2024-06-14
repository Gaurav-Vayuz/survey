import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/user/firm_widget.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int _selectedRating = -1;
  String rateingText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback', style: GoogleFonts.lato()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: _selectedRating >= 1
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Text(
                ' Aapka service mein anubhav kaisa raha ?',
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildEmoji(5, 'asset/emoji_5.png'),
                  _buildEmoji(4, 'asset/emoji_4.png'),
                  _buildEmoji(3, 'asset/emoji_3.png'),
                  _buildEmoji(2, 'asset/emoji_2.png'),
                  _buildEmoji(1, 'asset/emoji_1.png'),
                ],
              ),
              const SizedBox(height: 16),
              if (_selectedRating != null)
                Text(
                  _getFeedbackText(_selectedRating!),
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 32),
              _selectedRating >= 0
                  ? FormWidget(
                      selectedRating: rateingText,
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmoji(int rating, String assetPath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRating = rating;
          rateingText = _getFeedbackText(rating);
        });
      },
      child: Column(
        children: [
          Image.asset(
            assetPath,
            width: 50,
            height: 50,
          ),
          if (_selectedRating == rating)
            Container(
              width: 24,
              height: 20,
              margin: const EdgeInsets.only(top: 4),
              child: Image.asset(
                'asset/icon_tick.png',
                width: 24,
                height: 20,
              ),
            ),
        ],
      ),
    );
  }




  String _getFeedbackText(int rating) {
    switch (rating) {
      case 1:
        return 'Bahut Kharab';
      case 2:
        return 'Kharab';
      case 3:
        return 'Theek';
      case 4:
        return 'Accha';
      case 5:
        return 'Bahut Accha';
      default:
        return '';
    }
  }
}
