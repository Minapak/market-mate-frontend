import 'package:sip_app/modules/auth/sqlite_file/sqlite_database.dart';
import 'package:sip_app/modules/auth/controller/contact_screen_controller.dart';
class FavouriteController {
  List<Map<String, dynamic>> getFavourite = [];
  bool favouriteIcon = false;

  // void getFavouriteData() async {
  //   await getSqliteData();
  //   for (int i = 0; i < getFavourite.length; i++) {
  //     // 이 부분에서 contactScreenController.onlyContact를 호출하는 로직을 추가해야 합니다.
  //     // 추가 코드가 필요하므로 제공된 코드에서는 누락되었습니다.
  //      await contactScreenController.onlyContact(getFavourite[i]['number']);
  //   }
  // }
  //
  // void getSqliteData() async {
  //   List<Map<String, dynamic>> data = await DatabaseHelper.instance.queryAll();
  //   getFavourite.addAll(data);
  // }
}