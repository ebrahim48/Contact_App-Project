import 'package:addressbook_app_practice/models/contact_model.dart';
import 'package:addressbook_app_practice/pages/contact_details_page.dart';
import 'package:addressbook_app_practice/pages/new_contact_page.dart';
import 'package:addressbook_app_practice/provider/contact_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
   body: Consumer<ContactProvider>(
     builder: (context,provider,_) => ListView.builder(
       itemCount: provider.contactList.length,
       itemBuilder: (context,index){
         final contact = provider.contactList[index];
         return Dismissible(
           key: UniqueKey(),
           direction: DismissDirection.endToStart,
           background: Container(
             alignment: Alignment.center,
             color: Colors.blue,
             child: Icon(Icons.delete, size: 35, color: Colors.white,),
           ),
           confirmDismiss: showConfirmationDialog,
           onDismissed: (direction) {
             provider.deleteContact(contact);
           },
           child: Card(
             child: ListTile(
               onTap: () =>
                   Navigator.pushNamed(
                       context,
                       ContactDetailsPage.routeName,arguments: contact),
               leading: CircleAvatar(
                 child: Text(contact.name.substring(0,2)),
               ),
               title: Text(contact.name),
               trailing: IconButton(
                 icon: Icon(contact.favorite ? Icons.favorite:Icons.favorite_border,color: Colors.red,),
                 onPressed: () {
                   provider.updateFavorite(index);
                 },
               ),
             ),
           ),
         );
     }
     ),
   ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(
                context,
                NewContactPage.routeName),
        child: const Icon(Icons.add),
      ),
    );
  }
  Future<bool?>showConfirmationDialog(DismissDirection direction) {
    return showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text('Delete'),
      content: const Text('Sure to delete this item'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context,false);
            },
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context,true);
          },
          child: const Text('YES'),
        ),
      ],
    ));
  }
}
