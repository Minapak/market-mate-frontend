import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/expert/widgets/expert_card_item_view.dart';
import 'package:sip_app/modules/wishlist/models/wishlist_model.dart';
import 'package:sip_app/modules/wishlist/providers/wishlist_provider.dart';

class MypageWishlistView extends ConsumerWidget {
  MypageWishlistView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(wishlistsProvider);

    if (data is PaginationLoading) {
      print('isLoading');
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (data is PaginationError) {
      return Center(child: Text('에러'));
    }

    final pData = data as Pagination<WishlistModel>;
    final groupData = ref.watch(wishlistsGroupProvider);
    final sortedKeys = groupData.keys.toList()..sort();

    if (sortedKeys.length == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
          children: <Widget>[
            SvgPicture.asset('assets/icons/icon_error_gray.svg'),
            SizedBox(height: 10),
            Text(
              '찜한 전문가가 없습니다.',
              style: TextStyle(
                  color: GRAY_COLOR_FONT,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ) // SVG 파일 로드
            // 다른 위젯들...
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      itemCount: sortedKeys.length,
      itemBuilder: (context, index) {
        final key = sortedKeys[index];
        final values = groupData[key] as List<WishlistModel>;

        return MypageWishlistWrapperView(date: key, wishlists: values);
      },
    );
  }
}

class MypageWishlistWrapperView extends StatelessWidget {
  final String date;
  final List<WishlistModel> wishlists;

  MypageWishlistWrapperView({required this.date, required this.wishlists});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date,
                style: TextStyle(
                    color: FIXED_WIDGET_BACKGROUNG_COLOR,
                    fontSize: 14,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 10),
            ...wishlists
                .map((WishlistModel wishlist) => ExpertCardItemView(
                    expert: wishlist.expert!,
                    isNeedIntroduce: false,
                    isNeedHeart: true))
                .toList()
          ]),
    );
  }
}
