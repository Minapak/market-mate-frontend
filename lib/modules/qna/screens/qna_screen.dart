import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/qna/widgets/qna_list_view.dart';

class QnaScreen extends StatelessWidget {
  const QnaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: BackAppBar(title: '나의 문의'),
      child: QnaListView(),
      backgroundColor: Colors.white,
    );
  }
}
