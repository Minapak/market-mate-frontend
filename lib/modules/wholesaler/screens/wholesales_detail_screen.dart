import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/wholesaler/widgets/create_wholesaler_matching_handler.dart';
import 'package:sip_app/modules/wholesaler/widgets/wholesaler_detail_view.dart';
import 'package:sip_app/modules/wholesaler/widgets/wholesaler_matching_button.dart';

class wholesalesDetailScreen extends StatelessWidget {
  final String wholesalerId;
  final String wholesalerName;

  wholesalesDetailScreen({required this.wholesalerId, required this. wholesalerName});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultLayout(
          appBar: BackAppBar(title: '$wholesalerName 도/소매 상인'),
          child: wholesalerDetailView(wholesalerId: wholesalerId),
          bottomNavigationBar: wholesalerMatchingButton(wholesalerId: int.parse(wholesalerId)),
        ),
        CreatewholesalerMatchingHandler(),
      ],
    );
  }
}
