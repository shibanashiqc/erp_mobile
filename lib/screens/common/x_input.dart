// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class XInput extends StatefulWidget {
  XInput({
    super.key,
    this.label,
    this.hintText,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.enabled,
    this.readOnly,
    this.autofocus,
    this.isPassword,
    this.isMandatory,
    this.suffixIcon,
    this.height = 0.06,
    this.width = 0,
    this.onChanged,
    this.initialValue = '',
    this.model,
    this.type = 'text',
    this.onlyCard = false,
    this.errorBags,
    this.color = ColorConstants.whiteColor,
    this.radius = 10,
    this.child,
    this.enablePadding = false,
    this.labelExtra,
  });

  bool enablePadding = false;
  String? label;
  String? hintText;
  String type = 'text';
  bool obscureText = false;
  TextEditingController? controller;
  TextInputType? keyboardType;
  bool? enabled;
  bool? readOnly;
  bool? autofocus;
  bool? isPassword;
  bool? isMandatory;
  Icon? suffixIcon;
  double height = 0.06;
  double width = 0;
  String initialValue = '';
  String? model;
  bool onlyCard = false;
  List<Errors>? errorBags;
  Color color = ColorConstants.whiteColor;
  double radius = 10;
  Widget? child;
  Widget? labelExtra;
  void Function(String)? onChanged;

  @override
  State<XInput> createState() => _XInputState();
}

class _XInputState extends State<XInput> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: widget.enablePadding == true
          ? const EdgeInsets.only(left: 10, right: 10)
          : const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.only(left: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(widget.label!,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 5),
                      if (widget.isMandatory ?? false)
                        const Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                  widget.labelExtra ?? const SizedBox(),
                ],
              ),
            ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: widget.height * screenHeight,
            width: widget.width == 0 ? width : width * widget.width,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(widget.radius),
              // border: Border.all(color: Colors.grey.withOpacity(0.5)),
            ),
            child: widget.onlyCard == true
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      widget.initialValue,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  )
                : widget.type == 'date'
                    ? InkWell(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2015, 8),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            widget.initialValue = picked.toString();
                            widget.onChanged!(picked.toString());
                          }
                        },
                        child: IgnorePointer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.initialValue == ''
                                      ? widget.hintText!
                                      : widget.initialValue,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const Icon(Icons.calendar_today),
                              ],
                            ),
                          ),
                        ),
                      )
                    : widget.type == 'none'
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.initialValue == ''
                                      ? widget.hintText!
                                      : widget.initialValue,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        : widget.type == 'time'
                            ? InkWell(
                                onTap: () async {
                                  final TimeOfDay? picked =
                                      await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (picked != null) {
                                    widget.initialValue =
                                        picked.format(context);
                                    widget.onChanged!(picked.format(context));
                                  }
                                },
                                child: IgnorePointer(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.initialValue == ''
                                              ? widget.hintText!
                                              : widget.initialValue,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const Icon(Icons.calendar_today),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : widget.readOnly == true
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.initialValue == ''
                                              ? widget.hintText!
                                              : widget.initialValue,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // const Icon(Icons.calendar_today),
                                      ],
                                    ),
                                  )
                                : TextFormField(
                                    // onFieldSubmitted: (value) {
                                    //   widget.onChanged!(value);
                                    // },
                                    initialValue: widget.initialValue,
                                    onChanged: widget.onChanged,
                                    controller: widget.controller,
                                    keyboardType: widget.keyboardType,
                                    obscureText: widget.obscureText,
                                    enabled: widget.enabled,
                                    readOnly: widget.readOnly ?? false,
                                    autofocus: widget.autofocus ?? false,
                                    decoration: InputDecoration(
                                      hintStyle: const TextStyle(fontSize: 12),
                                      suffixIcon: widget.isPassword == true
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  widget.obscureText =
                                                      !widget.obscureText;
                                                });
                                              },
                                              icon: Icon(
                                                widget.obscureText == true
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                              ),
                                            )
                                          : widget.suffixIcon,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 15),
                                      hintText: widget.hintText,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                    ),
                                  ),
          ),
          widget.model?.isNotEmpty == true &&
                  widget.errorBags?.isNotEmpty == true &&
                  widget.errorBags!
                          .firstWhereOrNull(
                              (element) => element.field == widget.model)
                          ?.message !=
                      null
              ? SizedBox(
                  height: 18,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      left: width * 0.01,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '* ${widget.errorBags!.firstWhereOrNull((element) => element.field == widget.model)?.message}',
                          style: TextStyle(
                              color: ColorConstants.red.withOpacity(0.8),
                              fontSize: 9),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
          widget.child ?? const SizedBox(height: 8),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
