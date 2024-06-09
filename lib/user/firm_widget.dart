import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey/user/thank_you.dart';

class FormWidget extends StatefulWidget {
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  String? _selectedCity;

  final List<String> _cities = ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix'];

  Widget _buildFormField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required bool mandatory,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: '$labelText${mandatory ? '*' : ''}',
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      validator: mandatory
          ? (value) {
              if (value == null || value.isEmpty) {
                return '$labelText is required';
              }
              return null;
            }
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildFormField(
            controller: _nameController,
            labelText: 'Name',
            hintText: 'Enter your name',
            mandatory: true,
          ),
          SizedBox(height: 16),
          _buildFormField(
            controller: _contactController,
            labelText: 'Contact No',
            hintText: 'Enter your contact number',
            mandatory: true,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 16),
          _buildFormField(
            controller: _cityController,
            labelText: 'City',
            hintText: 'Enter your city',
            mandatory: true,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 16),
          _buildFormField(
            controller: _remarksController,
            labelText: 'Remarks (If any)',
            hintText: 'Enter any remarks',
            mandatory: false,
            maxLines: 3,
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ThankYouScreen(),
                    ));
                // Form is valid, proceed with your logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Processing Data')),
                );
              }
            },
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
            child: Text('Submit'),
          ),
        ]));
  }
}
