import 'package:anrear/helper/bottomcontrller.dart';
import 'package:anrear/helper/colors.dart';
import 'package:anrear/helper/helper.dart';
import 'package:anrear/models/usermodels.dart';
import 'package:anrear/screens/home/artist_profile_screen.dart';
import 'package:anrear/screens/home/homescreen.dart';
import 'package:anrear/screens/home/polling_screen.dart';
import 'package:anrear/screens/home/artists_screen.dart';
import 'package:anrear/screens/home/profile.dart';
import 'package:anrear/screens/home/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class HomeMainScreen extends StatefulWidget {
  final UserModel? userModel;
  const HomeMainScreen({Key? key, this.userModel}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  final bottomctrl = Get.put(BottomController());
  void _onItemTapped(int index) {
    bottomctrl.navBarChange(index);
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.userModel!.userEmail);
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 80.0,
        height: 80.0,
        child: FloatingActionButton(
            shape:
                StadiumBorder(side: BorderSide(color: Colors.white, width: 3)),
            backgroundColor: bottomFabColor,
            child: IconButton(
              icon: Image.asset(
                'assets/slicing/home.png',
                width: 26,
                height: 26,
              ),
              onPressed: () {
                _onItemTapped(2);
              },
            ),
            onPressed: () {
              _onItemTapped(2);
            }),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: BottomAppBar(
            child: Container(
          height: 60,
          decoration: BoxDecoration(
              // color: Colors.red,
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(20), topRight: Radius.circular(20))

              ),
          child: Padding(
            padding: const EdgeInsets.only(left: 13, right: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Image.asset(
                    'assets/slicing/search.png',
                    width: 22,
                    height: 22,
                  ),
                  onPressed: () {
                    _onItemTapped(0);
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/slicing/singer.png',
                    width: 22,
                    height: 22,
                  ),
                  onPressed: () {
                    _onItemTapped(1);
                  },
                ),
                SizedBox(width: 40), // The dummy child
                IconButton(
                  icon: Image.asset(
                    'assets/slicing/thumbsup.png',
                    width: 22,
                    height: 22,
                  ),
                  onPressed: () {
                    _onItemTapped(3);
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/slicing/avatar5.png',
                    width: 22,
                    height: 22,
                  ),
                  onPressed: () {
                    _onItemTapped(4);
                  },
                ),
              ],
            ),
          ),
        )),
      ),
      body: GetBuilder<BottomController>(
          builder: (_) => UserType == "user"
              ? screenarrangementuser[bottomctrl.navigationBarIndexValue]
              : screenarrangementartist[bottomctrl.navigationBarIndexValue]),
    );
  }
}

var screenarrangementuser = [
  SearchScreen(),
  ArtistsScreen(),
  HomeScreen(),
  PollingsScreen(),
  ProfileScreen()
];

var screenarrangementartist = [
  SearchScreen(),
  ArtistsScreen(),
  HomeScreen(),
  PollingsScreen(),
  ArtistProfileScreen()
];
