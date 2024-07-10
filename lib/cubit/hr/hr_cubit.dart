// ignore_for_file: use_build_context_synchronously

// import 'dart:convert';

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:erp_mobile/models/hr/department_model.dart';
import 'package:erp_mobile/models/hr/employee_type_model.dart';
import 'package:erp_mobile/models/hr/roles_model.dart';
import 'package:erp_mobile/models/purchase/expene_model.dart';
import 'package:erp_mobile/models/purchase/extra_model.dart';
import 'package:erp_mobile/models/purchase/vendor_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/models/sales/customers_model.dart';
import 'package:erp_mobile/models/sales/sales_extra_model.dart';
import 'package:erp_mobile/repository/api_repository.dart';
import 'package:erp_mobile/screens/common/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hr_state.dart';

class HrCubit extends Cubit<HrState> {
  HrCubit() : super(InitialHrState());

  String title = '';
  String description = '';
  int status = 1;
  bool loading = false;

  final ApiRepository _repository = ApiRepository();

  void changeStatus(int status) {
    emit(ChangeStatusState(status: status));
  }

  void setValues(type, value) {
    emit(ChangeFormValuesState(type: type, value: value));
  }

  void changeTitle(String title) {
    emit(TitleState(title: title));
  }

  void changeDescription(String description) {
    emit(DescriptionState(description: description));
  }

  Future<DepartmentModel> getDepartments({limit = 10, next = 0}) async {
    try {
      loading = true;
      emit(const LoadingHrState());
      final res = await _repository.getDepartments(limit, next);
      loading = false;
      emit(const LoadedHrState());
      return res;
    } catch (e) {
      emit(ErrorHrState(message: e.toString()));
      rethrow;
    }
  }

  Future<SalesExtraModel> getExtraSales() async {
    try {
      emit(const LoadingHrState());
      var res = await _repository.get('', '', 'sales/extra-data');
      res = SalesExtraModel.fromJson(res);
      emit(const LoadedHrState());
      return res;
    } catch (e) {
      emit(ErrorHrState(message: e.toString()));
      rethrow;
    }
  }
  
  void validateError(List<Errors> errors) {
    emit(ValidationErrorState(errors: errors));
  }
  
  Future<ResponseModel> postRes(endpoint, Map<String, dynamic> data, BuildContext context, {multipart = false}) async {
    try {
      emit(const LoadingHrState());
      log(data.toString());
      var res = await _repository.post(data, endpoint, multipart: multipart);
      if (res.status == 'error') {
        validateError(res.errors!);
      } 
      emit(const LoadedHrState());
      alert(context, res.message ?? '',);
      return res;
    } catch (e) {
      emit(ErrorHrState(message: e.toString()));
      rethrow;
    }
  }


  Future<CustomersModel> getCustomers({limit = 10, next = 0, query}) async {
    try {
      loading = true;
      emit(const LoadingHrState());
      final res =
          await _repository.get(limit, next, 'sales/customers', query: query);
      loading = false;
      emit(const LoadedHrState());
      return CustomersModel.fromJson(res);
    } catch (e) {
      emit(ErrorHrState(message: e.toString()));
      rethrow;
    }
  }

  Future<VendorModel> getVendors({limit = 10, next = 0, query}) async {
    try {
      loading = true;
      emit(const LoadingHrState());
      final res =
          await _repository.get(limit, next, 'purchase/vendors', query: query);
      loading = false;
      emit(const LoadedHrState());
      return VendorModel.fromJson(res);
    } catch (e) {
      emit(ErrorHrState(message: e.toString()));
      rethrow;
    }
  }

  Future<ExpenseModel> getExpense({limit = 10, next = 0}) async {
    try {
      loading = true;
      emit(const LoadingHrState());
      final res = await _repository.get(limit, next, 'purchase/expense');
      loading = false;
      emit(const LoadedHrState());
      return ExpenseModel.fromJson(res);
    } catch (e) {
      emit(ErrorHrState(message: e.toString()));
      rethrow;
    }
  }

  Future<EmployeeTypeModel> getEmployeeTypes({limit = 10, next = 0}) async {
    try {
      loading = true;
      emit(const LoadingHrState());
      final res = await _repository.getEmployeeTypes(limit, next);
      loading = false;
      emit(const LoadedHrState());
      return res;
    } catch (e) {
      emit(ErrorHrState(message: e.toString()));
      rethrow;
    }
  }

