import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

firestore_set(collection, doc, set) async {
  await FirebaseFirestore.instance
      .collection(collection.toString())
      .doc(doc.toString())
      .set(set);
}

firestore_update(collection, doc, data) {
  var dat = FirebaseFirestore.instance
      .collection("$collection")
      .doc("$doc")
      .update(data);
  return dat;
}

addfav(List like, uid, collection, doc) async {
  if (like.contains(uid)) {
    await firestore_update(collection, doc, {
      "fav": FieldValue.arrayRemove([uid]),
    });
  } else {
    await firestore_update(collection, doc, {
      "fav": FieldValue.arrayUnion([uid]),
    });
  }
}

firestore_get(collection, doc) async {
  DocumentSnapshot userData =
      await FirebaseFirestore.instance.collection(collection).doc(doc).get();
  return userData;
}

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Image Selected');
}
