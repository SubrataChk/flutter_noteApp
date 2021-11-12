import 'package:flutter/material.dart';
import 'package:todo_list/model/model.dart';
import 'package:todo_list/screen/homepage.dart';
import 'package:todo_list/service/firebaseService.dart';
import 'package:todo_list/widget/customButton.dart';
import 'package:todo_list/widget/customTextField.dart';

class EditNotePage extends StatefulWidget {
  final DataModel data;
  EditNotePage({required this.data});

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<EditNotePage> {
  TextEditingController title = TextEditingController();
  TextEditingController des = TextEditingController();
  late String documentID;

  @override
  void initState() {
    title.text = widget.data.title;
    des.text = widget.data.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6E9BD4),
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Color(0xff6E9BD4),
                          title: Text("Please confirm!"),
                          content: Text(
                              "Are your sure you want to delete the Note?"),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  await CustomFirebaseCLass()
                                      .dataDelete(widget.data.id, context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ))
                          ],
                        );
                      });
                },
                icon: Icon(
                  Icons.delete,
                  size: 30,
                  color: Colors.red,
                ))
          ],
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
              title: "UPDATE",
              onTap: () async {
                // ignore: unnecessary_null_comparison
                // ignore: unrelated_type_equality_checks
                if (title.text == "" || des == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please update yours data!")));
                } else {
                  await CustomFirebaseCLass().updateData(
                      widget.data.id, title.text, des.text, context);
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
