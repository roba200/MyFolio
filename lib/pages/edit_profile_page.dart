import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/Services/auth.dart';
import 'package:ui/Services/database.dart';
import 'package:ui/Services/storage.dart';

import '../widgets/rounded_text_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final formKey = GlobalKey<FormState>();
  String profileUrl = "";
  final _namecontroller = TextEditingController();
  final _biocontroller = TextEditingController();
  final _careercontroller = TextEditingController();
  final _skillscontroller = TextEditingController();
  final _educationcontroller = TextEditingController();
  final _facebookcontroller = TextEditingController();
  final _linkedinncontroller = TextEditingController();
  final _githubcontroller = TextEditingController();

  Future<void> refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        _namecontroller.text = value.get('name');
        _careercontroller.text = value.get('career');
        _biocontroller.text = value.get('bio');
        _skillscontroller.text = value.get('skills');
        _educationcontroller.text = value.get('education');
        _facebookcontroller.text = value.get('facebook');
        _linkedinncontroller.text = value.get('linkedin');
        _githubcontroller.text = value.get('github');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: refresh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Profile Edit",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 35.0),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          FutureBuilder(
                            future: Database().readField("url"),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return CircleAvatar(
                                  maxRadius: 80,
                                  backgroundImage: NetworkImage(snapshot.data!),
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                          // CircleAvatar(
                          //   maxRadius: 80,
                          //   backgroundImage: NetworkImage(
                          //       "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                          // ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                    onPressed: () async {
                                      await Storage()
                                          .pickUploadImage()
                                          .then((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text("Uploading...")));
                                        Timer(Duration(seconds: 5), () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Profile picture updated successfully!")));
                                          setState(() {});
                                        });
                                      });
                                    },
                                    icon: Icon(Icons.edit)),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(
                          //   "Hi,",
                          //   style: GoogleFonts.poppins(
                          //       fontSize: 30, fontWeight: FontWeight.bold),
                          // ),
                          FutureBuilder(
                            future: Database().readField("name"),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return Flexible(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    snapshot.data!,
                                    style: GoogleFonts.poppins(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            RoundedTextField(
                              hintText: "Name",
                              obsecureText: false,
                              controller: _namecontroller,
                              validator: (value) {
                                if (value!.length <= 0) {
                                  return "This Field Can't be Empty";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            RoundedTextField(
                              hintText: "Career",
                              obsecureText: false,
                              controller: _careercontroller,
                            ),
                            RoundedTextField(
                              maxLines: 5,
                              hintText: "Bio",
                              obsecureText: false,
                              controller: _biocontroller,
                            ),
                            RoundedTextField(
                              hintText: "Skills",
                              obsecureText: false,
                              controller: _skillscontroller,
                              maxLines: 5,
                            ),
                            RoundedTextField(
                              hintText: "Education",
                              obsecureText: false,
                              controller: _educationcontroller,
                              maxLines: 3,
                            ),
                            RoundedTextField(
                              hintText: "Facebook",
                              obsecureText: false,
                              controller: _facebookcontroller,
                            ),
                            RoundedTextField(
                              hintText: "LinkedIn",
                              obsecureText: false,
                              controller: _linkedinncontroller,
                            ),
                            RoundedTextField(
                              hintText: "Github",
                              obsecureText: false,
                              controller: _githubcontroller,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              final isValid = formKey.currentState!.validate();

                              if (isValid) {
                                //formKey.currentState?.save();
                                Database()
                                    .updateProfile(
                                        _namecontroller.text,
                                        _biocontroller.text,
                                        _careercontroller.text,
                                        _skillscontroller.text,
                                        _educationcontroller.text,
                                        _facebookcontroller.text,
                                        _linkedinncontroller.text,
                                        _githubcontroller.text)
                                    .then((value) => ScaffoldMessenger.of(
                                            context)
                                        .showSnackBar(SnackBar(
                                            content: Text(
                                                "Profile updated successfully!"))));
                              }

                              setState(() {});
                            },
                            child: Text(
                              "Update Profile",
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
