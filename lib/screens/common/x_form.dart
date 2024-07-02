import 'dart:developer';

import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/fields.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/material.dart';

class XForm extends StatefulWidget {
  List<Fields>? fields = [];
  List<Errors>? errorBags = [];
  Map<String, dynamic>? formValues = {};
  XForm({super.key, this.fields, this.errorBags, this.formValues});

  @override
  State<XForm> createState() => _XFormState();
}

class _XFormState extends State<XForm> {
  @override
  void initState() {
    log(widget.fields.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (Fields field in widget.fields ?? []) ...[
        if (field.xClass == 'XInput') ...[
          XInput(
            onlyCard: field.isReadOnly,  
            errorBags: widget.errorBags,
            hintText: field.placeholder,
            label: field.label,
            model: field.model,
            type: field.type,
            initialValue: widget.formValues?[field.model].toString() ?? '',
            onChanged: (value) { 
              widget.formValues?[field.model] = value;
            },
          ),
        ],
        if (field.xClass == 'XSelect') ...[
          XSelect(
            errorBags: widget.errorBags,
            label: field.label,
            model: field.model, 
            options: field.options ?? [],
            value: widget.formValues?[field.model].toString(),
            onChanged: (value) {
              widget.formValues?[field.model] = value;
              widget.fields?.forEach((element) {
                if (element.model == field.model) {
                   if (element.onChanged != null) {
                     element.onChanged!();
                   } 
                }
              });
              setState(() {
              }); 
            },
          ),
        ],
      ]
    ]);
  }
}
