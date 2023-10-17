import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/wholesaler/providers/check_wholesaler_wish_provider.dart';
import 'package:sip_app/modules/wholesaler/providers/wholesaler_wish_provider.dart';
import 'package:sip_app/modules/wholesaler/providers/create_wholesaler_matching_provider.dart';
import 'package:sip_app/modules/wishlist/models/response_check_wish_model.dart';

class wholesalerWishHeart extends ConsumerWidget {
  final int wholesalerId;

  wholesalerWishHeart({required this.wholesalerId});

  Widget build(BuildContext context, WidgetRef ref) {
    var checkedData;
    var wishData;
    try{
      checkedData = ref.watch(wholesalerCheckWishProvider(wholesalerId));
      wishData = ref.watch(wholesalerWishProvider);
    }catch(e){
      print(e.toString());
    }

    if (checkedData is ServerStatusDataSuccess<ResponseCheckWishModel>) {
      final bool isChecked = checkedData.data.isChecked;
      final int wishlistId = checkedData.data.id ?? 0;

      return GestureDetector(
        onTap: () {
          print('isChecked:$isChecked');
          if (isChecked == false) {
            print('click1');
            ref.read(wholesalerWishProvider.notifier).onCreateWishlist(wholesalerId, context);
          } else {
            print(wishlistId);
            if (wishlistId != 0) {
              print('click2');
              ref.read(wholesalerWishProvider.notifier).onDeleteWishlist(wishlistId, wholesalerId, context);
            }
          }
        },
        child: SizedBox(
            width: 24,
            height:24,
            child: SvgPicture.asset(
              isChecked == true ? 'assets/icons/icon_heart_on_blue.svg': 'assets/icons/icon_heart_off_blue.svg',
              width: 24, height: 24,)
        ),
      );
    }
    return SizedBox.shrink();
  }
}