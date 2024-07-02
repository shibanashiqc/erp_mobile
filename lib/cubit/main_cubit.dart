// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:erp_mobile/models/appointments/appointment_extra_model.dart';
import 'package:erp_mobile/models/appointments/appointments_model.dart';
import 'package:erp_mobile/models/hr/hr_extra_data_model.dart';
import 'package:erp_mobile/models/pos/pos_order_model.dart';
import 'package:erp_mobile/models/pos/products_model.dart';
import 'package:erp_mobile/models/product/product_extra_model.dart';
import 'package:erp_mobile/models/production/clients_model.dart';
import 'package:erp_mobile/models/production/production_extra_model.dart';
import 'package:erp_mobile/models/production/project_chat_model.dart';
import 'package:erp_mobile/models/production/projects_model.dart';
import 'package:erp_mobile/models/production/team_users_model.dart';
import 'package:erp_mobile/models/production/teams_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/models/sales/sales_extra_model.dart';
import 'package:erp_mobile/models/sales/sales_orders_model.dart';
import 'package:erp_mobile/repository/api_repository.dart';
import 'package:erp_mobile/screens/common/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:erp_mobile/models/pos/products_model.dart' as pos;

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(InitialMainState());

  final ApiRepository _repository = ApiRepository();
  bool isLoading = false;

  void changeStatus(int status) {
    emit(ChangeStatusState(status: status));
  }

  void changeFormValues(String type, dynamic value) {
    emit(ChangeFormValuesState(type: type, value: value));
  }

  void validateError(List<Errors> errors) {
    emit(ValidationErrorState(errors: errors));
  }

  void sumCart(total, {tax = 0, discount = 0}) {
    if (tax != 0) {
      total = total + (total * tax / 100);
    }

    if (discount != 0) {
      total = total - (total * discount / 100);
    }

    emit(LoadedMainState(data: {
      'subTotal': total,
      'tax': tax,
      'discount': discount,
      'grandTotal': total
    }));
  }

  Future<ResponseModel> deleteAppointment(id) async {
    try {
      emit(const LoadingMainState());
      var res = await _repository.post({'id': id}, 'appointment/delete');
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }

  refreshState() async {
    emit(const LoadingMainState());
    emit(LoadedMainState());
  }

  Future<SalesOrderModel> getSalesOrders(
      {limit = 8, next = 0, search = ''}) async {
    try {
      emit(const LoadingMainState());
      var res = await _repository.get(limit, next, 'sales/sales_orders',
          query: {'order_number': search});
      res = SalesOrderModel.fromJson(res);
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }

  Future<PosOrderModel> getPosOrders({limit = 8, next = 0, query = ''}) async {
    try {
      emit(const LoadingMainState());
      var res = await _repository.get(limit, next, 'pos/orders', query: query);
      res = PosOrderModel.fromJson(res);
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }

  Future<AppointmentsModel> getAppointments({limit = 8, next = 0}) async {
    try {
      emit(const LoadingMainState());
      var res = await _repository.get(limit, next, 'appointment/list');
      res = AppointmentsModel.fromJson(res);
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }
  
  
  Future<ProjectsModel> getProjects({limit = 8, next = 0, query}) async {
    try {
      emit(const LoadingMainState()); 
      var res = await _repository.get(limit, next, 'production/projects', query: query);
      res = ProjectsModel.fromJson(res);
      emit(LoadedMainState()); 
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }
  
  Future<ProjectChatModel> getMessages(id, {limit = 8, next = 0, query}) async {
    try { 
      emit(const LoadingMainState());  
      var res = await _repository.get(limit, next, 'production/project/$id/discussions', query: query);
      res = ProjectChatModel.fromJson(res);
      emit(LoadedMainState()); 
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }
  
  

  Future<AppointmentExtraModel> getAppointmentExtra(
      {limit = 8, next = 0}) async {
    try {
      emit(const LoadingMainState());
      var res = await _repository.get(limit, next, 'appointment/extra-data');
      res = AppointmentExtraModel.fromJson(res);
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }
  
  Future<ProductionExtraModel> getExtraProduction(
      {limit = 8, next = 0}) async {
    try {
      emit(const LoadingMainState());
      var res = await _repository.get(limit, next, 'production/extra');
      res = ProductionExtraModel.fromJson(res);
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }

  Future<HrExtraDataModel> getExtraData() async {
    try {
      emit(const LoadingMainState());
      final response = await _repository.getHrExtraDatas();
      emit(LoadedMainState());
      return response;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }

  Future<SalesExtraModel> getExtraSales() async {
    try {
      emit(const LoadingMainState());
      var res = await _repository.get('', '', 'sales/extra-data');
      res = SalesExtraModel.fromJson(res);
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }
  
  Future<TeamUsersModel> getTeamMembers(id, {limit = 8, next = 0}) async {
    try {
      emit(const LoadingMainState());
      var res = await _repository.get(limit, next, 'production/team/$id/members');
      res = TeamUsersModel.fromJson(res);
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }
  
  Future<ResponseModel> postResDyn(endpoint, data, BuildContext context) async {
    try {
      emit(const LoadingMainState()); 
      log(data.toString()); 
      var res = await _repository.post(data, endpoint);
      if (res.status == 'error') { 
        validateError(res.errors!);
      } 
      emit(LoadedMainState());
      alert(context, res.message ?? '',);
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }


  Future<ResponseModel> postRes(endpoint, Map<String, dynamic> data, BuildContext context) async {
    try {
      emit(const LoadingMainState());
      log(data.toString());
      var res = await _repository.post(data, endpoint);
      if (res.status == 'error') {
        validateError(res.errors!);
      } 
      emit(LoadedMainState());
      alert(context, res.message ?? '',);
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }

  Future<ResponseModel> createSalesOrder(Map<String, dynamic> data) async {
    try {
      emit(const LoadingMainState());
      log(data.toString());
      var res = await _repository.post(data, 'sales/create_sales_order');

      if (res.status == 'error') {
        validateError(res.errors!);
      }
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }
  
  Future<ResponseModel> save(Map<String, dynamic> data, String endpoint) async {
    try {
      emit(const LoadingMainState());
      log(data.toString());
      var res = await _repository.post(data, endpoint, multipart: true);

      if (res.status == 'error') {
        validateError(res.errors!);
      } 
      emit(LoadedMainState());
      return res; 
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }
  
  
  Future<ResponseModel> createOrUpdateProject(Map<String, dynamic> data) async {
    try {
      emit(const LoadingMainState());
      log(data.toString());
      var res = await _repository.post(data, 'production/update-or-create-project', multipart: true);

      if (res.status == 'error') {
        validateError(res.errors!);
      }
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }
  
  Future<ResponseModel> submit(String endpoint, Map<String, dynamic> data) {
    try {
      emit(const LoadingMainState());
      var res = _repository.post(data, endpoint, multipart: true);
      
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }

  Future<ResponseModel> updateUser(Map<String, dynamic> data) {
    try {
      emit(const LoadingMainState());
      var res = _repository.post(data, 'user/update');
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }

  Future<ResponseModel> createAppointment(Map<String, dynamic> data) async {
    try {
      emit(const LoadingMainState());
      log(data.toString());
      var res = await _repository.post(data, 'appointment/create');

      if (res.status == 'error') {
        validateError(res.errors!);
      }
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }

  Future<ResponseModel> deleteProduct(Map<String, dynamic> data) {
    try {
      emit(const LoadingMainState());
      var res = _repository.post(data, 'product/delete-product');
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }

  Future<ResponseModel> createOrUpdateProduct(Map<String, dynamic> data) async {
    try {
      emit(const LoadingMainState());
      var res = await _repository.post(data, 'product/update-or-create-product',
          multipart: true);
      // log(res.toString());
      // emit(LoadedMainState(errors: res.errors!));
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }

  Future<ResponseModel> createPosOrder(Map<String, dynamic> data) async {
    try {
      emit(const LoadingMainState());
      log(data.toString());
      var res = await _repository.post(data, 'pos/create_order');

      if (res.status == 'error') {
        validateError(res.errors!);
      }
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }

  Future<ProductsModel> getProducts({limit = 8, next = 0, query}) async {
    try {
      emit(const LoadingMainState());
      var res =
          await _repository.get(limit, next, 'pos/products', query: query);
      res = ProductsModel.fromJson(res);
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }
  
  
  Future get(endpoint, {limit = 8, next = 0, query}) async {
    try {
      emit(const LoadingMainState());
      var res =
          await _repository.get(limit, next, endpoint, query: query);
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }
  
  
  Future<ClientsModel> getClients({limit = 8, next = 0, query}) async {
    try {
      emit(const LoadingMainState());
      var res =
          await _repository.get(limit, next, 'production/clients', query: query);
      res = ClientsModel.fromJson(res); 
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }
  
  Future<TeamsModel> getTeams({limit = 8, next = 0, query}) async {
    try {
      emit(const LoadingMainState());
      var res =
          await _repository.get(limit, next, 'production/teams', query: query);
      res = TeamsModel.fromJson(res); 
      emit(LoadedMainState()); 
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }

  Future<ProductExtraModel> getExtraProducts() async {
    try {
      emit(const LoadingMainState());
      var res = await _repository.get('', '', 'product/extra');
      res = ProductExtraModel.fromJson(res);
      emit(LoadedMainState());
      return res;
    } catch (e) {
      emit(ErrorMainState(message: e.toString()));
      rethrow;
    }
  }
}
