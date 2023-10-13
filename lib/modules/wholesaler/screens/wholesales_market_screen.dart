import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/expert/models/experts_pagination_params.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/category/providers/select_category_view_provider.dart';
import 'package:sip_app/modules/common/widgets/experts_appbar.dart';
import 'package:sip_app/modules/common/widgets/main_bottom_navigationbar.dart';
import 'package:sip_app/modules/expert/providers/experts_market_provider.dart';
import 'package:sip_app/modules/expert/providers/experts_provider.dart';
import 'package:sip_app/modules/expert/widgets/expert_list_view.dart';
import 'package:sip_app/modules/category/widgets/sub_categories_view.dart';

import '../providers/wholesales_market_provider.dart';
import '../widgets/wholesaler_list_view.dart';

class WholesalesMarketScreen extends ConsumerStatefulWidget {
  final ExpertsPaginationParams param = ExpertsPaginationParams();
  final String marketId;

  WholesalesMarketScreen({required this.marketId, super.key});


  @override
  WholesalesMarketScreenState createState() => WholesalesMarketScreenState(marketId);

}

class WholesalesMarketScreenState extends ConsumerState<WholesalesMarketScreen> {
  int page = 1;

  final ScrollController _scrollController = ScrollController();
  final String marketId;
  WholesalesMarketScreenState(this.marketId);

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (_scrollController.offset >
        _scrollController.position.maxScrollExtent - 100) {
      int selectMainCategoryId = 1;
      if(marketId.isNotEmpty){
        selectMainCategoryId = int.parse(marketId);
      }



      final categoryPair = MarketCategory(
          marketId: selectMainCategoryId);

      ref.read(expertMarketListProvider(categoryPair).notifier).paginate(
        fetchMore: true,
        page: page + 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectCategoryPair = ref.watch(selectCategoryPairProvider(CATEGORY_PAIR_EXPERT_TYPE));
    int selectMarketId = 0;
    if(marketId!=0){
      selectMarketId = int.parse(marketId);
    }

    final categoryPair = MarketCategory(
        marketId: selectMarketId );
    final data = ref.watch(WholesalesMarketListProvider(categoryPair));

    return DefaultLayout(
      child: CustomScrollView(
        slivers: <Widget>[
          if (data is PaginationLoading)
            SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if ((data as Pagination).content.length == 0 ||
              data is PaginationError)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
                  children: <Widget>[
                    SvgPicture.asset('assets/icons/icon_error_gray.svg'),
                    SizedBox(height: 10),
                    Text(
                      '해당 도소매 상인이 없습니다.',
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final pData = data as Pagination;
                  return Column(
                    children: [
                      SizedBox(height: 16),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        child: wholesalerItem(wholesaler: pData.content[index]),
                      ),
                    ],
                  );
                },
                childCount: (data as Pagination).content.length,
              ),
            ),
          SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
        ],
      ),
      appbarColor: Colors.white,
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      isNeedAppbar: true,
    );
  }
}