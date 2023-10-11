import 'package:sip_app/modules/auth/constant/image_path_constants.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:sip_app/modules/auth/screens/contact_details_screen.dart';
import 'package:sip_app/modules/auth/screens/select_favourite_screen.dart';

import '../controller/contact_screen_controller.dart';
import '../controller/favourite_controller.dart';
import '../controller/tab_bar_controller.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  FavouriteController favoriteController = FavouriteController();
  ContactScreenController contactScreenController = ContactScreenController();
  ContactTabController myTabController = ContactTabController();

  @override
  void initState() {
    closeKeyBoard();
    super.initState();
  }

  closeKeyBoard() {
    myTabController.controller!.addListener(() {
      if (myTabController.controller!.index.isOdd) {
        if (mounted) {
          FocusScope.of(context).unfocus();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        contactScreenController.listContact.isNotEmpty
            ? Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15),
              width: double.infinity,
              height: 28,
              color: Colors.grey[100],
              child: const Text(
                'Favourite Contact',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: contactScreenController.listContact.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: contactScreenController.listContact[index].avatar != null &&
                            contactScreenController.listContact[index].avatar!.isNotEmpty
                            ? CircleAvatar(
                          radius: 22,
                          child: ClipOval(
                            child: Image.memory(
                              contactScreenController.listContact[index].avatar!,
                            ),
                          ),
                        )
                            : CircleAvatar(
                          backgroundColor: Colors.primaries[index % Colors.primaries.length],
                          radius: 22,
                          child: contactScreenController.listContact[index].initials().isEmpty
                              ? Image.asset(
                            ImagePath.emptyContacts,
                            color: Colors.white,
                            height: 30,
                          )
                              : Text(
                            contactScreenController.listContact[index].initials().substring(0, 1),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        title: Text(
                          contactScreenController.listContact[index].displayName == null
                              ? contactScreenController.listContact[index].phones![0].value!
                              : contactScreenController.listContact[index].displayName!,
                          style: const TextStyle(fontSize: 14),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContactDetailsScreen(
                                circleColors: Colors.primaries[index % Colors.primaries.length],
                                phones: contactScreenController.listContact[index].phones![0].value ?? ' ',
                                isCameFromSearch: true,
                                isCameFromFavourite: true,
                                contact: Contact.fromMap({}),
                              ),
                            ),
                          );
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
          ],
        )
            : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 180,
                child: Image(
                  image: AssetImage(ImagePath.emptyFavorites),
                ),
              ),
              const Text(
                'No favorite contacts',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 18,
          right: 18,
          child: contactScreenController.contacts.isEmpty
              ? Container()
              : FloatingActionButton(
            tooltip: 'Add Favorite',
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectFavouriteScreen(),
                ),
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}