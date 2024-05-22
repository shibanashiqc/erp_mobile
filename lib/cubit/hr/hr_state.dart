part of 'hr_cubit.dart';

abstract class HrState {
  const HrState();
}

class InitialHrState extends HrState {}

class LoadedHrState extends HrState {
  const LoadedHrState();
}

class LoadingHrState extends HrState {
  const LoadingHrState();
}

class ValidationErrorState extends HrState {
  List<Errors> errors;
  ValidationErrorState({required this.errors});
}

class DepartmentFormState extends HrState {
  int? editId;
  String? title;
  String? description;
  int? status;
  DepartmentFormState(
      {this.editId, this.title, this.description, this.status});
}

class TitleState extends HrState {
  String title;
  TitleState(
      {required this.title,});
}

class DescriptionState extends HrState {
  String description;
  DescriptionState(
      {required this.description,});
}

class ChangeStatusState extends HrState {
  int status = 1;
  ChangeStatusState(
      {required this.status});
}

class ErrorHrState extends HrState {
  final String message;
  const ErrorHrState({required this.message});
}

class ChangeFormValuesState extends HrState {
  String type;
  dynamic value;
  ChangeFormValuesState(
      {required this.type, required this.value});
}
