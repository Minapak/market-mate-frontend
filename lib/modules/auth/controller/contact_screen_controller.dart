import 'dart:io';
import 'package:azlistview/azlistview.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';

class ContactScreenController {
  List<AToZItem> items = <AToZItem>[];
  List<Contact> contacts = <Contact>[];
  List<Contact> listContact = <Contact>[];
  Contact? contact;
  bool contactsLoaded = false;

  void getContacts() async {
    contacts = await ContactsService.getContacts();
    contactsLoaded = true;
    initList(contacts);
  }

  Future<Contact> onlyContact(String number) async {
    List<Contact> onlyContacts = [];
    onlyContacts = await ContactsService.getContactsForPhone(number);
    listContact.addAll(onlyContacts);
    return onlyContacts[0];
  }

  void addContacts() async {
    try {
      await ContactsService.openContactForm();
      getContacts();
      contactsLoaded = false;
    } catch (e) {
      getContacts();
      contactsLoaded = false;

      if (kDebugMode) {
        print('*************************************************$e');
      }
    }
  }

  void initList(List<Contact> items) {
    this.items = items
        .map(
          (item) => AToZItem(
        title: item.displayName,
        tag: item.displayName == null ? '#' : item.displayName![0].toUpperCase(),
        avatar: item.avatar,
        initials: item.initials(),
        number: Platform.isIOS || Platform.isAndroid
            ? ' '
            : item.phones![0].value!.isEmpty
            ? ' '
            : item.phones![0].value!,
      ),
    )
        .toList();
    SuspensionUtil.setShowSuspensionStatus(this.items);
  }
}

class AToZItem extends ISuspensionBean {
  final String? title;
  final String? tag;
  final Uint8List? avatar;
  final String? initials;
  final String? number;

  AToZItem({this.title, this.tag, this.avatar, this.initials, this.number});

  @override
  String getSuspensionTag() => tag.toString();
}






