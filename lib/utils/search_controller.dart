import 'package:get/get.dart';
import 'package:sip_app/modules/common/widgets/Number.dart';

class SearchController extends GetxController{

  List<Number> numberList = [
    Number(number: "All",),
    Number(number: "5",),
    Number(number: "4",),
    Number(number: "3",),
    Number(number: "2",),
    Number(number: "1",),
  ] .obs;


}