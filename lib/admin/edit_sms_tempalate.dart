import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/user/custom_elevated_button.dart';

class EditSmsTemplateScreen extends StatefulWidget {
  @override
  _EditSmsTemplateScreenState createState() => _EditSmsTemplateScreenState();
}

class _EditSmsTemplateScreenState extends State<EditSmsTemplateScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    String mssg =
        '''Thank You for Submitting Your Feedback! Your feedback is valuable for us. We are constantly working to make
your experience smooth. If you want to add new products into our stock or for any enquiry.
Please submit your responses on google link send below. Thank You!!!
Save this as default in textfield''';
    _controller.text = mssg;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit SMS Template', style: GoogleFonts.lato()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Text EDIT SMS Template:',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _controller,
                maxLines: 15,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Enter your SMS template here',
                ),
              ),
              SizedBox(height: 20),
              CustomElevatedButton(
                onTap: () {},
                text: 'Update',
              )
            ],
          ),
        ),
      ),
    );
  }
}
