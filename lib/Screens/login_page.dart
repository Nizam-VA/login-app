import 'package:flutter/material.dart';
import 'package:login_demo/Screens/home_page.dart';
import 'package:login_demo/Screens/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg_image.jpg'),
                opacity: .95,
                fit: BoxFit.cover)),
        child: Center(
          child: Container(
            width: 320,
            height: 340,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFFFFF).withOpacity(.6),
              border: Border.all(
                width: .2,
                color: Colors.black,
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      'LOGIN',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.purple[600],
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: TextFormField(
                      controller: _userNameController,
                      validator: (value) {
                        const pattern =
                            r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                            r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                            r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                            r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                            r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                            r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                            r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                        final regex = RegExp(pattern);

                        if (value == null || value.isEmpty) {
                          return 'Value is is empty!!';
                        } else if (!regex.hasMatch(value)) {
                          return 'Enter valid e-mail!!';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          hintText: 'E-mail id: ',
                          suffixIcon: const Icon(
                            Icons.person_2_rounded,
                            color: Colors.purple,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                        if (value == null || value.isEmpty) {
                          return 'Value is is empty!!';
                        } else if (!regex.hasMatch(value)) {
                          return 'Enter valid password!!';
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password: ',
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: Icon(passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              validateLogin(context);
                            } else {
                              print('Data is Empty');
                            }
                          },
                          child: Text('LOGIN'),
                        ),
                        Visibility(
                          visible: false,
                          child: Text(
                            'Password or Username doesnot match!',
                            style: TextStyle(
                              color: Colors.red[900],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  validateLogin(BuildContext ctx) async {
    final _username = _userNameController.text;
    final _password = _passwordController.text;

    final _user = 'nizamuasharaf@gmail.com';
    final _pass = 'Nizamu@11';

    if (_username == _user && _password == _pass) {
      final _pref = await SharedPreferences.getInstance();
      await _pref.setBool(SAVE_KEY_NAME, true);
      Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(
          builder: (ctx1) => HomeScreen(),
        ),
      );
    } else {
      print(_pass);
      print(_user);
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Password or Username doesnot match'),
          margin: EdgeInsets.all(8),
          backgroundColor: Colors.red[400],
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
