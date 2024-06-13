import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:erp_mobile/cubit/auth/login/login_cubit.dart';
import 'package:erp_mobile/models/hr/department_model.dart';
import 'package:erp_mobile/models/hr/employee_type_model.dart';
import 'package:erp_mobile/models/hr/hr_extra_data_model.dart';
import 'package:erp_mobile/models/hr/roles_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  final Dio _dio = Dio();
  static const baseURl = 'https://erp.themetrodental.com/api/';
  // static const baseURl = 'https://22e7597fb9efb80c73ab99c49ee508ba.serveo.net/api/';

  ApiClient() {
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: false,
          requestBody: true,
          responseHeader: false,
          error: true));
    }
  }

  Future<LoginResponse> login(Map<String, dynamic> map) async {
    try {
      final response = await _dio.post(
        '${baseURl}auth/login',
        data: map,
      );
      if (kDebugMode) {
        print(response);
      }

      return LoginResponse.fromJson(jsonDecode(response.toString()));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<DepartmentModel> getDepartments(limit, next) async {
    try {
      final url = '${baseURl}hr/departments?per_page=$limit&page=$next';
      final token = await LoginCubit().getToken();
      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await _dio.get(
        url,
        options: Options(headers: headers),
      );
      if (kDebugMode) {
        print(response);
      }
      return DepartmentModel.fromJson(jsonDecode(response.toString()));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<EmployeeTypeModel> getEmployeeTypes(limit, next) async {
    try {
      final url = '${baseURl}hr/employee-types?per_page=$limit&page=$next';
      final token = await LoginCubit().getToken();
      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await _dio.get(
        url,
        options: Options(headers: headers),
      );
      if (kDebugMode) {
        print(response);
      }
      return EmployeeTypeModel.fromJson(jsonDecode(response.toString()));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<ResponseModel> createDepartment(Map<String, dynamic> map) async {
    try {
      const url = '${baseURl}hr/update-or-create-department';
      final token = await LoginCubit().getToken();
      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response = await _dio.post(
        url,
        data: map,
        options: Options(headers: headers),
      );

      if (kDebugMode) {
        print(response);
      }

      return ResponseModel.fromJson(jsonDecode(response.toString()));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<ResponseModel> createEmployeeType(Map<String, dynamic> map) async {
    try {
      const url = '${baseURl}hr/update-or-create-employee-type';
      final token = await LoginCubit().getToken();
      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response = await _dio.post(
        url,
        data: map,
        options: Options(headers: headers),
      );

      if (kDebugMode) {
        print(response);
      }

      return ResponseModel.fromJson(jsonDecode(response.toString()));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<ResponseModel> createRoles(Map<String, dynamic> map) async {
    try {
      const url = '${baseURl}hr/update-or-create-role';
      final token = await LoginCubit().getToken();
      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response = await _dio.post(
        url,
        data: map,
        options: Options(headers: headers),
      );

      if (kDebugMode) {
        print(response);
      }

      return ResponseModel.fromJson(jsonDecode(response.toString()));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<RolesModel> getRoles(limit, next, search) async {
    try {
      final url = '${baseURl}hr/roles?per_page=$limit&page=$next';
      final token = await LoginCubit().getToken();
      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await _dio.get(
        url,
        options: Options(headers: headers), 
        queryParameters: {'search': search},  
      );
      if (kDebugMode) {
        print(response);
      }
      return RolesModel.fromJson(jsonDecode(response.toString()));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<HrExtraDataModel> getHrExtraData() async {
    try {
      const url = '${baseURl}hr/extra-data';
      final token = await LoginCubit().getToken();
      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await _dio.get(
        url,
        options: Options(headers: headers),
      );
      if (kDebugMode) {
        print(response);
      }
      return HrExtraDataModel.fromJson(jsonDecode(response.toString()));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<ResponseModel> createStaff(Map<String, dynamic> map) async {
    try {
      const url = '${baseURl}hr/create-staff';
      final token = await LoginCubit().getToken();
      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final formData = FormData.fromMap(map);
      final response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );

      if (kDebugMode) {
        print(response);
      }

      return ResponseModel.fromJson(jsonDecode(response.toString()));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<dynamic> get(limit, next, String endpoint, {query}) async {
    try {
      final url = '$baseURl$endpoint?per_page=$limit&page=$next';
      final token = await LoginCubit().getToken();  
      final headers = { 
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await _dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: query, 
      );

      if (kDebugMode) {
        print(response);
      }
      return jsonDecode(response.toString());
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // await LoginCubit().logout();
        return null;
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<ResponseModel> post(
      Map<String, dynamic> data, String endpoint, multipart, useDio) async {
    try {
      final url = '$baseURl$endpoint';
      final token = await LoginCubit().getToken();
      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      
      //data get files from data
      data.forEach((key, value) {
        log(key);  
      });

      final response = await _dio
          .post(
            url,
            data: multipart ? FormData.fromMap(data) : data,
            options: Options(headers: headers),
          )
          // .then((value) => {log(value.toString())})
          ; 
          
          log(response.toString());   
      return ResponseModel.fromJson(jsonDecode(response.toString()));
    }  catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
    
  }
}
