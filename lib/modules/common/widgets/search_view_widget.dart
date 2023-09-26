import 'package:flutter/material.dart';

class SearchViewWidget extends StatefulWidget {
  @override
  _SearchViewWidgetState createState() => _SearchViewWidgetState();
}

class _SearchViewWidgetState extends State<SearchViewWidget> {
  TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = []; // 검색 결과를 저장할 리스트

  void _performSearch(String query) {
    // TODO: 실제 검색 기능을 구현합니다.
    // 여기에서 검색 결과를 가져오고 _searchResults 리스트에 저장합니다.
    // 예시: 검색 결과를 API로부터 가져오는 방법
    // final results = await searchApi.search(query);
    // setState(() {
    //   _searchResults = results;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("검색"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (query) {
                _performSearch(query);
              },
              decoration: InputDecoration(
                hintText: "검색어를 입력해주세요",
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _searchResults.clear();
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Text("검색 결과가 없습니다."),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        return ListTile(
          title: Text(result),
          // TODO: 검색 결과 항목을 터치할 때 원하는 동작을 추가합니다.
          // 예시: 결과를 클릭하면 해당 항목으로 이동
          // onTap: () {
          //   Navigator.push(context, MaterialPageRoute(builder: (context) {
          //     return ResultDetailScreen(result); // 결과 상세 화면으로 이동
          //   }));
          // },
        );
      },
    );
  }
}