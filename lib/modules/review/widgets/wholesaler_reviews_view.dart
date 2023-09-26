import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/review/models/review_model.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/review/providers/wholesaler_reviews_provider.dart';
import 'package:sip_app/modules/review/widgets/wholesaler_review_item_view.dart';

class wholesalerReviewsView extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  final int wholesalerId;

  wholesalerReviewsView(
      {required this.wholesalerId, required this.scrollController, super.key});

  @override
  wholesalerReviewsState createState() => wholesalerReviewsState();
}

class wholesalerReviewsState extends ConsumerState<wholesalerReviewsView> {
  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    // if (widget.scrollController.offset >
    //     widget.scrollController.position.maxScrollExtent - 100) {
    //   final notifier = ref.read(expertReviewsProvider(widget.expertId))
    //       as ExpertReviewsStateNotifier;

    //   notifier.paginate(id: widget.expertId, fetchMore: true);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(wholesalerReviewsProvider(widget.wholesalerId));

    if (data is PaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러
    if (data is PaginationError) {
      return Center(
        child: Text(data.message),
      );
    }

    final pData = data as Pagination;

    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text('리뷰',
                style: TextStyle(
                    color: SECTION_FONT_COLOR,
                    fontSize: 14,
                    fontWeight: FontWeight.w700)),
          ),
          ...pData.content.map<Widget>((review) {
            final pReview = review as ReviewModel;
            print(pReview.user.name);
            return wholesalerReviewItemView(
              review: review,
              createdDateTime: review.createdDateTime ?? '',
            );
          }).toList(),
          // ExpertReviewItemView(),
          // ExpertReviewItemView(),
          // ExpertReviewItemView(),
        ],
      ),
    );
  }
}
