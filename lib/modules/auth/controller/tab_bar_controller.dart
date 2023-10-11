import 'package:flutter/material.dart';

class ContactTabController extends State<StatefulWidget> with SingleTickerProviderStateMixin {
  List<Tab> contactTabs = <Tab>[
    Tab(text: 'Contacts'),
    Tab(text: 'Favorites'),
  ];

  late TabController controller;

  void onInit() {
    controller = TabController(vsync: this, length: contactTabs.length);
  }

  void onClose() {
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}






