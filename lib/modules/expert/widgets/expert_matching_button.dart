import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/expert/providers/create_expert_matching_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/expert_detail_provider.dart';

class ExpertMatchingButton extends ConsumerWidget {
  final int expertId;


  ExpertMatchingButton({required this.expertId, Key? key}) : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onTapMatching() async {
      if (expertId == null) {
        return;
      }
      // SharedPreferences에서 값 가져오기
      final prefs = await SharedPreferences.getInstance();
      final storedName = prefs.getString('name') ?? ''; // 디폴트 값 설정 가능
      final storedPhone = prefs.getString('phone') ?? ''; // 디폴트 값 설정 가능
      final phoneNumber = storedPhone;
      // 가져온 값 로그로 출력
      print('Stored Name: $storedName');
      print('Stored Phone: $storedPhone');
      if (phoneNumber.isEmpty) {
        return;
      }

      final url = 'tel:$phoneNumber';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
  //  ref.read(expertCacheProvider as ProviderListenable).onMatch(expertId:expertId);
    }

    return BottomAppBar(
        elevation: 0,
        child: GestureDetector(
          onTap: () {
            print('연락하기 버튼');
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
                child: Text('연락하기',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
              )),
        ));
  }
}
