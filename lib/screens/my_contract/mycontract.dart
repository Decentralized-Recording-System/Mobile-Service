import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/dashboard_cubit/dashboard_cubit_cubit.dart';

class MyDetailContract extends StatefulWidget {
  const MyDetailContract({super.key});
  static const String id = 'MyDetailContract';
  @override
  State<MyDetailContract> createState() => _MyDetailContractState();
}

class _MyDetailContractState extends State<MyDetailContract> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My detail Contract"),
      ),
      body: BlocConsumer<DashboardCubitCubit, DashboardCubitState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is MyContractDetailState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ...state.contractDetail
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.75),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(1,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 300,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 1,
                                                      horizontal: 1),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    e['a'],
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .headline2!
                                                          .color,
                                                    ),
                                                  ),
                                                  Text(
                                                    e['b'],
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .headline2!
                                                          .color,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
