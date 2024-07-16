// import 'package:erp_mobile/repository/api_repository.dart';


// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:erp_mobile/models/hr/hr_extra_data_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/repository/api_repository.dart';
import 'package:erp_mobile/screens/common/alert.dart';
import 'package:erp_mobile/utils/validater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'staff_state.dart';

class StaffCubit extends Cubit<StaffState> {
  StaffCubit() : super(InitialStaffState());

  final ApiRepository _repository = ApiRepository();

  void changeStatus(int status) {
    emit(ChangeStatusState(status: status));
  }

  void changeTitle(String title) {
    emit(TitleState(title: title));
  }

  void changeRoleId(dynamic roleId) {
    emit(RoleIdState(roleId: roleId));
  }

  void changeDescription(String description) {
    emit(DescriptionState(description: description));
  }

  void changeFormValues(String type, dynamic value) {
    emit(ChangeFormValuesState(type: type, value: value));
  }

  Future<ResponseModel> createStaff(Map<String, dynamic> map, BuildContext context, {id}) async {
    try {
      emit(const LoadingStaffState());
      final response = await _repository.createStaff(map);
      alert(context, response.message ?? ''); 
      if (response.status == 'error') {    
        emit(ValidationErrorState(errors: response.errors!)); 
      } 
      emit(const LoadedStaffState());
      return response; 
    } catch (e) {
      emit(ErrorStaffState(message: e.toString()));
      rethrow;
    }
  }
  
  Future<HrExtraDataModel> getExtraData() async {
    try {
      emit(const LoadingStaffState());
      final response = await _repository.getHrExtraDatas();
      emit(const LoadedStaffState());
      return response;
    } catch (e) {
      emit(ErrorStaffState(message: e.toString()));
      rethrow;
    }
  }

}
