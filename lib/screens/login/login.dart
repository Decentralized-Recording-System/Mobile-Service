// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telemetics/screens/index.dart';

import '../../logic/index.dart';
import '../../model/index.dart';
import '../../services/index.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const String id = 'Login';
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;
  LoginService loginService = LoginService();
  UserService getProfile = UserService();
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 163, 224, 196),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sign in',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: email,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 18, 175, 102)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 18, 175, 102)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        SignIn user = SignIn(
                            email: "pond_nattapoom@hotmail.com",
                            password: password.text);
                        try {
                          context
                              .read<LoginCubitCubit>()
                              .funcLogin(user)
                              .then((value) => {
                                    if (value)
                                      {
                                        Navigator.pushReplacementNamed(
                                            context, PassCodeSetting.id)
                                      }
                                  });
                        } catch (e) {
                          print(e.toString());
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 39, 179, 111),
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not registered yet?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Register.id);
                        },
                        child: const Text(
                          'Create an account',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 39, 179, 111)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
