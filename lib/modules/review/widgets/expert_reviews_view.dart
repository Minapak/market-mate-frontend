import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/review/models/review_model.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/review/providers/expert_reviews_provider.dart';
import 'package:sip_app/modules/review/widgets/expert_review_item_view.dart';

class ExpertReviewsView extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  final int expertId;

  ExpertReviewsView(
      {required this.expertId, required this.scrollController, super.key});

  @override
  ExpertReviewsState createState() => ExpertReviewsState();
}

class ExpertReviewsState extends ConsumerState<ExpertReviewsView> {
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
    final data = ref.watch(expertReviewsProvider(widget.expertId));

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
            return ExpertReviewItemView(
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
