// import 'dart:developer';

// import 'dart:ffi';

import 'package:erp_mobile/models/response_model.dart';

class Validater {
  
  Future<List<Errors>> validateForm(List rules, Map data) async {
    final erroBag = validate(rules, data);
    if(erroBag.isNotEmpty) {
      return erroBag;
    } 
    return []; 
  }
  
  static List<Errors> validate(List rules, Map data) {
    try {
      Object rule = rules[0];
      List<Errors> errorBag = [];

      if (rule is Map) {
        rule.forEach((key, value) { 
          value = value.split('|');
          value.forEach((element) {
            var validator = valiateElements(element, data[key]);
            if (validator != null) {
              errorBag.add(Errors(field: key, message: validator));
            }
          });
        });
      }
      
      return errorBag;
    } catch (e) {
      return []; 
    }
  }


  static required(value) {
    if (value == '' || value == null) { 
      return 'This field is required';
    }
  }
  
  static double(String value)
  {
    // ignore: unrelated_type_equality_checks
    if(value.runtimeType != double) {
       return 'This field must be a double';
     }  
  }
  
  
  static string(String value) {
    // ignore: unnecessary_type_check
    if (value is! String) {
      return 'This field must be a string';
    }
  }

  static email(String value) {
    if (value == '') {
      return 'This field is required';
    } else if (!value.contains('@')) {
      return 'This field must be a valid email';
    }
  }

  static number(value) {
    if (value is int == false) {
      return 'This field must be a number';
    }
  }

  static valiateElements(element, value) {
    switch (element) {
      case 'required':
        return required(value);
      case 'string':
        return string(value);
      case 'email':
        return email(value);
      case 'number':
        return number(value);
      case 'double':
        return double(value);   
      default:
        return null;
    }
  }
}

class ErrorBag {
  String field;
  String message;
  ErrorBag({required this.field, required this.message});
}
