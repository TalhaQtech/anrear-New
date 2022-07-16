import 'package:anrear/helper/bottomcontrller.dart';
import 'package:anrear/helper/colors.dart';
import 'package:anrear/screens/Pollings.dart';
import 'package:anrear/screens/home/artists_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

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
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 80.0,
        height: 80.0,
        child: FloatingActionButton(
            backgroundColor: bottomFabColor,
            child: IconButton(
              icon: Image.asset(
                'assets/slicing/home.png',
                width: 30,
                height: 30,
              ),
              onPressed: () {},
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
                    width: 28,
                    height: 28,
                  ),
                  onPressed: () {
                    _onItemTapped(0);
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/slicing/singer.png',
                    width: 28,
                    height: 28,
                  ),
                  onPressed: () {
                    _onItemTapped(1);
                  },
                ),
                SizedBox(width: 40), // The dummy child
                IconButton(
                  icon: Image.asset(
                    'assets/slicing/thumbsup.png',
                    width: 28,
                    height: 28,
                  ),
                  onPressed: () {
                    _onItemTapped(3);
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/slicing/avatar5.png',
                    width: 28,
                    height: 28,
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
          builder: (_) => bottomctrl.navigationBarIndexValue == 1
              ? ArtistsScreen()
              : bottomctrl.navigationBarIndexValue == 3
                  ? Pollings()
                  : Container()),
    );
  }
}
