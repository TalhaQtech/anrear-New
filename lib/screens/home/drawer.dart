import 'package:anrear/helper/bottomcontrller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final bottomctrl = Get.put(BottomController());
  @override
  Widget build(BuildContext context) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(100), bottomRight: Radius.circular(100)),
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff47367a),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: res_height * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13, right: 13),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: res_width * 0.1675,
                            height: res_width * 0.1675,
                            decoration: BoxDecoration(
                              color: const Color(0xff7c94b6),
                              image: DecorationImage(
                                image: AssetImage("assets/slicing/girl.jpeg"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Doe',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              Text('john@email.com',
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: res_height * 0.04,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (bottomctrl.navigationBarIndexValue != 0) {
                    bottomctrl.navBarChange(0);
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Image.asset(
                                  "assets/slicing/home sidemenu.png"),
                            ),
                            onPressed: () {},
                          ),
                          Text(
                            'Home',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: Colors.white.withOpacity(0.4),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: res_height * 0.02,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Route scaleIn(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, page) {
      var begin = 0.0;
      var end = 1.0;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return ScaleTransition(
        scale: animation.drive(tween),
        child: page,
      );
    },
  );
}
