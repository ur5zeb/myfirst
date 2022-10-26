import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

bool _isChecked = false;

void main() {
  runApp(const MaterialApp(
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> getdata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var val = pref.getBool('save_user');
    if (val == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  initState() {
    bool value = false;

    super.initState();
    getdata().then((value) => null);
    if (value) {
      Future.delayed(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainForm(),
              )));
    } else {
      Future.delayed(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInForm(),
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/bg.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignInFormState();
  }
}

class _SignInFormState extends State<SignInForm> {
  late final String _password = '123456';
  late final String _login = 'admin';
  late final _passwordController = TextEditingController();
  late final _loginController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('SignIn form'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(50),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextFormField(
                controller: _loginController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter your login',
                    labelText: 'login *'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'Enter your password',
                  labelText: 'password *',
                ),
                obscuringCharacter: '*',
                obscureText: true,
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  const Text(
                    'Seve user',
                  ),
                  TextButton(
                    onPressed: submit,
                    child: const Text('Login'),
                  ),
                ],
              ),
            ])),
      ),
    );
  }

  setdata(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('save_user', value);
  }

  submit() {
    if ((_passwordController.text == _password) &
        (_loginController.text == _login)) {
      if (_isChecked) {
        setdata(true);
      }
      Future.delayed(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainForm(),
              )));
    } else {
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () => Navigator.pop(context, true),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error"),
      content: const Text("Incorrect username or password."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class _MainFormState extends State<MainForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Main form'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Hello'),
      ),
    );
  }
}

class MainForm extends StatefulWidget {
  const MainForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainFormState();
  }
}
