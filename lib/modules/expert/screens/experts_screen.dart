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
import 'package:sip_app/modules/expert/providers/experts_provider.dart';
import 'package:sip_app/modules/expert/widgets/expert_list_view.dart';
import 'package:sip_app/modules/category/widgets/sub_categories_view.dart';

class ExpertsScreen extends ConsumerStatefulWidget {
  final ExpertsPaginationParams param = ExpertsPaginationParams();

  ExpertsScreen({super.key});

  @override
  ExpertsScreenState createState() => ExpertsScreenState();
}

class ExpertsScreenState extends ConsumerState<ExpertsScreen> {
  int page = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (_scrollController.offset >
        _scrollController.position.maxScrollExtent - 100) {
      final selectCategoryPair = ref.read(selectCategoryPairProvider(CATEGORY_PAIR_EXPERT_TYPE));
      final selectMainCategoryId = selectCategoryPair.mainCategoryId ?? 0;
      final selectMiddleCategoryId = selectMainCategoryId > 0
          ? selectCategoryPair.middleCategoryIds[selectMainCategoryId]
          : 0;

      final categoryPair = CategoryPair(
          mainCategoryId: selectCategoryPair.mainCategoryId,
          middleCategoryId:
          selectMiddleCategoryId != null ? selectMiddleCategoryId : 0);

      ref.read(expertListProvider(categoryPair).notifier).paginate(
        fetchMore: true,
        page: page + 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectCategoryPair = ref.watch(selectCategoryPairProvider(CATEGORY_PAIR_EXPERT_TYPE));
    final selectMainCategoryId = selectCategoryPair.mainCategoryId ?? 0;
    final selectMiddleCategoryId = selectMainCategoryId > 0
        ? selectCategoryPair.middleCategoryIds[selectMainCategoryId]
        : 0;
    final categoryPair = CategoryPair(
        mainCategoryId: selectCategoryPair.mainCategoryId,
        middleCategoryId:
        selectMiddleCategoryId != null ? selectMiddleCategoryId : 0);
    final data = ref.watch(expertListProvider(categoryPair));

    return DefaultLayout(
      appBar: ExpertsAppBar(),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SubCategoriesView(type: CATEGORY_PAIR_EXPERT_TYPE),
          ),
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
      appbarColor: Colors.white,
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      bottomNavigationBar: MainBottomNavigationBar(bottomTabIndex: 1),
      isNeedAppbar: true,
    );
  }
}