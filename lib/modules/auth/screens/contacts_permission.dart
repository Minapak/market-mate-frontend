import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:sip_app/modules/auth/screens/contacts_screen.dart';

class ContactsPermission extends StatefulWidget {
  const ContactsPermission({Key? key}) : super(key: key);

  @override
  State<ContactsPermission> createState() => _ContactsPermissionState();
}

class _ContactsPermissionState extends State<ContactsPermission> {
  QuickActions quickActions = const QuickActions();

  @override
  void initState() {
    super.initState();
    initializeQuickActions();
    permissionContact();
  }

  permissionContact() async {
    PermissionStatus permissionStatus = await getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      if (mounted) {
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        // //  builder: (context) => const ContactsScreen(),
        // ));
      }
    } else {
      handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> getPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void handleInvalidPermissions(PermissionStatus permissionStatus) async {
    if (permissionStatus == PermissionStatus.denied) {
      const snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      SystemNavigator.pop();
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
      permissionContact();
      const snackBar = SnackBar(content: Text('Permanently Denied'));
      if (mounted) {
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // await openAppSettings();
        const snackBar = SnackBar(content: Text('Access to contact data denied'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        SystemNavigator.pop();
      }
    }
  }

  initializeQuickActions() {
    quickActions.initialize(
          (type) {
        switch (type) {
          case 'First Page Screen':
            if (mounted) {
           //    Navigator.of(context).pushReplacement(MaterialPageRoute(
           // //     builder: (context) => const ContactsScreen(),
           //    ));
            }
            return;
        }
      },
    );
    quickActions.setShortcutItems(
      <ShortcutItem>[
        const ShortcutItem(
          type: 'First Page Screen',
          localizedTitle: 'Contacts Screen',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}