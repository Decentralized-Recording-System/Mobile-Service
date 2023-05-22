import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/i18n/app_localizations.dart';
import '../../logic/dashboard_cubit/dashboard_cubit_cubit.dart';

class MyContractBox extends StatefulWidget {
  const MyContractBox(
      {super.key,
      required this.modelContractName,
      required this.modelContractId});
  final String modelContractName;
  final String modelContractId;
  @override
  State<MyContractBox> createState() => _MyContractBoxState();
}

class _MyContractBoxState extends State<MyContractBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<DashboardCubitCubit>()
            .funcGetContractDetail(widget.modelContractId);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.75),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(1, 1), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Icon(
                          Icons.contact_page,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      )),
                  Expanded(
                    flex: 6,
                    child: Text(
                      '${widget.modelContractName} บาท',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline2!.color,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                              AppLocalizations.of(context)!.translate('Detail'),
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorDark,
                              )),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).primaryColor,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
