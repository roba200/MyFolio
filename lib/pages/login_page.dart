import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/Services/auth.dart';
import 'package:ui/Services/database.dart';
import 'package:ui/pages/forget_password_page.dart';
import 'package:ui/widgets/rounded_text_field.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Sign In",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 35.0),
                          ),
                        ],
                      ),
                      RoundedTextField(
                          hintText: "example@abc.xxx",
                          obsecureText: false,
                          controller: _emailController,
                          validator: (value) {
                            if (value != null &&
                                !EmailValidator.validate(value)) {
                              return "Enter a valid email ";
                            } else {
                              return null;
                            }
                          }),
                      RoundedTextField(
                        hintText: "**********",
                        obsecureText: true,
                        controller: _passwordController,
                        validator: (value) {
                          if (value.length < 6) {
                            return "Password must be at least 6 charactors";
                          } else {
                            return null;
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgetPasswordPage()));
                              },
                              child: Text(
                                "Forget Password?",
                                style: GoogleFonts.poppins(
                                    color: Colors.blueAccent),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final isValid = formKey.currentState!.validate();
                              if (isValid) {
                                try {
                                  await Auth()
                                      .signIn(_emailController.text.trim(),
                                          _passwordController.text.trim())
                                      .then((value) =>
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text('Signed in as ' +
                                                  FirebaseAuth.instance
                                                      .currentUser!.email
                                                      .toString()),
                                            ),
                                          ));
                                } on FirebaseAuthException catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(e.message.toString()),
                                    ),
                                  );
                                }

                                print("ganesh");
                              }
                            },
                            child: Text(
                              "Sign In",
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
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Or",
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            FontAwesomeIcons.google,
                            size: 30,
                          ),
                          Icon(
                            FontAwesomeIcons.facebook,
                            size: 30,
                          ),
                          Icon(
                            FontAwesomeIcons.twitter,
                            size: 30,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text(
                        "Dont have an account? ",
                        style: GoogleFonts.poppins(),
                      ),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: Text(
                          "Create new one",
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
      ),
    );
  }
}
