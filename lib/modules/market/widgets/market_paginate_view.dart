
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/category/providers/select_category_view_provider.dart';
import 'package:sip_app/modules/category/widgets/sub_categories_view.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/expert/providers/experts_provider.dart';
import 'package:sip_app/modules/market/providers/market_list_provider.dart';
import 'package:sip_app/modules/market/widgets/market_item.dart';

class MarketPaginateView extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectCategoryPair = ref.watch(selectCategoryPairProvider(CATEGORY_PAIR_MARKET_TYPE));
    final selectMainCategoryId = selectCategoryPair.mainCategoryId ?? 0;
    final selectMiddleCategoryId = selectMainCategoryId > 0
        ? selectCategoryPair.middleCategoryIds[selectMainCategoryId]
        : 0;
    final categoryPair = CategoryPair(
        mainCategoryId: selectCategoryPair.mainCategoryId,
        middleCategoryId:
        selectMiddleCategoryId != null ? selectMiddleCategoryId : 0);
    final data = ref.watch(marketListNotifierProvider(categoryPair));
    //
    // if (data is PaginationLoading) {
    //   return Center(child:  CircularProgressIndicator(),);
    // }
    //
    // if (data is PaginationError) {
    //   return Center(child: Text('error'),);
    // }

    return Container(
      decoration: BoxDecoration(color: PRIMARY_BACKGROUND_COLOR),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SubCategoriesView(type: CATEGORY_PAIR_MARKET_TYPE,mainCategoryId: selectMainCategoryId),
          ),

          if (data is PaginationLoading)
            SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (data is PaginationError || (data as Pagination).content.length == 0)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
                  children: <Widget>[
                    SvgPicture.asset('assets/icons/icon_error_gray.svg'),
                    SizedBox(height: 10),
                    Text(
                      '해당 시장이 없습니다.',
                      style: TextStyle(
                          color: GRAY_COLOR_FONT,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ) // SVG 파일 로드
                    // 다른 위젯들...
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 24),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return MarketItem(
                      id: data.content[index].id,
                      title: data.content[index].name,
                      thumbnail: data.content[index].thumbnail,
                    );
                  },
                  childCount: (data as Pagination).content.length,
                ),
              ),
            )
        ],
      ),
    );
  }
}