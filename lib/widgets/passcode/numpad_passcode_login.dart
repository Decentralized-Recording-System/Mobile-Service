import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/dashboard_cubit/dashboard_cubit_cubit.dart';
import '../../screens/index.dart';
import '../../services/index.dart';
import 'index.dart';

class NumpadLogin extends StatefulWidget {
  final int length;

  const NumpadLogin({
    super.key,
    required this.length,
  });

  @override
  _NumpadLoginState createState() => _NumpadLoginState();
}

class _NumpadLoginState extends State<NumpadLogin> {
  String number = '';
  final String password = "34201";
  late PassCodePwdDatabase passCodeDatabase;
  setValue(String val) {
    if (number.length < widget.length) {
      setState(() {
        number += val;
      });
    }
  }

  backspace(String text) {
    if (text.isNotEmpty) {
      setState(() {
        number = text.split('').sublist(0, text.length - 1).join('');
      });
    }
  }

  void validate() {
    passCodeDatabase.readData(1).then((value) => {
          if (number.length > widget.length - 1)
            {
              if (number != value.pwdPassCode)
                {
                  setState(() {
                    number = '';
                  })
                }
              else if (number == value.pwdPassCode)
                {
                  setState(() {
                    context
                        .read<DashboardCubitCubit>()
                        .funcGetDataDrivingResult();
                    number = '';
                  })
                }
            }
        });
  }

  @override
  void initState() {
    passCodeDatabase = PassCodePwdDatabase.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    validate();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: <Widget>[
          Preview(text: number, length: widget.length),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '1',
                onPressed: () => setValue('1'),
              ),
              NumpadButton(
                text: '2',
                onPressed: () => setValue('2'),
              ),
              NumpadButton(
                text: '3',
                onPressed: () => setValue('3'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '4',
                onPressed: () => setValue('4'),
              ),
              NumpadButton(
                text: '5',
                onPressed: () => setValue('5'),
              ),
              NumpadButton(
                text: '6',
                onPressed: () => setValue('6'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '7',
                onPressed: () => setValue('7'),
              ),
              NumpadButton(
                text: '8',
                onPressed: () => setValue('8'),
              ),
              NumpadButton(
                text: '9',
                onPressed: () => setValue('9'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const NumpadButton(haveBorder: false),
              NumpadButton(
                text: '0',
                onPressed: () => setValue('0'),
              ),
              NumpadButton(
                haveBorder: false,
                icon: Icons.backspace,
                onPressed: () => backspace(number),
              ),
            ],
          )
        ],
      ),
    );
  }
}
