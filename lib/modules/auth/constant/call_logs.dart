import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';

class CallLogs {
  void call(String text) async {
    await FlutterPhoneDirectCaller.callNumber(text) ?? false;
  }

  getAvatar(CallType callType) {
    switch (callType) {
      case CallType.outgoing:
        return const CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(Icons.call_made_outlined, color: Colors.green),
        );
      case CallType.missed:
        return const CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(
            Icons.call_missed,
            color: Colors.red,
          ),
        );
      default:
        return const CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(Icons.call_received, color: Colors.white),
        );
    }
  }

  getColorsType(CallType callType) {
    switch (callType) {
      case CallType.missed:
        return const Color(0xFFF44336);
      default:
        return const Color(0xFF000000);
    }
  }

  Future<Iterable<CallLogEntry>> getCallLogs() {
    return CallLog.get();
  }

  getTitle(CallLogEntry entry) {
    if (entry.name == null) {
      return entry.number!;
    }
    if (entry.name!.isEmpty) {
      return entry.number!;
    } else {
      return entry.name!;
    }
  }

  String formatDate(DateTime dt) {
    return DateFormat('d-MMM-y hh:mm aaa').format(dt);
  }

  String getTime(int duration) {
    Duration d1 = Duration(seconds: duration);
    String formatDuration = "";
    if (d1.inHours > 0) {
      formatDuration += "${d1.inHours} h : ";
    }
    if (d1.inMinutes > 0) {
      formatDuration += "${d1.inMinutes} m : ";
    }
    if (d1.inSeconds > 0) {
      formatDuration += "${d1.inSeconds} s ";
    }
    if (formatDuration.isEmpty) {
      return "0 s";
    }
    return formatDuration;
  }
}
