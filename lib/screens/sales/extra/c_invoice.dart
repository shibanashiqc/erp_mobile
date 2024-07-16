import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/sales/extra/invoice_items.dart';
import 'package:flutter/material.dart';
import 'package:erp_mobile/models/sales/extra/appointment_invoice_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CInvoices extends StatefulWidget {
   String customerId;
   CInvoices({
    super.key,
    required this.customerId,
  }); 

  @override
  State<CInvoices> createState() => _CInvoicesState();
}

class _CInvoicesState extends State<CInvoices> {
  List<Data> data = [];
  bool loading = true;
  
  
  initData()
  {
    context.read<MainCubit>().get('sales/customer/${widget.customerId}/invoices').then((value) {
      final appointmentInvoice = AppointmentInvoiceModel.fromJson(value);
      if (appointmentInvoice.data != null) { 
        setState(() {
          data = appointmentInvoice.data ?? [];
          loading = false;
        });
      }
    }); 
  }
  
  @override
  void initState() { 
    initData(); 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return XContainer(
      showShimmer: loading,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          
          const SizedBox(height: 20), 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Invoices', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              InkWell(
                onTap: () {
                  
                showModalBottomSheet<void>(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return InvoiceItems(
                      customerId: widget.customerId, 
                      onSaved: initData, 
                    );
                  },
                );
                     
                  },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black, 
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Add Invoice'.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ), 
                ),
              ),  
            ],
          ), 
          
          const SizedBox(height: 30),  
          
          ListView.separated( 
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length, 
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);  
            }, 
            itemBuilder: (context, index) {
              return XCard(
                child: Column(
                  children: [ 
                    const SizedBox(height: 5),
                    Text(data[index].createdAt ?? '',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data[index].items!.length,
                      separatorBuilder: (context, indexx) {
                        return const SizedBox(height: 10);
                      },
                      itemBuilder: (context, indexx) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Text(
                                      data[index].items?[indexx].itemName ?? '',
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Cost : '.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                       Text(data[index].items?[indexx].cost ?? '',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Discount : '.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                       Text(data[index].items?[indexx].discountAmount ?? '',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Tax : '.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                       Text(data[index].items?[indexx].taxAmount ?? '',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total : '.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                       Text(data[index].items?[indexx].total ?? '', 
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ])),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 10),   
                    
                    Container( 
                      width: double.infinity, 
                      decoration: BoxDecoration(
                        color:  Colors.grey.shade100, 
                       borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                        border: Border.all(color: Colors.black , width: 0.4)  
                      ),   
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),  
                        child: Column(
                          children: [
                           Text(data[index].invoiceNumber ?? '', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                           const SizedBox(height: 5),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Cost : '.toUpperCase(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                 Text(data[index].totalCost ?? '',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              ],
                            ),  
                            
                             const SizedBox(height: 5), 
                            
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text('Total Balance : '.toUpperCase(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            //     const Text('0.00', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            //   ],
                            // ),
                            
                            // const SizedBox(height: 5),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total : '.toUpperCase(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                Text(data[index].grandTotal ?? '',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              ], 
                            ),
                            
                            
                          ])
                      ),
                    ),
                    
                    const SizedBox(height: 120),  
                    
                  ],
                ),
              );
            },
            
          ),
        ],
      ),
    );
  }
}
