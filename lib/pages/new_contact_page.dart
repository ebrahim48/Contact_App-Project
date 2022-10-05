import 'dart:io';

import 'package:addressbook_app_practice/models/contact_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName ='/new_contact';
  const NewContactPage({Key? key}) : super(key: key);

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final webController = TextEditingController();
  String? dob;
  String? imagePath;
  String genderGroupValue = 'Male';
  ImageSource source =ImageSource.camera;


  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    webController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Contact'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveContact,
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
              filled: true,
              labelText: 'Full Name',
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.call),
              filled: true,
              labelText: 'Mobile Number',
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              filled: true,
              labelText: 'Email Address',
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            keyboardType: TextInputType.streetAddress,
            controller: addressController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.my_location),
              filled: true,
              labelText: 'Street Address',
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: webController,
            keyboardType: TextInputType.url,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.web),
              filled: true,
              labelText: 'Website',
            ),
          ),
          SizedBox(height: 10,
          ),
         Card(
           elevation: 8,
           child: Column(
             mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Select Gender'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                      value: 'Male',
                      groupValue: genderGroupValue,
                      onChanged: (value){
                        setState(() {
                          genderGroupValue=value!;
                        });
                      }),
                  const Text('Male'),
                  SizedBox(width: 7,),
                  Radio<String>(
                      value: 'Female',
                      groupValue: genderGroupValue,
                      onChanged: (value){
                        setState(() {
                          genderGroupValue=value!;
                        });
                      }),
                  const Text('Female'),
                ],
              )
            ],
           ),
         ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: _showDatePickerDialog,
                child: const Text('Select Date of Birth'),
              ),
              Chip(
                label: Text(dob == null?'No Date Chosen': dob!),
              ),
            ],
          ),
          SizedBox(height: 10,
          ),
         Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             Card(
               elevation: 10,
               child: imagePath == null
                   ? Image.asset(
                     'images/person.png',
                     width: 100,
                     height: 100,
                     fit: BoxFit.cover,
                   )
                   :Image.file(
                 File(imagePath!),
                 width: 100,
                 height: 100,
                 fit: BoxFit.cover,
               )
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 TextButton.icon(
                     onPressed: () {
                       source = ImageSource.camera;
                       _getImage();
                     },
                     icon: Icon(Icons.camera),
                     label: Text('Capture')
                 ),
                 TextButton.icon(
                     onPressed: () {
                       source = ImageSource.gallery;
                       _getImage();
                     },
                     icon: Icon(Icons.photo),
                     label: Text('Gallery')
                 ),
               ],
             )
           ],
         )

        ],
      ),
    );
  }

  void _showDatePickerDialog() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1922),
        lastDate: DateTime.now());

    if(selectedDate != null){
      setState(() {
        dob = DateFormat('dd/MM/yyy').format(selectedDate);
      });
    }
  }

  void _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if(pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
    }
  
  void _saveContact() {
    final contact = ContactModel(
      name: nameController.text,
      mobile: phoneController.text,
      email: emailController.text,
      stressAddress: addressController.text,
      website: webController.text,
      dob: dob,
      gender: genderGroupValue,
      image: imagePath,

    );
    print(contact);
    contactList.add(contact);
    Navigator.pop(context);
  }
}

