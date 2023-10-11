import 'package:sip_app/modules/auth/constant/image_path_constants.dart';
import 'package:sip_app/modules/auth/controller/favourite_controller.dart';
import 'package:sip_app/modules/auth/controller/search_screen_controller.dart';
import 'package:sip_app/modules/auth/controller/select_favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectFavouriteScreen extends StatefulWidget {
  const SelectFavouriteScreen({Key? key}) : super(key: key);

  @override
  State<SelectFavouriteScreen> createState() => _SelectFavouriteScreenState();
}

class _SelectFavouriteScreenState extends State<SelectFavouriteScreen> {
  SearchScreenController searchScreenController = Get.put(SearchScreenController());
  FavouriteController favoriteController = Get.put(FavouriteController());
  SelectFavouriteController selectFavouriteController = Get.put(SelectFavouriteController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.blue,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Select Favourite',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: Obx(
        () => selectFavouriteController.unSelectFavouriteList.isEmpty
            ? const Center(
                child: Text('All Select Favourite'),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: selectFavouriteController.unSelectFavouriteList.length,
                itemBuilder: (context, index) {
                  final item = selectFavouriteController.unSelectFavouriteList[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          item.displayName == null ? item.phones![0].value! : item.displayName.toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                        leading: (item.avatar != null && item.avatar!.isNotEmpty)
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(item.avatar!),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.primaries[index % Colors.primaries.length],
                                child: item.initials().isEmpty
                                    ? Image.asset(
                                        ImagePath.emptyContacts,
                                        color: Colors.white,
                                        height: 30,
                                      )
                                    : Text(
                                        item.initials().substring(0, 1),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                        ),
                                      ),
                              ),
                        // trailing: Obx(
                        //   () => Checkbox(
                        //     value: selectFavouriteController.selectFavouriteList.contains(selectFavouriteController.unSelectFavouriteList[index]),
                        //     onChanged: (val) {
                        //       selectFavouriteController.onSelected(val ?? false, selectFavouriteController.unSelectFavouriteList[index]);
                        //     },
                        //   ),
                        // ),
                        onTap: () async {
                          selectFavouriteController.addContactFavourite(index);
                          Get.back();
                        },
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
