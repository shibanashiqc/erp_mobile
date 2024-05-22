import 'dart:convert';
import 'dart:developer';

import 'package:erp_mobile/cubit/auth/login/login_cubit.dart';
import 'package:erp_mobile/models/hr/department_model.dart';
import 'package:erp_mobile/models/hr/employee_type_model.dart';
import 'package:erp_mobile/models/hr/hr_extra_data_model.dart';
import 'package:erp_mobile/models/hr/roles_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/repository/api_client.dart';

class ApiRepository {
   final ApiClient _apiClient = ApiClient();

    Future<LoginResponse> login(Map<String, dynamic> map) async {
      return await _apiClient.login(map); 
    } 
    
    Future<DepartmentModel> getDepartments(limit, next) async {
      return await _apiClient.getDepartments(limit, next);
    }
    
    Future<EmployeeTypeModel> getEmployeeTypes(limit, next) async {
      return await _apiClient.getEmployeeTypes(limit, next);
    }
    
    Future<ResponseModel> createDepartment(Map<String, dynamic> map) async {
      return await _apiClient.createDepartment(map);
    }
    
    Future<ResponseModel> createEmployeeType(Map<String, dynamic> map) async {
      return await _apiClient.createEmployeeType(map);
    }
    
    Future<ResponseModel> createRole(Map<String, dynamic> map) async {
      return await _apiClient.createRoles(map);
    }
    
    Future<RolesModel> getRoles(limit, next, search) async {
      return await _apiClient.getRoles(limit, next, search);
    }
    
    Future<HrExtraDataModel> getHrExtraDatas() async {
      return await _apiClient.getHrExtraData();
    }
    
    Future<ResponseModel> createStaff(Map<String, dynamic> map) async {
      return await _apiClient.createStaff(map);
    }
    
    Future<dynamic> get(limit, next, endpoint, {query}) async {
       var res = await _apiClient.get(limit, next, endpoint, query : query);
       return res;
    }
    
    Future<ResponseModel> post(Map<String, dynamic> data, endpoint, {multipart = false}) async {
      var res = await _apiClient.post(data, endpoint, multipart);
      return res;
    } 
    
}