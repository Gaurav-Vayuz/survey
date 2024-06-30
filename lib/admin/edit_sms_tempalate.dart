import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:survey/provider/home_controller.dart';
import 'package:survey/user/custom_elevated_button.dart';

class EditSmsTemplateScreen extends StatefulWidget {
  @override
  _EditSmsTemplateScreenState createState() => _EditSmsTemplateScreenState();
}

class _EditSmsTemplateScreenState extends State<EditSmsTemplateScreen> {
  final TextEditingController messageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  HomeController? homeController;
  @override
  void initState() {
    // TODO: implement initState
    homeController = Provider.of(context, listen: false);
   
  
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    homeController = context.watch<HomeController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Send SMS', style: GoogleFonts.lato()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fill Details ',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneController,
                maxLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Enter phone Number without +91',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: messageController,
                maxLines: 15,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Enter your SMS here',
                ),
              ),
              const SizedBox(height: 20),
             homeController!.loading?Center(child: CircularProgressIndicator()): CustomElevatedButton(
                onTap: () {
                  if (phoneController.text.isEmpty &&
                      messageController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('All Filed are Required !'), backgroundColor: Colors.red,));
                  } else {
                      homeController
                      ?.sendSms(
                          phoneController.text, messageController.text, context)
                      .then((value) {
                    if (value == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text(' Sms Sent'), backgroundColor: Colors.green,));
                           
                    } else {
                       ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('SomeThing went Wrong'), backgroundColor: Colors.red,));
                    }
                  });
                  }

                
                },
                text: 'Send',
              )
            ],
          ),
        ),
      ),
    );
  }
}
