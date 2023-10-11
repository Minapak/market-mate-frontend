import 'package:sip_app/modules/auth/controller/contact_details_controller.dart';
import 'package:sip_app/modules/auth/controller/contact_screen_controller.dart';
import 'package:sip_app/modules/auth/controller/favourite_controller.dart';
import 'package:contacts_service/contacts_service.dart';

class SelectFavouriteController {
  ContactDetailController contactDetailController = ContactDetailController();
  ContactScreenController contactScreenController = ContactScreenController();
  FavouriteController favoriteController = FavouriteController();
  List<Contact> unSelectFavouriteList = <Contact>[];

  void onInit() {
    unSelectFavouriteList.isNotEmpty ? null : addFavouriteList();
  }

  void addFavouriteList() {
    unSelectFavouriteList.addAll(contactScreenController.contacts);
    checkFavouriteContact();
  }

  void checkFavouriteContact() {
    for (int j = 0; j < contactScreenController.listContact.length; j++) {
      unSelectFavouriteList.removeWhere((element) {
        if (element.phones!.isNotEmpty) {
          return element.phones![0].value == contactScreenController.listContact[j].phones![0].value;
        } else {
          return true;
        }
      });
    }
  }

  void addContactFavourite(int i) {
    contactDetailController.addDataSqlite(unSelectFavouriteList[i].phones![0].value);
    contactDetailController.checkFavorite(unSelectFavouriteList[i].phones![0].value);
    favoriteController.getFavourite.clear();
    contactScreenController.listContact.clear();
   // favoriteController.getFavouriteData();
  }
}