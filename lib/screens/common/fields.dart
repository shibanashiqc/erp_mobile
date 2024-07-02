
import 'package:erp_mobile/screens/common/x_select.dart';

class Fields {
  String placeholder;
  String model;
  String label;
  String type;
  String xClass;
  String value;
  bool isReadOnly = false; 
  List<DropDownItem>? options;
  Function? onChanged;

  Fields({
    required this.placeholder,
    required this.model,
    required this.label,
    required this.type,
    required this.xClass,
    required this.value,
    this.onChanged, 
    this.isReadOnly = false, 
    this.options,
  });

  // factory Fields.fromJson(Map<String, dynamic> json) {
  //   return Fields(
  //     placeholder: json['placeholder'],
  //     model: json['model'],
  //     label: json['label'],
  //     type: json['type'],
  //     xClass: json['x_class'],
  //     value: json['value'],
  //   );
  // }
}
