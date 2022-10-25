import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/index.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubitCubit, LoginCubitState>(
        builder: (context, state) {
      if (state is StateAuthLoading) {
        if (state.loadingStatus == true) {
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
              child: Center(
                  child: Container(
                width: MediaQuery.of(context).size.width / 1.13,
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: CircularProgressIndicator()),
              )));
        }
      }
      return const CircularProgressIndicator();
    });
  }
}
