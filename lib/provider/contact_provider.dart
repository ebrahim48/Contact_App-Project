import 'package:addressbook_app_practice/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier{
  List<ContactModel> contactList =[];

  addContact(ContactModel contactModel){
    contactList.add(contactModel);
    notifyListeners();
  }
  getAllContacts() {
    this.contactList = contactListDB;
    notifyListeners();
  }
}