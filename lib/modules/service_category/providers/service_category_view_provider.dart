import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/app_constants.dart';

final ServiceCategorySelectProvider = StateProvider<int>((ref){
  return ZERO;
});