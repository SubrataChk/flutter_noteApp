import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/screen/homepage.dart';
import 'package:todo_list/service/firebaseService.dart';
import 'package:todo_list/widget/customButton.dart';
import 'package:todo_list/widget/customTextField.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController title = TextEditingController();
  TextEditingController des = TextEditingController();

  @override
  void initState() {
    title = TextEditingController();
    des = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6E9BD4),
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
                size: 30,
              )),
          backgroundColor: Color(0xff6E9BD4),
          centerTitle: true,
          title: Text(
            "Note",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 28),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitle(
              title: "Title",
            ),
            CustomTextFormField(
              controller: title,
              lineHeight: 1,
              fontStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Colors.black),
              hintText: "Title",
            ),
            CustomTitle(
              title: "Description",
            ),
            CustomTextFormField(
              controller: des,
              lineHeight: 6,
              fontStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
              hintText: "Description",
            ),
            SizedBox(
              height: 40,
            ),
            CustomButtom(
              title: "SAVE",
              onTap: () async {
                // ignore: unnecessary_null_comparison
                // ignore: unrelated_type_equality_checks
                if (title.text == "" || des == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Fill up all data please!")));
                } else {
                  await CustomFirebaseCLass()
                      .dataAdd(title.text, des.text, context);
                  setState(() {
                    title.clear();
                    des.clear();
                  });
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomTitle extends StatelessWidget {
  final String title;

  const CustomTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 20),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
      ),
    );
  }
}
