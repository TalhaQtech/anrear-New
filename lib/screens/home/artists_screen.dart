import 'package:anrear/screens/home/drawer.dart';
import 'package:anrear/screens/home/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtistsScreen extends StatefulWidget {
  const ArtistsScreen({Key? key}) : super(key: key);

  @override
  State<ArtistsScreen> createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  @override
  Widget build(BuildContext context) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _key = GlobalKey();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/slicing/Bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        key: _key,
        drawer: NavDrawer(),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              _key.currentState!.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child:
                  Container(child: Image.asset('assets/slicing/hamburger.png')),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(() => NotificationScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(
                    child: Image.asset('assets/slicing/notfication.png')),
              ),
            )
          ],
          centerTitle: true,
          title: Text(
            'Artists',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ArtistBox('John Doe', 'assets/slicing/girl.jpeg',
                    'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                ArtistBox('Andy Marshal', 'assets/slicing/girl.jpeg',
                    'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                ArtistBox('Sarah Smith', 'assets/slicing/girl.jpeg',
                    'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                ArtistBox('John Doe', 'assets/slicing/girl.jpeg',
                    'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                ArtistBox('John Doe', 'assets/slicing/girl.jpeg',
                    'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                ArtistBox('Andy Marshal', 'assets/slicing/girl.jpeg',
                    'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                ArtistBox('Sarah Smith', 'assets/slicing/girl.jpeg',
                    'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                ArtistBox('John Doe', 'assets/slicing/girl.jpeg',
                    'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                SizedBox(
                  height: res_height * 0.135,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ArtistBox(name, image, description) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;
    return Container(
      width: res_width * 0.94,
      // decoration: BoxDecoration(
      //     color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: res_width * 0.1675,
                height: res_width * 0.1675,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  border: Border.all(
                    color: Color(0xffc88225),
                    width: 2.0,
                  ),
                ),
              ),
              SizedBox(
                width: res_width * 0.0235,
              ),

              // Container(
              //     width: res_width * 0.225,
              //     child: Center(child: Image.asset(image))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                  ),
                  SizedBox(
                    height: res_height * 0.00075,
                  ),
                  Container(
                      width: res_width * 0.6,
                      child: Text(description,
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xff929292),
                            height: 1.5,
                          )))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
