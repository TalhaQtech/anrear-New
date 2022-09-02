import 'dart:typed_data';

import 'package:anrear/helper/colors.dart';
import 'package:anrear/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class test extends StatefulWidget {
  test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  Future<List<String>> getStringList() async {
    try {
      return Future.delayed(Duration(seconds: 1)).then(
        (value) => ['data1', 'data2', 'data3', 'data4'],
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  List listimg = [];

  void selectImage(ImageSource source) async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      // image = im;
      listimg.add(im);
      print(listimg.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder<List<String>?>(
            future: getStringList(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  if (snapshot.hasError)
                    return Text(snapshot.error.toString());
                  else
                    return ListView(
                      children: snapshot.data!.map((e) => Text(e)).toList(),
                    );

                default:
                  return Text('Unhandle State');
              }
            },
          ),
        ],
      ),
    );
  }
}
