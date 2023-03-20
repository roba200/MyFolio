import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/Services/auth.dart';
import 'package:ui/Services/database.dart';

import '../widgets/rounded_text_field.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignUpPage({super.key, required this.showLoginPage});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _namecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _passwordconfirmcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Sign Up",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 35.0),
                          ),
                        ],
                      ),
                      RoundedTextField(
                        hintText: "Name",
                        obsecureText: false,
                        controller: _namecontroller,
                        validator: (value) {
                          if (value.length <= 0) {
                            return "This field can't be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                      RoundedTextField(
                        hintText: "Email",
                        obsecureText: false,
                        controller: _emailcontroller,
                        validator: (value) {
                          if (value != null &&
                              !EmailValidator.validate(value)) {
                            return "Enter a valid email ";
                          } else {
                            return null;
                          }
                        },
                      ),
                      RoundedTextField(
                        hintText: "Password",
                        obsecureText: true,
                        controller: _passwordcontroller,
                        validator: (value) {
                          if (value.length < 6) {
                            return "This field can't be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                      RoundedTextField(
                        hintText: "Confirm Password",
                        obsecureText: true,
                        controller: _passwordconfirmcontroller,
                        validator: (value) {
                          if (value != _passwordcontroller.text) {
                            return "Password does not match";
                          } else {
                            return null;
                          }
                        },
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
                                if (_passwordconfirmcontroller.text ==
                                    _passwordcontroller.text) {
                                  try {
                                    Auth()
                                        .signUp(
                                            _emailcontroller.text.trim(),
                                            _passwordcontroller.text.trim(),
                                            _namecontroller.text)
                                        .then((value) => ScaffoldMessenger.of(
                                                context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Successfully create account for " +
                                                        FirebaseAuth.instance
                                                            .currentUser!.email
                                                            .toString()))));
                                  } on FirebaseAuthException catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text(e.message.toString())));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Paswords does not match")));
                                }
                              }
                            },
                            child: Text(
                              "Sign Up",
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
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.poppins(),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.poppins(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
