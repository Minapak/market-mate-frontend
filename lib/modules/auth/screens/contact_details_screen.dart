import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/image_path_constants.dart';
import '../controller/contact_details_controller.dart';
import '../controller/contact_screen_controller.dart';
import '../controller/favourite_controller.dart';
import '../sqlite_file/sqlite_database.dart';

class ContactDetailsScreen extends StatefulWidget {
  final Color circleColors;
  final String? phones;
  final Contact? contact;
  final bool isCameFromSearch;
  final bool isCameFromFavourite;

  const ContactDetailsScreen({
    Key? key,
    required this.phones,
    required this.circleColors,
    this.contact,
    required this.isCameFromSearch,
    required this.isCameFromFavourite,
  }) : super(key: key);

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  ContactScreenController contactScreenController = ContactScreenController();
  ContactDetailController contactDetailController = ContactDetailController();
  FavouriteController favouriteController = FavouriteController();

  @override
  void initState() {
    contactDetailController.checkFavorite(widget.phones!);
    initializeContact();
    super.initState();
  }

  initializeContact() async {
    if (widget.isCameFromFavourite) {
      contactScreenController.contact = (await contactScreenController.onlyContact(widget.phones!));
      favouriteController.getFavourite.clear();
      contactScreenController.listContact.clear();
     // favouriteController.getFavouriteData();
      //Get.forceAppUpdate();
    } else {
      contactScreenController.contact = (widget.contact!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (contactScreenController.contact == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          actions: [
            contactScreenController.contact!.phones!.isEmpty
                ? Container()
                : IconButton(
              splashRadius: 25,
              onPressed: () {
                Share.share(
                  "Name: ${contactScreenController.contact!.displayName!.isEmpty ? '' : contactScreenController.contact!.displayName!}"
                      "\nContact Number: ${widget.phones!}",
                );
              },
              icon: Icon(
                Icons.share,
                color: Colors.black,
              ),
              tooltip: 'Share Contact',
            ),
            contactScreenController.contact!.phones!.isEmpty
                ? Container()
                : IconButton(
              splashRadius: 25,
              tooltip: 'Add to Favorites',
              onPressed: () async {
                favouriteController.favouriteIcon = !favouriteController.favouriteIcon;
                if (favouriteController.favouriteIcon == true) {
                  contactDetailController.addDataSqlite(widget.phones!);
                  contactDetailController.checkFavorite(widget.phones!);
                  favouriteController.getFavourite.clear();
                  contactScreenController.listContact.clear();
                 // favouriteController.getFavouriteData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text(
                        "Added to Favourite successfully",
                      ),
                    ),
                  );
                } else {
                  DatabaseHelper db = DatabaseHelper.instance;
                  db.delete(widget.phones!);
                  contactDetailController.checkFavorite(widget.phones!);
                  favouriteController.getFavourite.clear();
                  contactScreenController.listContact.clear();
                  //favouriteController.getFavouriteData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text(
                        "Removed from Favourite",
                      ),
                    ),
                  );
                }
              },
              icon: contactScreenController.contact!.phones!.isEmpty
                  ? Container()
                  : Obx(
                    () => favouriteController.favouriteIcon== true
                    ? Icon(
                  Icons.star,
                  color: Colors.black,
                )
                    : Icon(
                  Icons.star_border,
                  color: Colors.black,
                ),
              ),
            ),
            contactScreenController.contact!.phones!.isEmpty
                ? IconButton(
              onPressed: () {
                deleteContact(context);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.black,
              ),
            )
                : PopupMenuButton<int>(
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      Text("   Edit")
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      Text("   Delete"),
                    ],
                  ),
                ),
              ],
              elevation: 3.2,
              tooltip: 'More options',
              onSelected: (value) {
                switch (value) {
                  case 1:
                    editContact();
                    break;
                  case 2:
                    deleteContact(context);
                    break;
                  default:
                }
              },
              splashRadius: 25,
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              radius: 55,
              child: contactScreenController.contact!.avatar != null &&
                  contactScreenController.contact!.avatar!.isNotEmpty
                  ? ClipOval(
                child: Image.memory(contactScreenController.contact!.avatar!),
              )
                  : CircleAvatar(
                radius: 55,
                backgroundColor: widget.circleColors,
                child: contactScreenController.contact!.initials().isEmpty
                    ? Image.asset(
                  ImagePath.emptyContacts,
                  height: 80,
                  color: Colors.white,
                )
                    : Text(
                  contactScreenController.contact!.initials().substring(0, 1),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 45,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(contactScreenController.contact!.displayName ?? "", style: TextStyle(fontSize: 22)),
            ),
            Divider(
              height: 20,
              thickness: 1,
            ),
            contactScreenController.contact!.phones!.isEmpty
                ? Container()
                : ListTile(
              onTap: () async {
                await FlutterPhoneDirectCaller.callNumber(widget.phones!);
              },
              leading: Icon(Icons.call_outlined, color: Colors.grey, size: 28),
              title: widget.phones!.isEmpty
                  ? Container()
                  : Text(
                widget.phones!,
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              subtitle: Text(
                contactScreenController.contact!.phones![0].label!.replaceAll(
                  contactScreenController.contact!.phones![0].label![0],
                  contactScreenController.contact!.phones![0].label![0].toUpperCase(),
                ),
                style: TextStyle(fontSize: 15),
              ),
              trailing: GestureDetector(
                onTap: () {
                  messagesOpen();
                },
                child: Platform.isIOS
                    ? Image.asset(
                  ImagePath.iosMessages,
                  height: 40,
                )
                    : Image.asset(
                  ImagePath.androidMessages,
                  height: 40,
                ),
              ),
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: widget.phones!));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("phone number copied to clipboard"),
                  ),
                );
              },
            ),
            contactScreenController.contact!.phones!.isEmpty
                ? Container()
                : Divider(
              height: 10,
              thickness: 1,
            ),
            contactScreenController.contact!.androidAccountName == '731908881' ||
                contactScreenController.contact!.androidAccountName == 'WhatsApp'
                ? ListTile(
              leading: Image.asset(
                ImagePath.whatsapp,
                height: 40,
              ),
              title: Text(
                widget.phones!.length == 15 ||
                    widget.phones!.length == 13 ||
                    widget.phones!.length == 9 ||
                    widget.phones!.length == 14
                    ? 'Message ${widget.phones!}'
                    : 'Message +91 ${widget.phones!}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                openWhatsapp(context);
              },
            )
                : Container(),
            contactScreenController.contact!.androidAccountName == 'WhatsApp' ||
                contactScreenController.contact!.androidAccountName == '731908881'
                ? Divider(
              height: 10,
              thickness: 1,
            )
                : Container(),
          ],
        ),
      );
    }
  }

  openWhatsapp(context) async {
    String whatsapp = widget.phones!;
    Uri whatsappURlAndroid = whatsapp.length == 15 || whatsapp.length == 13 || whatsapp.length == 14 || whatsapp.length == 9
        ? Uri.parse("whatsapp://send?phone=$whatsapp&text=Hello")
        : Uri.parse(
      "whatsapp://send?phone=+91$whatsapp&text=Hello",
    );
    Uri whatsappURLIos = Uri.parse("https://wa.me/$whatsapp?text=Hello}");
    if (Platform.isIOS) {
      if (await launchUrl(whatsappURLIos)) {
        await launchUrl(whatsappURLIos);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("whatsapp not installed")));
      }
    } else {
      if (await launchUrl(whatsappURlAndroid)) {
        await launchUrl(whatsappURlAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("whatsapp not installed")));
      }
    }
  }

  void messagesOpen() async {
    final smsUrl = Uri.parse("sms:${widget.phones!}");
    await launchUrl(smsUrl);
  }

  editContact() async {
    try {
      String oldNumber = contactScreenController.contact!.phones![0].value ?? "";
      Contact updateContact = await ContactsService.openExistingContact(contactScreenController.contact!);
      if (favouriteController.favouriteIcon) {
        await updateSqlite(updateContact.phones?[0].value ?? "", oldNumber);
      }
      contactScreenController.contact = updateContact;
      contactScreenController.contactsLoaded = false;
      favouriteController.getFavourite.clear();
      contactScreenController.listContact.clear();
      contactScreenController.getContacts();
     // favouriteController.getFavouriteData();
      Navigator.of(context).pop();
      if (widget.isCameFromSearch) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  deleteContact(context) async {
    await ContactsService.deleteContact(contactScreenController.contact!);
    contactScreenController.getContacts();
    if (favouriteController.favouriteIcon== true) {
      DatabaseHelper db = DatabaseHelper.instance;
      db.delete(widget.phones!);
      favouriteController.getFavourite.clear();
      contactScreenController.listContact.clear();
      //favouriteController.getFavouriteData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            "Removed from Favourite",
          ),
        ),
      );
    }
    contactScreenController.contactsLoaded = false;
    Navigator.of(context).pop();
    if (widget.isCameFromSearch) {
      Navigator.of(context).pop();
    }
  }

  void addDataSqlite() async {
    DatabaseHelper db = DatabaseHelper.instance;
    final data = {
      'number': widget.phones ?? ' ',
    };
    await db.insert(data);
  }

  updateSqlite(String newNumber, String oldNumber) async {
    DatabaseHelper db = DatabaseHelper.instance;
    final data = {
      'number': newNumber,
    };
    await db.update(data, oldNumber);
  }
}