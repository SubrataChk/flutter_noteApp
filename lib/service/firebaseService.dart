import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFirebaseCLass {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  ///Data Add
  Future dataAdd(String title, String des, BuildContext context) async {
    await firestore
        .collection("data")
        .add({"title": title, "des": des}).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Todos Added")));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("There is some Error: $e")));
    });
  }

  Future updateData(
      String id, String title, String des, BuildContext context) async {
    await firestore
        .collection("data")
        .doc(id)
        .update({"title": title, "des": des}).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("We are update your data")));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("There is some error: $e")));
    });
  }

  Future dataDelete(String id, BuildContext context) async {
    await firestore.collection("data").doc(id).delete().then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("We delete your Todos")));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("There is some error: $e")));
    });
  }
}
