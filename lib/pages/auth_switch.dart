import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ui/pages/login_page.dart';
import 'package:ui/pages/signup_page.dart';

class AuthSwitch extends StatefulWidget {
  const AuthSwitch({super.key});

  @override
  State<AuthSwitch> createState() => _AuthSwitchState();
}

class _AuthSwitchState extends State<AuthSwitch> {
  bool showLoginPage = true;

  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: toggleScreen);
    } else {
      return SignUpPage(
        showLoginPage: toggleScreen,
      );
    }
  }
}
