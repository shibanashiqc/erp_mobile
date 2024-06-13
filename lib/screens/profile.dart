// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/hr/hr_extra_data_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/models/sales/sales_extra_model.dart';
import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_file_image.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool loading = false;
  List<Errors>? errorBags = [];
  List<Country> countries = [];
  List<dynamic> states = [];
  List<dynamic> cities = [];
  Map<String, dynamic> formValues = {
    'name': '',
    'email': '',
    'phone': '',
    'address': '',
    'city_id': '',
    'country_id': '',
    'postal_code': '',
    'about': '',
  };

  Map<String, dynamic> staffForm = {};
  Map<String, dynamic> bank = {};
  Map<String, dynamic> user = {};
  Map<String, dynamic> professionalDetail = {};

  List<Roles>? roles;
  List<Departments>? departments;
  List<Warehouses>? warehouses;
  List<Branches>? branches;
  List<EmployeeTypes>? employeeTypes;
  List<Designations>? designations;

  @override
  void initState() {
    loading = true;
    setState(() {});
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final response = await context.read<MainCubit>().getExtraData();
      roles = response.data?.roles;
      departments = response.data?.departments;
      warehouses = response.data?.warehouses;
      branches = response.data?.branches;
      employeeTypes = response.data?.employeeTypes;
      designations = response.data?.designations;

      final salesExra = await context.read<MainCubit>().getExtraSales();
      countries = salesExra.data?.country ?? [];
      states = countries.expand((element) => element.states ?? []).toList();
      cities = states.expand((element) => element.cities ?? []).toList();
      loading = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      try {
        user = json.decode(prefs.getString('user') ?? '{}');
        formValues = user;
        // log('User: ${user['staff']}');
        staffForm = user['staff'] ?? {};
        bank = user['bank'] ?? {};
        professionalDetail = user['professional_detail'] ?? {}; 
      } catch (e) {
        log('Error: $e');
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainCubit(), child: buildScaffold(context));
  }

  Scaffold buildScaffold(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocConsumer<MainCubit, MainState>(listener: (context, state) {
        if (state is ErrorMainState) {
          log('Error: ${state.message}');
        }

        if (state is LoadedMainState) {
          loading = false;
        }

        if (state is LoadingMainState) {
          loading = true;
        }

        if (state is ValidationErrorState) {
          log('Validation Error');
          errorBags = state.errors;
        }

        if (state is ChangeFormValuesState) {}
      }, builder: (context, state) {
        return XContainer(
            showShimmer: loading,
            enablePading: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: screenHeight * 0.25,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.red[200],
                    ),
                    // ignore: prefer_const_constructors
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  NetworkImage(formValues['image'] ?? '')),
                          const SizedBox(height: 10),
                          Text(
                            formValues['name'],
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 5),
                          InkWell(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.remove('token');
                              await prefs.remove('user');
                              await prefs.remove('modules');
                              context.push('/login');
                            },
                            child: const Icon(Icons.login_outlined,
                                color: Colors.white, size: 18),
                          )
                        ])),
                const SizedBox(height: 10),
                XCard(
                    isBorder: true,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          
                          staffForm.isNotEmpty ? const SizedBox() : 
                          Column(children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Personal Information',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(width: 5),
                                Icon(Icons.edit, color: Colors.grey, size: 20)
                              ],
                            ),
                            const SizedBox(height: 10),
                            XInput(
                              color: Colors.grey.withOpacity(0.1),
                              initialValue: formValues['name'] ?? '',
                              label: 'Name',
                              hintText: 'Enter your name',
                              onChanged: (value) => formValues['name'] = value,
                              // value: 'John',
                            ),
                            XInput(
                              color: Colors.grey.withOpacity(0.1),
                              initialValue: formValues['email'] ?? '',
                              label: 'Email',
                              hintText: 'Enter your email',
                              onChanged: (value) => formValues['email'] = value,
                              // value: 'Doe',
                            ),
                            XInput(
                              color: Colors.grey.withOpacity(0.1),
                              initialValue: formValues['phone'] ?? '',
                              label: 'Phone',
                              hintText: 'Enter your phone',
                              onChanged: (value) => formValues['phone'] = value,
                              // value: 'Doe',
                            ),
                            XInput(
                              height: 0.13,
                              color: Colors.grey.withOpacity(0.1),
                              initialValue: formValues['address'] ?? '',
                              label: 'Address',
                              hintText: 'Enter your address',
                              onChanged: (value) =>
                                  formValues['address'] = value,
                              // value: 'Doe',
                            ),
                            XSelect(
                              color: Colors.grey.withOpacity(0.1),
                              value: formValues['country_id'].toString(),
                              onChanged: (value) {
                                formValues['country_id'] = value;
                                setState(() {});
                              },
                              label: 'Country',
                              options: countries
                                  .map((e) => DropDownItem(
                                      value: e.id.toString(), label: e.name))
                                  .toList(),
                            ),
                            XSelect(
                              color: Colors.grey.withOpacity(0.1),
                              value: formValues['city_id'].toString(),
                              onChanged: (value) {
                                formValues['city_id'] = value;
                                setState(() {});
                              },
                              label: 'City',
                              options: cities
                                  .map((e) => DropDownItem(
                                      value: e.id.toString(), label: e.name))
                                  .toList(),
                            ),
                            XInput(
                              color: Colors.grey.withOpacity(0.1),
                              initialValue:
                                  formValues['postal_code'].toString(),
                              label: 'Postal Code',
                              hintText: 'Enter your postal code',
                              onChanged: (value) =>
                                  formValues['postal_code'] = value,
                              // value: 'Doe',
                            ),
                            XInput(
                              height: 0.13,
                              color: Colors.grey.withOpacity(0.1),
                              initialValue: formValues['about'] ?? '',
                              label: 'About',
                              hintText: 'Enter about yourself',
                              onChanged: (value) => formValues['about'] = value,
                              // value: 'Doe',
                            ),
                          ]),
                          staffForm.isEmpty
                              ? const SizedBox()
                              : IgnorePointer(
                                  ignoring: true,
                                  child: Container(
                                    color: Colors.grey.withOpacity(0.1),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          PersonalDetails(),
                                          Bank(),
                                          salaryDetails(context),
                                        ],
                                      ),
                                    ), 
                                  ),
                                ),
                          const SizedBox(height: 10),
                          XButton(
                              label: 'Save',
                              onPressed: () async {
                                final res = await context
                                    .read<MainCubit>()
                                    .updateUser(formValues);
                                if (res.status == 'success') {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     const SnackBar(content: Text('Profile Updated')));
                                }
                              })
                        ],
                      ),
                    )),
              ],
            ));
      }),
    );
  }

  Column Bank() {
    return Column(
                                          children: [
                                            const Text(
                                              'Bank Details',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 9,
                                            ),
                                            XInput(
                                              model: 'bank_name',
                                              errorBags: errorBags,
                                              initialValue:
                                                  bank['bank_name'] ?? '',
                                              onChanged: (value) {
                                                // context.read<StaffCubit>().changeFormValues('bank_name', value);
                                              },
                                              label: 'Bank Name',
                                              hintText: 'Enter bank name',
                                            ),
                                            XInput(
                                              model: 'bank_branch',
                                              errorBags: errorBags,
                                              initialValue:
                                                  bank['bank_branch'] ?? '',
                                              onChanged: (value) {
                                                // context.read<StaffCubit>().changeFormValues('bank_branch', value);
                                              },
                                              label: 'Bank Branch',
                                              hintText: 'Enter bank branch',
                                            ),
                                            XInput(
                                              model: 'account_name',
                                              errorBags: errorBags,
                                              initialValue:
                                                  bank['account_name'] ?? '',
                                              onChanged: (value) {
                                                // context.read<StaffCubit>().changeFormValues('account_name', value);
                                              },
                                              label: 'Account Name',
                                              hintText: 'Enter account name',
                                            ),
                                            XInput(
                                              model: 'account_number',
                                              errorBags: errorBags,
                                              keyboardType:
                                                  TextInputType.number,
                                              initialValue:
                                                  bank['account_number'] ??
                                                      '',
                                              onChanged: (value) {
                                                // context.read<StaffCubit>().changeFormValues('account_number', value);
                                              },
                                              label: 'Account Number',
                                              hintText:
                                                  'Enter account number',
                                            ),
                                            XInput(
                                              model: 'ifsc_code',
                                              errorBags: errorBags,
                                              initialValue:
                                                  bank['ifsc_code'] ?? '',
                                              onChanged: (value) {
                                                // context.read<StaffCubit>().changeFormValues('ifsc_code', value);
                                              },
                                              label: 'IFSC Code',
                                              hintText: 'Enter ifsc code',
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        );
  }
  
   Column salaryDetails(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Salary Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 9,
        ),
        XInput( 
          type: 'date',
          model: 'date_of_joining',
          errorBags: errorBags,
          initialValue: professionalDetail['date_of_joining'] ?? '',
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('date_of_joining', value);
          }, 
          label: 'Date of Joining',
          hintText: 'Chooose date of joining',
        ),
        XInput(
          model: 'basic_salary',
          errorBags: errorBags,
          keyboardType: TextInputType.number,
          initialValue: professionalDetail['basic_salary'].toString(), 
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('basic_salary', value);
          },
          label: 'Basic Salary',
          hintText: 'Enter basic salary',
        ),
        XSelect(
          model: 'employee_type_id',
          errorBags: errorBags,
          value: professionalDetail['employee_type_id'].toString(),
          onChanged: (value) {
            // context
            //     .read<StaffCubit>()
            //     .changeFormValues('employee_type_id', value);
          },
          label: 'Employee Type',
          isMandatory: true,
          options: employeeTypes 
                  ?.map((e) => DropDownItem(value: e.id.toString(), label: e.name))
                  .toList() ?? [],
        ),
        XSelect(
          model: 'designation_id',
          errorBags: errorBags,
          value: professionalDetail['designation_id'].toString(),
          onChanged: (value) {
           // context.read<StaffCubit>().changeFormValues('designation_id', value);
          },
          label: 'Designation',
          isMandatory: true,
          options: designations
                  ?.map((e) => DropDownItem(value: e.id.toString(), label: e.name))
                  .toList() ?? [], 
        ),
        XInput(
          model: 'grade',
          errorBags: errorBags,
          initialValue: professionalDetail['grade'] ?? '',
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('grade', value);
          },
          label: 'Grade',
          hintText: 'Enter grade',
        ),
        XInput(
          model: 'capabilities',
          errorBags: errorBags,
          initialValue: professionalDetail['capabilities'] ?? '',
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('capabilities', value);
          },
          label: 'Capabilities',
          hintText: 'Enter capabilities',
        ),
        XInput(
          model: 'experience',
          errorBags: errorBags,
          initialValue: professionalDetail['experience'] ?? '',
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('experience', value);
          },
          label: 'Experience',
          hintText: 'Enter experience',
        ),
        XInput(
          model: 'hra',
          errorBags: errorBags,
          initialValue: professionalDetail['hra'].toString(),
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('hra', value);
          },
          label: 'HRA',
          hintText: 'Enter hra',
        ),
        XInput(
          model: 'conveyance',
          errorBags: errorBags,
          initialValue: professionalDetail['conveyance'].toString(),
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('conveyance', value);
          },
          label: 'Conveyance',
          hintText: 'Enter conveyance',
        ),
        XInput(
          model: 'education_allowance',
          errorBags: errorBags,
          initialValue: professionalDetail['education_allowance'].toString(),
          onChanged: (value) {
            // context
            //     .read<StaffCubit>()
            //     .changeFormValues('education_allowance', value);
          },
          label: 'Education Allowance',
          hintText: 'Enter education allowance',
        ),
        XInput(
          model: 'medical_reimbursement',
          errorBags: errorBags,
          initialValue: professionalDetail['medical_reimbursement'].toString(),
          onChanged: (value) {
            // context
            //     .read<StaffCubit>()
            //     .changeFormValues('medical_reimbursement', value);
          },
          label: 'Medical Reimbursement',
          hintText: 'Enter medical reimbursement',
        ),
        XInput(
          model: 'special_allowance',
          errorBags: errorBags,
          initialValue: professionalDetail['special_allowance'].toString(),
          onChanged: (value) {
            // context
            //     .read<StaffCubit>()
            //     .changeFormValues('special_allowance', value);
          },
          label: 'Special Allowance',
          hintText: 'Enter special allowance',
        ),
        const SizedBox(height: 10),
      ],
    );
  }


  Column PersonalDetails() {
    return Column(
      children: [
        const Text(
          'Personal Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 9,
        ),

        XSelect(
          model: 'role_id',
          errorBags: errorBags,
          value: staffForm['role_id'].toString(),
          onChanged: (value) {
            // context.read<StaffCubit>().changeRoleId(value.toString());
          },
          label: 'Role',
          isMandatory: true,
          options: roles
                  ?.map((e) =>
                      DropDownItem(value: e.id.toString(), label: e.name))
                  .toList() ??
              [],
        ),

        XInput(
          model: 'name',
          errorBags: errorBags,
          initialValue: staffForm['name'] ?? '',
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('name', value);
          },
          isMandatory: true,
          label: 'Name',
          hintText: 'Enter name',
        ),

        XInput(
          model: 'email',
          errorBags: errorBags,
          isMandatory: true,
          initialValue: staffForm['email'] ?? '',
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('email', value);
          },
          label: 'Email',
          hintText: 'Enter email',
        ),

        XInput(
          model: 'phone',
          errorBags: errorBags,
          isMandatory: true,
          initialValue: staffForm['phone'].toString(),
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('phone', value);
          },
          label: 'Phone',
          hintText: 'Enter phone',
        ),

        XSelect(
          value: staffForm['department_id'].toString(),
          model: 'department_id',
          errorBags: errorBags,
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('department_id', value);
          },
          label: 'Department',
          isMandatory: true,
          options: departments
                  ?.map((e) =>
                      DropDownItem(value: e.id.toString(), label: e.name))
                  .toList() ??
              [],
        ),

        XSelect(
          model: 'warehouse_id',
          errorBags: errorBags,
          value: staffForm['warehouse_id'].toString(),
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('warehouse_id', value);
          },
          label: 'Warehouse',
          isMandatory: true,
          options: warehouses
                  ?.map((e) =>
                      DropDownItem(value: e.id.toString(), label: e.name))
                  .toList() ??
              [],
        ),

        XSelect(
          model: 'branch_id',
          errorBags: errorBags,
          value: staffForm['branch_id'].toString(),
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('branch_id', value);
          },
          label: 'Branch',
          isMandatory: true,
          options: branches
                  ?.map((e) =>
                      DropDownItem(value: e.id.toString(), label: e.name))
                  .toList() ??
              [],
        ),

        XInput(
          type: 'date',
          model: 'dob',
          errorBags: errorBags,
          isMandatory: true,
          initialValue: staffForm['dob'] ?? '',
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('dob', value);
          },
          label: 'Date of Birth',
          hintText: 'Enter dob',
        ),

        XInput(
          errorBags: errorBags,
          model: 'current_address',
          height: 0.1,
          isMandatory: true,
          initialValue: staffForm['current_address'] ?? '',
          onChanged: (value) {
            // context
            //     .read<StaffCubit>()
            //     .changeFormValues('current_address', value);
          },
          label: 'Current Address',
          hintText: 'Enter current address',
        ),

        XInput(
          errorBags: errorBags,
          model: 'permanent_address',
          height: 0.1,
          isMandatory: true,
          initialValue: staffForm['permanent_address'] ?? '',
          onChanged: (value) {
            // context
            //     .read<StaffCubit>()
            //     .changeFormValues('permanent_address', value);
          },
          label: 'Permanent Address',
          hintText: 'Enter permanent address',
        ),

        XInput(
          keyboardType: TextInputType.number,
          errorBags: errorBags,
          model: 'opening_balance',
          isMandatory: true,
          initialValue: staffForm['opening_balance'].toString(),
          onChanged: (value) {
            // context
            //     .read<StaffCubit>()
            //     .changeFormValues('opening_balance', value);
          },
          label: 'Opening Balance',
          hintText: 'Enter opening balance',
        ),

        XFileImage(
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('image', value);
          },
          label: 'Image',
          isMandatory: true,
        ),

        XInput(
          type: 'date',
          errorBags: errorBags,
          model: 'applicable_for_leave',
          keyboardType: TextInputType.number,
          isMandatory: true,
          initialValue: staffForm['applicable_for_leave'].toString(),
          onChanged: (value) {
            // context
            //     .read<StaffCubit>()
            //     .changeFormValues('applicable_for_leave', value);
          },
          label: 'Applicable For Leave',
          hintText: 'Enter applicable for leave',
        ),

        XFileImage(
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('signature', value);
          },
          label: 'Signature',
          isMandatory: true,
        ),

        XFileImage(
          allowMultiple: true,
          label: 'Documents',
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('documents', value);
          },
          isMandatory: true,
        ),

        XInput(
          model: 'mid_name',
          errorBags: errorBags,
          isMandatory: true,
          initialValue: staffForm['mid_name'] ?? '',
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('mid_name', value);
          },
          label: 'Middle Name',
          hintText: 'Enter middle name',
        ),

        XInput(
          errorBags: errorBags,
          model: 'last_name',
          isMandatory: true,
          initialValue: staffForm['last_name'] ?? '',
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('last_name', value);
          },
          label: 'Last Name',
          hintText: 'Enter last name',
        ),

        XInput(
          errorBags: errorBags,
          model: 'father_name',
          isMandatory: true,
          initialValue: staffForm['father_name'] ?? '',
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('father_name', value);
          },
          label: 'Father Name',
          hintText: 'Enter father name',
        ),

        XInput(
          errorBags: errorBags,
          model: 'mother_name',
          isMandatory: true,
          initialValue: staffForm['mother_name'] ?? '',
          onChanged: (value) {
            // context
            //     .read<StaffCubit>()
            //     .changeFormValues('mother_name', value);
          },
          label: 'Mother Name',
          hintText: 'Enter mother name',
        ),

        XInput(
          errorBags: errorBags,
          model: 'spouse_name',
          isMandatory: true,
          initialValue: staffForm['spouse_name'] ?? '',
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('spouse_name', value);
          },
          label: 'Spouse Name',
          hintText: 'Enter spouse name',
        ),

        XInput(
          errorBags: errorBags,
          model: 'pan_number',
          isMandatory: true,
          initialValue: staffForm['pan_number'].toString(),
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('pan_number', value);
          },
          label: 'Pan Number',
          hintText: 'Enter pan number',
        ),

        XInput(
          errorBags: errorBags,
          model: 'aadhar_number',
          keyboardType: TextInputType.number,
          isMandatory: true,
          initialValue: staffForm['aadhar_number'].toString(),
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('aadhar_number', value);
          },
          label: 'Aadhar Number',
          hintText: 'Enter aadhar number',
        ),

        XInput(
          errorBags: errorBags,
          model: 'alt_phone',
          keyboardType: TextInputType.number,
          isMandatory: true,
          initialValue: staffForm['alt_phone'].toString(),
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('alt_phone', value);
          },
          label: 'Alt Phone',
          hintText: 'Enter alt phone',
        ),

        XInput(
          errorBags: errorBags,
          model: 'leave_limit',
          keyboardType: TextInputType.number,
          isMandatory: true,
          initialValue: staffForm['leave_limit'].toString(),
          onChanged: (value) {
            // context.read<StaffCubit>().changeFormValues('leave_limit', value);
          },
          label: 'Leave Limit',
          hintText: 'Enter leave limit',
        ),

        // XInput(
        //   initialValue: description,
        //   onChanged: (value) {
        //     context.read<StaffCubit>().changeDescription(value);
        //   },
        //   height: 0.1,
        //   isMandatory: true,
        //   label: 'Description',
        //   hintText: 'Enter description',
        // ),

        const SizedBox(height: 10),
      ],
    );
  }
}
