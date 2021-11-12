import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:todo_list/model/model.dart';
import 'package:todo_list/screen/editnote.dart';
import 'package:todo_list/screen/note.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      backgroundColor: Color(0xff6E9BD4),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffFF9933),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NotePage()));
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 33,
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("data").get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    /// Model setting on data
                    DataModel data =
                        DataModel.fromJson(snapshot.data.docs[index]);
                    return Card(
                      color: Colors.teal,
                      elevation: 8,
                      margin: EdgeInsets.all(12),
                      child: ListTile(
                        onLongPress: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditNotePage(data: data)));
                        },
                        title: Text(
                          data.title,
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        subtitle: Text(
                          data.description,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    );
                  });
            } else {
              ///////
              return Center(
                child:
                    Lottie.asset("assets/note.json", height: 400, width: 400),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
