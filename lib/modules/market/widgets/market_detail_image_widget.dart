import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/models/image_model.dart';

class MarketImageItem extends StatelessWidget {
  final ImageModel image;

  MarketImageItem({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(image.path),
              fit: BoxFit.cover)),
    );
  }
}
