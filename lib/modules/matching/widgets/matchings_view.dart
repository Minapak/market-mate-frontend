import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/matching/models/matching_model.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/matching/providers/matchings_provider.dart';
import 'package:sip_app/modules/expert/widgets/expert_card_item_view.dart';

class MypageMatchingsView extends ConsumerWidget {
  MypageMatchingsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(matchingsProvider);

    if (data is PaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (data is PaginationError) {
      return Center(
        child: Text('에러'),
      );
    }

    final pData = data as Pagination<MatchingModel>;
    final groupData = ref.watch(matchingsGroupProvider);
    final sortedKeys = groupData.keys.toList()..sort();

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      itemCount: sortedKeys.length,
      itemBuilder: (context, index) {
        final key = sortedKeys[index];
        final values = groupData[key] as List<MatchingModel>;

        return MypageMatchingsWrapperView(date: key, matchings: values);
      },
    );
  }
}

class MypageMatchingsWrapperView extends StatelessWidget {
  final String date;
  final List<MatchingModel> matchings;

  MypageMatchingsWrapperView({required this.date, required this.matchings});

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
            ...matchings
                .map((MatchingModel matching) => ExpertCardItemView(
                      expert: matching.expert,
                      matchingStatus: matching.matchingStatus,
                      isNeedIntroduce: false,
                      isNeedMatchingStatus: true,
                    ))
                .toList()
          ]),
    );
  }
}
