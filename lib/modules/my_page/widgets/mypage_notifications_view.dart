import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';

class MypageNotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NotificationItem(label: '매칭 알림'),
        NotificationItem(label: '채팅 알림'),
       NotificationItem(label: '커뮤니티 알림'),
        NotificationItem(label: '시프 소식 알림'),
      ],
    );
  }
}

class NotificationItem extends StatefulWidget {
  final String label;

  NotificationItem({required this.label, Key? key});

  @override
  NotificationItemState createState() => NotificationItemState();
}

class NotificationItemState extends State<NotificationItem> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: BUTTON_GRAY_BORDER_COLOR,
        width: 1,
      ))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(widget.label,
            style: TextStyle(
                color: FIXED_WIDGET_BACKGROUNG_COLOR,
                fontSize: 14,
                fontWeight: FontWeight.w500)),
        Transform.scale(
          scale: 1.1,
          child: Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
            activeTrackColor: NAVIGATION_TEXT_COLOR,
            activeColor: Colors.white,
            inactiveTrackColor: INPUT_BORDER_GRAY_COLOR,
            inactiveThumbColor: Colors.white,
          ),
        )
      ]),
    );
  }
}
