import 'package:sip_app/modules/auth/controller/contact_screen_controller.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class SearchScreenController {
  ScrollController scrollController = ScrollController();
  TextEditingController searchTextController = TextEditingController();
  List<AToZItem> contactFilter = <AToZItem>[];
  List<Contact> contactAfterSearch = <Contact>[];
  bool isSearching = false;
  ContactScreenController contactScreenController = ContactScreenController();

  void onInit() {
    filterContact();
    searchTextController.addListener(() {
      filterContact();
    });
  }

  void filterContact() {
    List<AToZItem> contacts = <AToZItem>[];
    contacts.addAll(contactScreenController.items);
    List<Contact> contactToSend = <Contact>[];
    contactToSend.addAll(contactScreenController.contacts);

    if (searchTextController.text.isNotEmpty) {
      isSearching = true;
      contacts.retainWhere((element) {
        String searchTerm = searchTextController.text.toLowerCase();
        String contactName = element.title == null ? element.number! : element.title!.toLowerCase();
        return contactName.contains(searchTerm);
      });

      contactToSend.retainWhere((element) {
        String searchTerm = searchTextController.text.toLowerCase();
        String contactName = element.displayName == null ? element.phones![0].value! : element.displayName!.toLowerCase();
        return contactName.contains(searchTerm);
      });
    }
    contactFilter = contacts;
    contactAfterSearch = contactToSend;
  }
}