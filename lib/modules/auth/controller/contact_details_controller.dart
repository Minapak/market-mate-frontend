import 'package:sip_app/modules/auth/controller/favourite_controller.dart';
import 'package:sip_app/modules/auth/sqlite_file/sqlite_database.dart';

class ContactDetailController {
  FavouriteController favoriteController = FavouriteController();

  void addDataSqlite(phonesNumber) async {
    DatabaseHelper db = DatabaseHelper.instance;
    final data = {
      'number': phonesNumber ?? ' ',
    };
    await db.insert(data);
  }

  void checkFavorite(phonesNumber) {
    DatabaseHelper db = DatabaseHelper.instance;
    db.checkFavorite(phonesNumber).then((value) {
      favoriteController.favouriteIcon = value;
    });
  }
}