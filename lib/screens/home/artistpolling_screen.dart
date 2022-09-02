import 'package:anrear/helper/colors.dart';
import 'package:anrear/screens/home/aristpolling_voting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtistPollingScreen extends StatefulWidget {
  var data;
  ArtistPollingScreen({Key? key, this.data}) : super(key: key);

  @override
  State<ArtistPollingScreen> createState() => _ArtistPollingScreen();
}

class _ArtistPollingScreen extends State<ArtistPollingScreen> {
  @override
  Widget build(BuildContext context) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/slicing/Bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          actions: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Get.to(() => ArtistVotingScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child:
                    Container(child: Image.asset('assets/slicing/polling.png')),
              ),
            )
          ],
          centerTitle: true,
          title: Text(
            'Artist Polling',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: res_width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: res_height * 0.015,
                      ),
                      Container(
                        width: res_width * 0.16,
                        height: res_width * 0.16,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: DecorationImage(
                            image: NetworkImage('${widget.data["userImage"]}'),
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
                        height: res_height * 0.01,
                      ),
                      Text('${widget.data["fullName"]}',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18)),
                      SizedBox(
                        height: res_height * 0.01,
                      ),
                      Container(
                        width: res_width * 0.6,
                        child: Center(
                          child: Text('${widget.data["description"]}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff929292),
                                height: 1.5,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: res_height * 0.01,
                      ),
                      Text(
                        'View Profile',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: res_height * 0.015,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: res_height * 0.015,
                ),
                Container(
                  width: res_width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.facebook_outlined,
                          color: kPrimaryColor,
                          size: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: res_height * 0.04,
                          width: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'https://www.facebook.com',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.03,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Text(
                      'Location Of Performance',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.015,
                ),
                LocationBox('John Doe', 'assets/slicing/girl.jpeg',
                    'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                LocationBox('Andy Marshal', 'assets/slicing/girl.jpeg',
                    'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                LocationBox('Sarah Smith', 'assets/slicing/girl.jpeg',
                    'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                LocationBox('Sarah Smith', 'assets/slicing/girl.jpeg',
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

  LocationBox(name, image, description) {
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
                width: res_width * 0.16,
                height: res_width * 0.16,
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
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                  ),
                  SizedBox(
                    height: res_height * 0.00075,
                  ),
                  Text(
                    'Performance Name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.black),
                  ),
                  //   SizedBox(
                  //   height: res_height * 0.00075,
                  // ),
                  Container(
                    width: res_width * 0.6,
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff929292),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
