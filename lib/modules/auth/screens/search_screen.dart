import 'package:sip_app/modules/auth/constant/image_path_constants.dart';
import 'package:sip_app/modules/auth/controller/contact_screen_controller.dart';
import 'package:sip_app/modules/auth/screens/contact_details_screen.dart';
import 'package:sip_app/modules/auth/controller/search_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ContactScreenController contactScreenController = Get.put(ContactScreenController());
  SearchScreenController searchScreenController = Get.put(SearchScreenController());

  @override
  void initState() {
    searchScreenController.onInit();
    searchScreenController.filterContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15),
            width: double.infinity,
            height: 28,
            color: Colors.grey[200],
            child: Obx(() => searchScreenController.isSearching == true
                ? Text(
                    'FOUND ${searchScreenController.contactFilter.length} CONTACTS',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  )
                : Text(
                    'FOUND ${contactScreenController.items.length} CONTACTS',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  )),
          ),
          Expanded(
            child: Obx(
              () {
                return contactScreenController.items.isNotEmpty
                    ? Scrollbar(
                        thumbVisibility: true,
                        radius: const Radius.circular(20),
                        thickness: 10,
                        trackVisibility: true,
                        interactive: true,
                        controller: searchScreenController.scrollController,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                            controller: searchScreenController.scrollController,
                            shrinkWrap: true,
                            itemCount: searchScreenController.isSearching == true
                                ? searchScreenController.contactFilter.length
                                : contactScreenController.items.length,
                            itemBuilder: (context, index) {
                              final item = searchScreenController.isSearching == true
                                  ? searchScreenController.contactFilter[index]
                                  : contactScreenController.items[index];
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      item.title == null ? item.number! : item.title.toString(),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    leading: (item.avatar != null && item.avatar!.isNotEmpty)
                                        ? CircleAvatar(
                                            backgroundImage: MemoryImage(item.avatar!),
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Colors.primaries[index % Colors.primaries.length],
                                            child: item.initials!.isEmpty
                                                ? Image.asset(
                                                    ImagePath.emptyContacts,
                                                    color: Colors.white,
                                                    height: 30,
                                                  )
                                                : Text(
                                                    item.initials!.substring(0, 1),
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                          ),
                                    onTap: () async {
                                      await Get.to(
                                        () => ContactDetailsScreen(
                                          circleColors: Colors.primaries[index % Colors.primaries.length],
                                          phones: searchScreenController.contactAfterSearch[index].phones!.isNotEmpty
                                              ? searchScreenController.contactAfterSearch[index].phones![0].value
                                              : '0',
                                          isCameFromSearch: true,
                                          contact: searchScreenController.contactAfterSearch[index],
                                          isCameFromFavourite: false,
                                        ),
                                      );
                                      searchScreenController.searchTextController.clear();
                                    },
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                ],
                              );
                            }),
                      )
                    : const Center(
                        child: Text('No Contact'),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
