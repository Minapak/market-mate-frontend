import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/path.dart';

class MarketItem extends StatelessWidget {
  final int id;
  final String title;
  final String thumbnail;

  MarketItem({required this.id, required this.title, required this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
            'marketDetail',
            queryParameters: {"marketName": title},
            pathParameters: {'id': id.toString()}
        );
      },
      child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(thumbnail),
              fit: BoxFit.cover,
            ),
          ),
          child: Text(title,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500))),
    );
  }
}