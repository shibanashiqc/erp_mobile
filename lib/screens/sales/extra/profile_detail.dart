import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/sales/extra/customer_info_model.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatefulWidget {
  String? customerId;
  ProfileView({
    super.key,
    required this.customerId,
  });

  @override 
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  
  Data data = Data();
  
  @override
  void initState() {
    context.read<MainCubit>().get('sales/customer/${widget.customerId}/info').then((value) {
      final customerInfo = CustomerInfoModel.fromJson(value);
      if (customerInfo.data != null) {
        setState(() { 
          data = customerInfo.data ?? Data();
        });
      } 
    }
    );  
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return XContainer(
      showShimmer: data.name == null ? true : false,  
      child: XCard(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const CircleAvatar(
              radius: 30,
              child: Icon(Icons.person),
            ),
            const SizedBox(height: 10), 
             Text(data.name ?? '',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
             Text(data.email ?? '',
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            const Divider(
              thickness: 0.1,
            ),
            const SizedBox(height: 5),
            Text('Edit Profile'.toUpperCase(),
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade100),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      XInput(
                        initialValue: data.name ?? '', 
                        color: Colors.grey.shade100,
                        label: 'Name',
                        hintText: 'Enter Name',
                      ),
                      XInput(
                        initialValue: data.email ?? '',
                        color: Colors.grey.shade100,
                        label: 'Email Address',
                        hintText: 'Enter Email Address',
                      ),
                      XInput(
                        initialValue: data.phone ?? '',
                        color: Colors.grey.shade100,
                        label: 'Phone',
                        hintText: 'Enter Phone',
                      ),
                      XInput(
                        initialValue: data.dob ?? '',
                        type: 'date',
                        color: Colors.grey.shade100,
                        label: 'DOB',
                        hintText: 'Enter DOB',
                      ),
                      XInput(
                        initialValue: data.bloodGroup ?? '',
                        color: Colors.grey.shade100,
                        label: 'Blood Group',
                        hintText: 'Enter Blood Group',
                      ),
                      // XInput(
                      //   height: 0.1,
                      //   color: Colors.grey.shade100,
                      //   label: 'Shipping Address',
                      //   hintText: 'Enter Shipping Address',
                      // ),
                      // XInput(
                      //   height: 0.1,
                      //   color: Colors.grey.shade100,
                      //   label: 'Billing Address',
                      //   hintText: 'Enter Billing Address',
                      // ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
