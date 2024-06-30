import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey/provider/home_controller.dart';
import 'package:survey/user/thank_you.dart';

class FormWidget extends StatefulWidget {
  final String selectedRating;

  const FormWidget({required this.selectedRating, super.key});

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  String selectedValue = 'Agra';
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
    String prefix = '',
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
        prefixText: prefix,
        border: const OutlineInputBorder(),
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

  late HomeController homeController;
  @override
  void initState() {
    // TODO: implement initState
    homeController = Provider.of(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeController = context.watch<HomeController>();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Selected Rating: ${widget.selectedRating}', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          _buildFormField(
            controller: _nameController,
            labelText: 'Name',
            hintText: 'Enter your name',
            mandatory: true,
          ),
          const SizedBox(height: 16),
          _buildFormField(
            controller: _contactController,
            labelText: 'Contact No',
            hintText: 'Enter your contact number',
            mandatory: true,
            prefix: '+91 ',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          // _buildFormField(
          //   controller: _cityController,
          //   labelText: 'City',
          //   hintText: 'Enter your city',
          //   mandatory: true,
          //   keyboardType: TextInputType.text,
          // ),
          cityDropDown(),
          const SizedBox(height: 16),
          _buildFormField(
            controller: _remarksController,
            labelText: 'Remarks (If any)',
            hintText: 'Enter any remarks',
            mandatory: false,
            maxLines: 3,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                homeController.submitEmoji(widget.selectedRating ?? "", context).then((value) {
                  if (value == true) {
                    homeController
                        .submitForm(
                            _nameController.text ?? "",
                            "+91${_contactController.text}" ?? "",
                            _selectedCity!,
                            _remarksController.text,
                            context)
                        .then((value) {
                      if (value == true) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Feedback Submited'),
                          backgroundColor: Colors.green,
                        ));
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ThankYouScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Feedback Submit Failed'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Feedback Submit Failed'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                });

                // Form is valid, proceed with your logic
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
              padding: const EdgeInsets.symmetric(vertical: 15.0), // Vertical padding
              minimumSize: const Size(double.infinity, 50), // Button width and height
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget cityDropDown() {
    final List<String> items = ['Agra', 'Firozabad', 'Mainpuri', 'Etah', 'Kasganj', 'Other'];
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue!;
        });
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Select a City',
      ),
      isExpanded: true,
    );
  }
}
