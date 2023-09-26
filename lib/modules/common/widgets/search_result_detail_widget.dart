import 'package:flutter/material.dart';

class SearchResultDetailWidget extends StatelessWidget {
  final String result;

  SearchResultDetailWidget(this.result);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("검색 결과 상세 화면"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "검색 결과 상세 화면",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              "검색 결과: $result",
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            // TODO: 상세 화면에 원하는 내용을 추가합니다.
          ],
        ),
      ),
    );
  }
}