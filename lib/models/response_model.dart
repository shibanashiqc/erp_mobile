class ResponseModel {
  String? message;
  String? status;
  dynamic data;
  List<Errors>? errors;

  ResponseModel({
    required this.message,
    required this.status,
    required this.data,
    required this.errors,
  });

  ResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'];
     
    if (json['errors'] != null) {
      errors = [];   
      json['errors'].forEach((key, value) { 
        errors!.add(Errors(field: key, message: value[0])); 
      });
    } 

  } 
}
 

class Errors {
  String? field;
  String? message;
  Errors({required this.field, required this.message});
}