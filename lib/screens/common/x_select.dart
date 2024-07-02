// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class XSelect extends StatefulWidget {
  String? label;
  String? placeholder;
  bool isMandatory = false;
  List<DropDownItem> options = [];
  void Function(dynamic)? onChanged;
  double height = 0.06;
  double width = 0;
  String? value;
  String? model;
  List<Errors>? errorBags;
  Widget? extraLabel = const SizedBox();
  Color color = ColorConstants.whiteColor;
  bool enablePadding = false;
  Function? reset;
  bool readOnly = false;
  XSelect(
      {super.key,
      this.readOnly = false,  
      this.label,
      this.isMandatory = false,
      required this.options,
      required this.onChanged,
      this.height = 0.06,
      this.width = 0,
      this.value,
      this.model,
      this.errorBags,
      this.extraLabel,
      this.color = ColorConstants.whiteColor,
      this.enablePadding = false,
      this.reset,
      this.placeholder
      });

  @override
  State<XSelect> createState() => _XSelectState();
}

class _XSelectState extends State<XSelect> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return IgnorePointer(
      ignoring: widget.readOnly,  
      child: Padding(
        padding: widget.enablePadding == true
            ? const EdgeInsets.only(left: 10, right: 10)
            : const EdgeInsets.all(0),
        child: Column(
          children: [
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
                        if (widget.isMandatory)
                          const Text(
                            '*',
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                    widget.extraLabel ?? const SizedBox()
                  ],
                ),
              ),
            const SizedBox(height: 5),
            Container(
                height: widget.height * screenHeight,
                width: widget.width == 0 ? width : width * widget.width,
                decoration: BoxDecoration(
                  color: widget.color, 
                  borderRadius: BorderRadius.circular(5),
                  //border: Border.all(color: Colors.grey.withOpacity(0.5))
                ),
                // child: DropdownButton(
                //   value: widget.value,
                //   isExpanded: true,
                //   underline: const SizedBox(),
                //   items: widget.options.map((item) {
                //     return DropdownMenuItem(
                //       value: item.value,
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text(item.label ?? ''),
                //       ),
                //     );
                //   }).toList(),
                //   onChanged: widget.onChanged,
                // ),
      
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center, 
                      children: [
                        Text(
                          widget.options
                              .firstWhereOrNull((element) => element.value == widget.value)
                              ?.label ??
                              widget.placeholder ?? '' , 
                          style: TextStyle(
                            fontSize: 12, 
                            overflow: TextOverflow.ellipsis ,
                            color: widget.value == null
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ), 
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ModalOptions(widget: widget, reset: widget.reset);
                      },
                    );
                  },
                 
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
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class ModalOptions extends StatefulWidget {
   ModalOptions({
    super.key,
    required this.widget,
    this.reset, 
  });

  Function? reset;
  final XSelect widget;

  @override
  State<ModalOptions> createState() => _ModalOptionsState();
}

class _ModalOptionsState extends State<ModalOptions> {
  
  List<DropDownItem> options = [];
  
  @override
  void initState() {
    options = widget.widget.options;
    super.initState();
  }  
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 315,   
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value)  {
                  if (value.isEmpty){
                    widget.widget.options = options;
                    return setState(() {}); 
                  }
                  widget.widget.options = widget.widget.options  
                      .where((element) => element.label?.toLowerCase().contains(value.toLowerCase()) == true || element.extra.toLowerCase().contains(value.toLowerCase()) == true) 
                      //  element.label? and  element.extra? are null safe
                      // .where((element) => element.label?.toLowerCase().contains(value.toLowerCase()) == true || element.extra.toLowerCase().contains(value.toLowerCase()) == true) 
                      .toList();
                      setState(() {});
                },
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10),
                ),
              ),
              SizedBox(
                height: 200,
                // width: 200,
                child: ListView.builder(
                  itemCount: widget.widget.options.length,
                  itemBuilder: (context, index) { 
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,  
                        children: [ 
                          Text(widget.widget.options[index].label ?? ''),
                          const SizedBox(height: 5), 
                          Text(widget.widget.options[index].extra, style: const TextStyle(fontSize: 12, color: Colors.grey)) , 
                        ],
                      ),
                      // subtitle:  Text(widget.widget.options[index].extra),  
                      onTap: () {
                        widget.widget.onChanged!(widget.widget.options[index].value);
                        Navigator.pop(context); 
                      },
                    );
                  },
                ),
              ),
              
              TextButton(
                onPressed: () {
                  widget.reset != null ? widget.reset!() : null;  
                  Navigator.pop(context);
                },
                child: const Text('Clear'),
              ), 
            ],
          ),
        ),
      ),
    );
  }
}

class DropDownItem {
  String? value;
  String? label;
  String extra = '';
  DropDownItem({this.value, this.label, this.extra = ''});
}
