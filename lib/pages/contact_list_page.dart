import 'package:addressbook_app_practice/models/contact_model.dart';
import 'package:addressbook_app_practice/pages/contact_details_page.dart';
import 'package:addressbook_app_practice/pages/new_contact_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactListPage extends StatefulWidget {
  static const String routeName ='/';
  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const
        Text('Contact List'),
      ),

   body: ListView.builder(
     itemCount: contactList.length,
     itemBuilder: (context,index){
       final contact = contactList[index];
       return Card(
         child: ListTile(
           onTap: () =>
               Navigator.pushNamed(
                   context,
                   ContactDetailsPage.routeName,arguments: contact),
           leading: CircleAvatar(
             child: Text(contact.name.substring(0,2)),
           ),
           title: Text(contact.name),
         ),
       );
   }
   ),

      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(
                context,
                NewContactPage.routeName).then((_) {
                  setState(() {
                  });
            }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
