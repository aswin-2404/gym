import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../main.dart';
import 'Member_home_page.dart';




class Member_add_physical_details extends StatefulWidget {
  const Member_add_physical_details({Key? key}) : super(key: key);

  @override
  _Member_add_DataState createState() => _Member_add_DataState();
}

class _Member_add_DataState extends State<Member_add_physical_details> {

  var _image;
  final picker = ImagePicker();



  TextEditingController _name = TextEditingController();
  TextEditingController hieght = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController bp = TextEditingController();




  late bool status;

  late String message;

  File? get filePath => null;

  get ref => null;

  @override
  void initState() {



    status = false;
    message = "";

    super.initState();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future choose_image_gallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this._image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future choose_image_camera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this._image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green.shade50,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Add Physical Details'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   height : 240,
            //
            //   child:  Image.asset('assets/images/c8.avif'),),
            Container(
              // margin: EdgeInsets.all(30),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                // border:Border.all(width:2,color: Colors.green.shade600),
                // borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              // height: MediaQuery.of(context).size.height,
              // width: double.infinity,
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _name,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a Name";
                        }
                        return null;
                      },
                      onSaved: (name) {},
                      obscureText: false,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 2, color: Colors.grey.shade900),
                        ),
                        label: Text("Name"),
                        labelStyle: TextStyle(color: Colors.black),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Colors.grey[400],
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: hieght,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter  your height";
                        }
                        return null;
                      },
                      onSaved: (phone) {},
                      obscureText: false,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 2, color: Colors.grey.shade900),
                        ),
                        label: Text("height in centimeter"),
                        labelStyle: TextStyle(color: Colors.black),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Colors.grey[400],
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            )),
                      ),
                    ),





                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: weight,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your weight";
                        }
                        return null;
                      },
                      onSaved: (name) {},
                      obscureText: false,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 2, color: Colors.grey.shade900),
                        ),
                        label: Text("weight"),
                        labelStyle: TextStyle(color: Colors.black),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Colors.grey[400],
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    TextFormField(
                      controller: bp,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter  BP ";
                        }

                        if (int.parse(value) <80) {
                          return 'you have low Bp please consult a doctor';
                        }
                        if (int.parse(value) >120) {
                          return 'you have high Bp please consult a doctor';
                        }

                        return null;
                      },
                      onSaved: (value) {},
                      obscureText: false,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 2, color: Colors.grey.shade900),
                        ),
                        label: Text("BP"),
                        labelStyle: TextStyle(color: Colors.black),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Colors.grey[400],
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),






                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Upload medical certificate",
                          style: GoogleFonts.hindVadodara(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.photo_outlined,
                            size: 35,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            choose_image_gallery();
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            size: 35,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            choose_image_camera();
                          },
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                          height: 100,
                          width: 200,
                          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),  color: Colors.grey,
                          //),

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: _image != null
                                ? Image.file(
                              _image,
                              fit: BoxFit.cover,
                            )
                                : Center(
                                child: Text(
                                  "No image selected",
                                  style: GoogleFonts.hindVadodara(
                                      fontSize: 13,
                                      color: Colors.red.shade900),
                                )),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 17,
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            setState(()  {
                              uploadimage();
                              //print("member name is ${member_name}");

                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => memberhome(),
                              //   ),
                              // );
                            });
                          }
                        },
                        child: Text(
                          'CONTINUE',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),

                //],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadimage() async {
    // print(_image);

    String fileName = _image.path.split('/').last;

    var snapshot = await FirebaseStorage.instance
        .ref()
        .child('My_images/$fileName')
        .putFile(_image);

    var url = await snapshot.ref.getDownloadURL();

    var image_url = url.toString();

    Map<String, dynamic> demodata = {

      "name": _name.text,
      "hieght": hieght.text,
      "weight": weight.text,
      "bp":bp.text,
      "image": image_url,


    };


    //member_Image =image_url;

    FirebaseFirestore.instance
        .collection("Member_Physical_data")
        .doc("$email_get")
        .set(demodata)
        .whenComplete(()  {

      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => memberhome(),
          ),
        );
      });


      Fluttertoast.showToast(
        msg: "Inserted successfully",
      );
    });

    //   collectionreference.add(demodata).
    //     .whenComplete(() {
    //   Fluttertoast.showToast(
    //     msg: "Inserted successfully",
    //     // // toastLength: Toast.LENGTH_SHORT,
    //     // backgroundColor: Colors.teal,
    //     // textColor: Colors.white
    //   );
    // });
  }




}
