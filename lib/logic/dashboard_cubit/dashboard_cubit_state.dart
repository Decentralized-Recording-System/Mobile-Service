part of 'dashboard_cubit_cubit.dart';

@immutable
abstract class DashboardCubitState {
  const DashboardCubitState();

  @override
  List<Object> get props => [];
}

class DashboardCubitInitial extends DashboardCubitState {}

class DashBoardDataDrivingState extends DashboardCubitState {
  final List<Driving> drivingDataList;
  const DashBoardDataDrivingState({required this.drivingDataList});

  @override
  List<Object> get props => [drivingDataList];
}

class DashBoardDataDrivingResultState extends DashboardCubitState {
  final Map drivingDataList;
  const DashBoardDataDrivingResultState({required this.drivingDataList});

  @override
  List<Object> get props => [drivingDataList];
}

class HistoryModelCompanyState extends DashboardCubitState {
  final List<ModelCompany> modelList;
  const HistoryModelCompanyState({required this.modelList});

  @override
  List<Object> get props => [modelList];
}

class HistoryModelCompanyDetailState extends DashboardCubitState {
  final List<ModelCompanyDetail> modelDetailList;
  const HistoryModelCompanyDetailState({required this.modelDetailList});

  @override
  List<Object> get props => [modelDetailList];
}

class ContractState extends DashboardCubitState {
  final Map<dynamic, dynamic> contract;
  const ContractState({required this.contract});

  @override
  List<Object> get props => [contract];
}

class DashBoardLoadingState extends DashboardCubitState {
  const DashBoardLoadingState();
}

class HistoryState extends DashboardCubitState {
  const HistoryState();
}

class MyContractState extends DashboardCubitState {
  final List<MyContractModel> contract;
  const MyContractState({required this.contract});

  @override
  List<Object> get props => [contract];
}

class MyContractDetailState extends DashboardCubitState {
  final List<dynamic> contractDetail;
  const MyContractDetailState({required this.contractDetail});

  @override
  List<Object> get props => [contractDetail];
}
