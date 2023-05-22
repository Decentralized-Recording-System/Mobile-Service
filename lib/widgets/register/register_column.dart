import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telemetics/widgets/register/register_detail.dart';

import '../../logic/index.dart';
import '../../model/index.dart';
import '../../screens/index.dart';
import '../../screens/register/register_detail.dart';

class RegisterColumn extends StatefulWidget {
  const RegisterColumn({super.key});

  @override
  State<RegisterColumn> createState() => _RegisterColumnState();
}

class _RegisterColumnState extends State<RegisterColumn> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Sign up',
            style: TextStyle(
              color: Theme.of(context).textTheme.headline1!.color,
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
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'First name',
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Theme.of(context).primaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Last name',
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Theme.of(context).primaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Theme.of(context).primaryColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  maxLines: 1,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Theme.of(context).primaryColor,
                    ),
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(
                          context, RegisterDetailPage.id,
                          arguments: {
                            "email": "yruzkid34201@gmail.com",
                            "name": "nattapoom",
                            "lastName": "petchana",
                            "password": 1234,
                          });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                  ),
                  child: const Text(
                    'Next',
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
                    Text(
                      'Already registered?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
