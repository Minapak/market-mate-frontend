import 'package:flutter/material.dart';

class DismissibleConstant {
 static stackBehindDismissSecondaryBackground() {
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              'Delete  ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              ),
            ),
            Icon(Icons.delete, color: Colors.white),
          ],
        ),
      ),
    );
  }

 static stackBehindDismissBackground() {
    return Container();
  }
}
