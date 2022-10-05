import 'dart:io';

import 'package:addressbook_app_practice/models/contact_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName ='/details_page';
  const ContactDetailsPage({Key? key}) : super(key: key);

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
late ContactModel contact;


@override
  void didChangeDependencies() {
  contact = ModalRoute.of(context)!.settings.arguments as ContactModel;
  super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
      ),
     body: ListView(
       children: [
         contact.image == null?
             Image.asset('images/person.png',width: double.maxFinite,height: 250,fit: BoxFit.cover,):
             Image.file(File(contact.image!),width: double.maxFinite,height: 250,fit: BoxFit.cover,),
         ListTile(
           title: Text(contact.mobile),
           trailing: Row(
             mainAxisSize: MainAxisSize.min,
             children: [
               IconButton(
                   onPressed: _callPerson,
                   icon: Icon(Icons.call),
               ),
               IconButton(
                 onPressed: _smsContact,
                 icon: Icon(Icons.sms),
               ),
             ],
           ),
         ),
         ListTile(
           title: Text(contact.email == null || contact.email!.isEmpty? 'Unavailable': contact.email!),
           trailing: IconButton(
             icon: Icon(contact.email == null || contact.email!.isEmpty?  Icons.edit : Icons.email),
             onPressed: _mailContact,
           ),
         ),
         ListTile(
           title: Text(contact.stressAddress == null || contact.stressAddress!.isEmpty? 'Unavailable': contact.stressAddress!),
           trailing: IconButton(
             icon: Icon(contact.stressAddress == null || contact.stressAddress!.isEmpty?  Icons.edit : Icons.map),
             onPressed: _showMap,
           ),
         ),

       ],
     ),
    );
  }

  void _callPerson() async {
  final uri = Uri.parse('tel:${contact.mobile}');
  if(await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }else {
    throw 'cannot launch url';
  }
  }
  void _smsContact() {
  }
  void _mailContact() {
  }
  void _showMap() async {
    String urlString;
    if(Platform.isAndroid) {
      urlString = 'geo:0,0?q=${contact.stressAddress}';
    }else if(Platform.isIOS) {
      urlString = 'http://maps.apple.com/?q=${contact.stressAddress}';
    } else{
      urlString = 'geo:0,0?q=${contact.stressAddress}';
    }
    if(await canLaunchUrl(Uri.parse(urlString))) {
    await launchUrl(Uri.parse(urlString));
    }else {
    throw 'cannot launch url';
    }
  }
}
