part of 'staff_cubit.dart';

abstract class StaffState {
  const StaffState();
}

class InitialStaffState extends StaffState {}

class LoadedStaffState extends StaffState {
  const LoadedStaffState();
}

class LoadingStaffState extends StaffState {
  const LoadingStaffState();
}


class TitleState extends StaffState {
  String title;
  TitleState(
      {required this.title,});
}

class DescriptionState extends StaffState {
  String description;
  DescriptionState(
      {required this.description,});
}

class ChangeStatusState extends StaffState {
  int status = 1;
  ChangeStatusState(
      {required this.status});
}

class ErrorStaffState extends StaffState {
  final String message;
  const ErrorStaffState({required this.message});
}

class ValidationErrorState extends StaffState {
  List<Errors> errors;
   ValidationErrorState({required this.errors});
}

class RoleIdState extends StaffState {
  dynamic roleId;
  RoleIdState(
      {required this.roleId});
}

class ChangeFormValuesState extends StaffState {
  String type;
  dynamic value;
  ChangeFormValuesState(
      {required this.type, required this.value});
}
