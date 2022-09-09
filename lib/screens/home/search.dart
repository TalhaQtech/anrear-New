import 'package:anrear/screens/home/artisprofile_user_screen.dart';
import 'package:anrear/screens/home/drawer.dart';
import 'package:anrear/screens/home/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

var name = "";
GlobalKey<ScaffoldState> _key = GlobalKey();

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: res_height,
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
            behavior: HitTestBehavior.translucent,
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
              behavior: HitTestBehavior.translucent,
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
            'Search',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: res_height * 0.015,
                ),
                Container(
                  width: res_width * 0.9,
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() {
                        name = val;
                      });
                    },
                    // controller: name,
                    enabled: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: Icon(Icons.search_outlined),
                        hintText: "Search..",
                        fillColor: Colors.white),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.015,
                ),
                Container(
                  width: res_width * 0.9,
                  child: Text(
                    'Popular Artist',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.013,
                ),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("artist")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    print(snapshot.hasData);
                    if (snapshot.hasError) {
                      return Center(child: CircularProgressIndicator());
                      // Handle errors
                    } else if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                      // Handle no data
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index];
                          print(snapshot.data!.docs[index]["fullName"]);
                          if (name.isEmpty) {
                            return ArtistBox(
                              '${data["fullName"]}',
                              '${data["userImage"]}',
                              '${data["description"]}',
                              data,
                            );
                          }
                          if (data['fullName']
                              .toString()
                              .toLowerCase()
                              .startsWith(name.toLowerCase())) {
                            return ArtistBox(
                                '${data["fullName"]}',
                                '${data["userImage"]}',
                                '${data["description"]}',
                                data);
                          }
                          return Container();
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),

                // ArtistBox('John Doe', 'assets/slicing/girl.jpeg',
                //     'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                // ArtistBox('Andy Marshal', 'assets/slicing/girl.jpeg',
                //     'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                // ArtistBox('Sarah Smith', 'assets/slicing/girl.jpeg',
                //     'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                // SizedBox(
                //   height: res_height * 0.135,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ArtistBox(name, image, description, data) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.025,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Get.to(() => ArtisProfileUserScreen(
                artistdata: data,
              ));
        },
        child: Container(
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
                        image: NetworkImage(image),
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
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 16),
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
        ),
      ),
    );
  }
}
