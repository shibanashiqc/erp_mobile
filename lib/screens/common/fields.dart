
import 'package:erp_mobile/screens/common/x_select.dart';

class Fields {
  final String placeholder;
  final String model;
  final String label;
  final String type;
  final String xClass;
  final String value;
  List<DropDownItem>? options;

  Fields({
    required this.placeholder,
    required this.model,
    required this.label,
    required this.type,
    required this.xClass,
    required this.value,
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
