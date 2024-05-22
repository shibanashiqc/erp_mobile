part of 'main_cubit.dart';

abstract class MainState {
  const MainState();
}

class InitialMainState extends MainState {}

class LoadedMainState extends MainState {
   dynamic data;
   List<Errors> errors;
   LoadedMainState({this.data, this.errors = const []});  
}

class LoadingMainState extends MainState {
  const LoadingMainState();
}


class ChangeStatusState extends MainState {
  int status = 1;
  ChangeStatusState(
      {required this.status});
}

class ErrorMainState extends MainState {
  final String message;
  const ErrorMainState({required this.message});
}

class ValidationErrorState extends MainState {
  List<Errors> errors;
   ValidationErrorState({required this.errors});
}

class RefreshMainState extends MainState {
  const RefreshMainState();
}

class ChangeFormValuesState extends MainState {
  String type;
  dynamic value;
  ChangeFormValuesState(
      {required this.type, required this.value});
}

class PosModelState extends MainState { 
  dynamic subTotal = 0;
  dynamic tax = 0; 
  dynamic discount = 0;
  dynamic grandTotal = 0; 
  PosModelState({this.subTotal = 0, this.tax = 0, this.discount = 0, this.grandTotal = 0});
}
 