  Future<ResponseModel> createDepartment(Map<String, dynamic> map, {id}) async {
    try {
      emit(const LoadingHrState());
      final res = await _repository.createDepartment(map);
      if (res.status == 'error') {
        emit(ValidationErrorState(errors: res.errors!));
      }
      emit(const LoadedHrState());
      return res;
    } catch (e) {
      emit(ErrorHrState(message: e.toString()));
      rethrow;
    }
  }

  Future<ResponseModel> createVendor(Map<String, dynamic> data) async {
    try {
      emit(const LoadingHrState());
      log(data.toString());
      var res = await _repository.post(data, 'purchase/update-or-create-vendor',
          multipart: true);

      if (res.status == 'error') {
        emit(ValidationErrorState(errors: res.errors!));
      }
      emit(const LoadedHrState());
      return res;
    } catch (e) {
      emit(ErrorHrState(message: e.toString()));
      rethrow;
    }
  }

  Future<ResponseModel> createPurchaseOrder(Map<String, dynamic> data) async {
    try {
      emit(const LoadingHrState());
      var res = await _repository.post(
          data, 'purchase/create-or-update-purchase-order',
          multipart: true);

      if (res.status == 'error') {
        emit(ValidationErrorState(errors: res.errors!));
      }
      emit(const LoadedHrState());
      return res;
    } catch (e) {
      emit(ErrorHrState(message: e.toString()));
      rethrow;
    }
  }

  Future<ResponseModel> creatExpense(Map<String, dynamic> data) async {
    try {
      emit(const LoadingHrState());
      log(data.toString());
      var res = await _repository
          .post(data, 'purchase/update-or-create-expense', multipart: true);

      if (res.status == 'error') {
        emit(ValidationErrorState(errors: res.errors!));
      }
      emit(const LoadedHrState());
      return res;
    } catch (e) {
      emit(ErrorHrState(message: e.toString()));
      rethrow;
    }
  }

  Future<ResponseModel> createCustomers(Map<String, dynamic> data) async {
    try {
      emit(const LoadingHrState());

      if (data['image'] is String) {
        data['image'] = data['image_url'];
      } else {
        data['image'] = data['image'].path != ''
            ? await MultipartFile.fromFile(data['image'].path)
            : data['image_url'];
      }
      var res = await _repository.post(data, 'sales/update-or-create-customer',
          multipart: true);

      if (res.status == 'error') {
        emit(ValidationErrorState(errors: res.errors!));
      }
      emit(const LoadedHrState());
      return res;
    } catch (e) {
      emit(ErrorHrState(message: e.toString()));
      rethrow;
    }
  }

  Future<ExtraModel> getExtra() async {
    try {
      emit(const LoadingHrState());
      var res = await _repository.get('', '', 'purchase/extra');
      res = ExtraModel.fromJson(res);
      emit(const LoadedHrState());
      return res;
    } catch (e) {
      emit(ErrorHrState(message: e.toString()));
      rethrow;
    }
  }

  Future<RolesModel> getRoles({limit = 10, next = 0, search = ''}) async {
    try {
      loading = true;
      emit(const LoadingHrState());
      final res = await _repository.getRoles(limit, next, search);
      loading = false;
      emit(const LoadedHrState());
      return res;
    } catch (e) {
      emit(ErrorHrState(message: e.toString()));
      rethrow;
    }
  }

  Future<ResponseModel> createRole(Map<String, dynamic> map, {id}) async {
    try {
      emit(const LoadingHrState());
      final res = await _repository.createRole(map);
      if (res.status == 'error') {
        emit(ValidationErrorState(errors: res.errors!));
      }
      emit(const LoadedHrState());
      return res;
    } catch (e) {
      emit(ErrorHrState(message: e.toString()));
      rethrow;
    }
  }

  Future<ResponseModel> createEmployeeType(Map<String, dynamic> map,
      {id}) async {
    try {
      emit(const LoadingHrState());
      final res = await _repository.createEmployeeType(map);
      if (res.status == 'error') {
        emit(ValidationErrorState(errors: res.errors!));
      }
      emit(const LoadedHrState());
      return res;
    } catch (e) {
      emit(ErrorHrState(message: e.toString()));
      rethrow;
    }
  }
}
