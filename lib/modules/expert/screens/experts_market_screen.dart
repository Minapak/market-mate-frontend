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

class ExpertsMarketScreen extends ConsumerStatefulWidget {
  final ExpertsPaginationParams param = ExpertsPaginationParams();
  final String marketId;


 // const BackAppBar({required this.title, this.actionWidget, Key? key})
    //  : super(key: key);
  ExpertsMarketScreen({required this.marketId, super.key});


  @override
  ExpertsMarketScreenState createState() => ExpertsMarketScreenState(marketId);

}

class ExpertsMarketScreenState extends ConsumerState<ExpertsMarketScreen> {
  int page = 1;

  final ScrollController _scrollController = ScrollController();
  final String marketId;
  ExpertsMarketScreenState(this.marketId);

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
    print("marketId:"+marketId.toString());
    if(marketId!=0){
      print("marketId!=0:"+marketId.toString());
      selectMarketId = int.parse(marketId);
    }

    final categoryPair = MarketCategory(
        marketId: selectMarketId );
    final data = ref.watch(expertMarketListProvider(categoryPair));

    return DefaultLayout(
        child: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return [
        SliverAppBar(
          primary: true,
          backgroundColor: Colors.white,
          title: Text('$marketId번째 시장 창업 전문가 보기',
              style: TextStyle(
                color: SECTION_FONT_COLOR,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/icon_back.svg'),
            onPressed: () {
              Navigator.of(context).pop();
              // _showDialog(context);
            },
          ),
        ),
        // 추가적인 슬리버를 필요에 따라 여기에 추가할 수 있습니다.
      ];
    },
      body: CustomScrollView(
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
                      '해당 전문가가 없습니다.',
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
                        child: ExpertItem(expert: pData.content[index]),
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
          ),
    );
  }
}