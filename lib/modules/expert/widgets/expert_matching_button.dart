import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/expert/providers/create_expert_matching_provider.dart';

class ExpertMatchingButton extends ConsumerWidget {
  final int expertId;

  ExpertMatchingButton({required this.expertId, Key? key}) : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onTapMatching() {
      if (expertId == null) {
        return;
      }

      ref.read(createExpertMatchingProvider.notifier).onMatch(expertId:expertId);
    }

    return BottomAppBar(
        elevation: 0,
        child: GestureDetector(
          onTap: () {
            print('매칭하기 버튼');
            onTapMatching();
          },
          child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              width: double.infinity,
              height: 74,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: NAVIGATION_TEXT_COLOR,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text('매칭하기',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
              )),
        ));
  }
}
