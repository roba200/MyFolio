import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ui/widgets/rounded_text_field.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController _emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter Email and we will send you a reset link",
              style: TextStyle(fontSize: 15),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RoundedTextField(
                controller: _emailcontroller,
                hintText: 'Email',
                obsecureText: false,
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: _emailcontroller.text)
                        .then((value) => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                                content: Text("Reset link send to the " +
                                    _emailcontroller.text))));
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.message.toString())));
                  }
                },
                child: Text("Reset Password")),
          ],
        ),
      ),
    );
  }
}
