// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:flutter/material.dart';

class DataModel {
  String id;
  String title;
  String description;

  DataModel({required this.id, required this.description, required this.title});

  factory DataModel.fromJson(DocumentSnapshot snapshot) {
    return DataModel(
        id: snapshot.id,
        description: snapshot["des"],
        title: snapshot["title"]);
  }
}
