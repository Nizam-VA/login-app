import 'package:flutter/material.dart';
import 'package:login_demo/Screens/home_page.dart';
import 'package:login_demo/Screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

const SAVE_KEY_NAME = 'UserLoggedIn';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: Image.asset(
          'assets/images/markaz.png',
          height: 80,
        ),
      ),
    );
  }

  Future<void> gotoLogin() async {
    Future.delayed(Duration(seconds: 5));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScreenLogin(),
      ),
    );
  }

  Future<void> checkUserLoggedIn() async {
    final _pref = await SharedPreferences.getInstance();
    final _userLoggedIn = _pref.getBool(SAVE_KEY_NAME);
    if (_userLoggedIn == null || _userLoggedIn == false) {
      gotoLogin();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        ),
      );
    }
  }
}
