import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmLocationScreen extends StatefulWidget {
  const ConfirmLocationScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmLocationScreen> createState() => _ConfirmLocationScreen();
}

class _ConfirmLocationScreen extends State<ConfirmLocationScreen> {
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
          leading: Padding(
            padding: const EdgeInsets.all(13.0),
            child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back_ios)),
          ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.all(13.0),
          //     child: Container(
          //         child: Image.asset('assets/slicing/notfication.png')),
          //   )
          // ],
          centerTitle: true,

          title: Text(
            'Confirmed Locations',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ConfirmLocationBox(
                //     'John Doe',
                //     'assets/slicing/girl.jpeg',
                //     'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.',
                //     'Confirm'),
                // ConfirmLocationBox(
                //     'John Doe',
                //     'assets/slicing/girl.jpeg',
                //     'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.',
                //     'Confirm'),
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

  ConfirmLocationBox(name, image, description, status) {
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Performance Name',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black,
                              height: 1.5,
                            )),
                        // Spacer(),
                        Row(
                          children: [
                            Text('Location 1: ',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black,
                                  height: 1.5,
                                )),
                            Text('Confirm ',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.green,
                                  height: 1.5,
                                ))
                          ],
                        )
                      ],
                    ),
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
                          ))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
