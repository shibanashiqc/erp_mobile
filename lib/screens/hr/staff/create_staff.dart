// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:erp_mobile/cubit/hr/hr_cubit.dart' as hr;
import 'package:erp_mobile/cubit/hr/staff/staff_cubit.dart';
import 'package:erp_mobile/cubit/main_cubit.dart' as main;
import 'package:erp_mobile/models/hr/hr_extra_data_model.dart';
import 'package:erp_mobile/models/hr/staff_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/models/sales/sales_extra_model.dart' as sales;
import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_file_image.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_menu.dart';
import 'package:erp_mobile/screens/common/x_menu_item.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateStaff extends StatefulWidget {
  int? editId;
  dynamic data;
  CreateStaff({
    super.key,
    this.editId,
    this.data,
  });

  @override
  State<CreateStaff> createState() => _CreateStaffState();
}

class _CreateStaffState extends State<CreateStaff>
    with SingleTickerProviderStateMixin {
  dynamic roleId;
  String name = '';
  String password = '';
  String email = '';
  String phone = '';
  dynamic departmentId;
  dynamic warehouseId;
  dynamic branchId;
  String dob = '';
  String currentAddress = '';
  String permanentAddress = '';
  String openingBalance = '';
  File image = File('');
  String imageUrl = '';
  List<File> documents = [];
  String applicableForLeave = '';
  File signature = File('');
  String midName = '';
  String lastName = '';
  String fatherName = '';
  String motherName = '';
  String spouseName = '';
  String panNumber = '';
  String aadharNumber = '';
  String altPhone = '';
  String leaveLimit = '';

  String bankName = '';
  String bankBranch = '';
  String accountName = '';
  String accountNumber = '';
  String ifscCode = '';
  String speciality = '';

  String dateOfJoining = '';
  String basicSalary = '';
  dynamic employeeTypeId;
  dynamic designationId;
  String grade = '';
  String capabilities = '';
  String experience = '';
  String hra = '';
  String conveyance = '';
  String educationAllowance = '';
  String medicalReimbursement = '';
  String specialAllowance = '';
  String license = '';

  List<Errors> errorBags = [];

  List<Roles>? roles;
  List<Departments>? departments;
  List<Warehouses>? warehouses;
  List<Branches>? branches;
  List<EmployeeTypes>? employeeTypes;
  List<Designations>? designations;

  List<sales.Country> countries = [];

  Map<String, dynamic> options = {
    'billing_attention': '',
    'billing_country_id': '',
    'billing_address': '',
    'billing_state_id': '',
    'billing_city_id': '',
    'billing_zip': '',
    'billing_phone': '',
    'billing_fax': '',
    'shipping_attention': '',
    'shipping_country_id': '',
    'shipping_address': '',
    'shipping_state_id': '',
    'shipping_city_id': '',
    'shipping_zip': '',
    'shipping_phone': '',
    'shipping_fax': '',
    'emergency_contact_name': '',
    'emergency_contact_number': '',
    'emergency_contact_alt_number': '',
    'emergency_contact_relation': '',
    'religion': '',
    'allergic_status': 'No',
    'blood_group': '',
    'medications': '',
    'medical_history': '',
    'experience': '',
    'source_of_hire': '',
    'skill_set': '',
    'heihest_qualification': '',
    'additional_info': '',
    'state_id': '', 
    // 'department_id': '',
    'designation_id': '',
    'current_salary': '',
    'joining_date': '',
    // 'offer_letter': '',
  };

  List<StaffProfessionalInformation> staffProfessionalInformation = [];
  List<StaffEducationInformations> staffEducationInformations = [];
  List<StaffAssets> staffAssets = [];  

  File offerLetter = File('');
  List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  List<String> relationships = [
    'Father',
    'Mother',
    'Spouse',
    'Brother',
    'Sister',
    'Son',
    'Daughter',
    'Other',
  ];

  TabController? _tabController;
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    log('editId: ${widget.editId}'); 
    if (widget.editId != 0) {
      data = json.decode(json.encode(widget.data));
      roleId = data['role_id'].toString();
      name = data['name'];
      // password = data['password']; 
      email = data['email'] ?? '';
      phone = data['phone'].toString();
      departmentId = data['department_id'].toString();
      warehouseId = data['warehouse_id'].toString();
      branchId = data['branch_id'].toString();
      dob = data['dob'].toString();
      currentAddress = data['current_address'].toString();
      permanentAddress = data['permanent_address'].toString();
      openingBalance = data['opening_balance'].toString();
      //image = File(data['image'].toString());
      // documents = data['documents'].toString();
      applicableForLeave = data['applicable_for_leave'].toString();
      imageUrl = data['image'].toString();
      //signature = File(data['signature'].toString());
      midName = data['mid_name'].toString();
      lastName = data['last_name'].toString();
      fatherName = data['father_name'].toString();
      motherName = data['mother_name'].toString();
      spouseName = data['spouse_name'].toString();
      panNumber = data['pan_number'].toString();
      aadharNumber = data['aadhar_number'].toString();
      altPhone = data['alt_phone'].toString();
      leaveLimit = data['leave_limit'].toString();
      bankName = data['bank_name'].toString();
      bankBranch = data['bank_branch'].toString();
      accountName = data['account_name'].toString();
      accountNumber = data['account_number'].toString();
      ifscCode = data['ifsc_code'].toString();
      dateOfJoining = data['date_of_joining'].toString();
      basicSalary = data['basic_salary'].toString();
      employeeTypeId = data['employee_type_id'].toString();
      designationId = data['designation_id'].toString();
      grade = data['grade'].toString();
      capabilities = data['capabilities'].toString();
      experience = data['experience'].toString();
      hra = data['hra'].toString();
      conveyance = data['conveyance'].toString();
      educationAllowance = data['education_allowance'].toString();
      medicalReimbursement = data['medical_reimbursement'].toString();
      specialAllowance = data['special_allowance'].toString();
      speciality = data['speciality'].toString();
      license = data['license'].toString();
      
      options['emergency_contact_name'] = data['emergency_contact_name'].toString();
      options['emergency_contact_number'] = data['emergency_contact_number'].toString();
      options['emergency_contact_alt_number'] = data['emergency_contact_alt_number'].toString();
      options['emergency_contact_relation'] = data['emergency_contact_relation'].toString();
      options['religion'] = data['religion'].toString();
      
    
      options['billing_attention'] = data['billing_attention'].toString();
      options['billing_country_id'] = data['billing_country_id'].toString();
      options['billing_address'] = data['billing_address'].toString();
      options['billing_state_id'] = data['billing_state_id'].toString();
      options['billing_city_id'] = data['billing_city_id'].toString();
      options['billing_zip'] = data['billing_zip'].toString();
      options['billing_phone'] = data['billing_phone'].toString();
      options['billing_fax'] = data['billing_fax'].toString();
      
      options['shipping_attention'] = data['shipping_attention'].toString();
      options['shipping_country_id'] = data['shipping_country_id'].toString();
      options['shipping_address'] = data['shipping_address'].toString();
      options['shipping_state_id'] = data['shipping_state_id'].toString();
      options['shipping_city_id'] = data['shipping_city_id'].toString();
      options['shipping_zip'] = data['shipping_zip'].toString();
      options['shipping_phone'] = data['shipping_phone'].toString();
      options['shipping_fax'] = data['shipping_fax'].toString();
      
      if(data['payroll'] != null) {
          hra = data['payroll']['hra'].toString();
          conveyance = data['payroll']['conveyance'].toString();
          educationAllowance = data['payroll']['education_allowance'].toString();
          medicalReimbursement = data['payroll']['medical_reimbursement'].toString();
          specialAllowance = data['payroll']['special_allowance'].toString();
          dateOfJoining = data['payroll']['date_of_joining'].toString();
          basicSalary = data['payroll']['basic_salary'].toString();
          employeeTypeId = data['payroll']['employee_type_id'].toString();
          designationId = data['payroll']['designation_id'].toString();
          grade = data['payroll']['grade'].toString();
          capabilities = data['payroll']['capabilities'].toString();
          experience = data['payroll']['experience'].toString();
          license = data['payroll']['license'].toString();
          medicalReimbursement = data['payroll']['medical_reimbursement'].toString();
          educationAllowance = data['payroll']['education_allowance'].toString();
          specialAllowance = data['payroll']['special_allowance'].toString();
           
      }
      
       if(data['bank'] != null) {
          bankName = data['bank']['bank_name'].toString();
          bankBranch = data['bank']['branch_name'].toString();
          accountName = data['bank']['account_name'].toString();
          accountNumber = data['bank']['account_number'].toString();
          ifscCode = data['bank']['ifsc_code'].toString();
      }
      
      
      if(data['professional_detail'] != null) {  
          //log('professional_detail: ${data['professional_detail']}'); 
          options['experience'] = data['professional_detail']['experience'].toString();
          options['source_of_hire'] = data['professional_detail']['source_of_hire'].toString();
          options['skill_set'] = data['professional_detail']['skill_set'].toString();
          options['heihest_qualification'] = data['professional_detail']['heihest_qualification'].toString();
          options['additional_info'] = data['professional_detail']['additional_info'].toString();
          options['state_id'] = data['professional_detail']['state_id'].toString();
          // options['department_id'] = data['professional_detail']['department_id'].toString();
          options['designation_id'] = data['professional_detail']['designation_id'].toString();
          options['current_salary'] = data['professional_detail']['current_salary'].toString();
          options['joining_date'] = data['professional_detail']['joining_date'].toString();
      }
      
      if(data['health_information'] != null) {  
          options['allergic_status'] = data['health_information']['allergic_status'].toString();
          options['blood_group'] = data['health_information']['blood_group'].toString();
          options['medications'] = data['health_information']['medications'].toString();
          options['medical_history'] = data['health_information']['medical_history'].toString();
      }
       
      staffProfessionalInformation = data['staff_professional_information']
          .map<StaffProfessionalInformation>((e) =>
              StaffProfessionalInformation.fromJson(e))
          .toList();
          
      staffEducationInformations = data['staff_education_informations']
          .map<StaffEducationInformations>((e) =>
              StaffEducationInformations.fromJson(e))
          .toList();
          
      staffAssets = data['staff_assets']
          .map<StaffAssets>((e) =>
              StaffAssets.fromJson(e))
          .toList();
    }

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final response = await context.read<StaffCubit>().getExtraData();
      roles = response.data?.roles;
      departments = response.data?.departments;
      warehouses = response.data?.warehouses;
      branches = response.data?.branches;
      employeeTypes = response.data?.employeeTypes;
      designations = response.data?.designations;
      setState(() {});
    });

    context.read<hr.HrCubit>().getExtraSales().then((value) {
      countries = value.data?.country ?? [];
      setState(() {});
    });
  }

  setData(key, value) {
    options[key] = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => StaffCubit(),
        child: BlocConsumer<StaffCubit, StaffState>(listener: (context, state) {
          if (state is ChangeFormValuesState) {
            setValue(state);
          }

          if (state is RoleIdState) {
            roleId = state.roleId;
          }

          if (state is ValidationErrorState) {
            errorBags = state.errors;
          }
        }, builder: (context, state) {
          return buildScaffold(context);
        }));
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: XButton(
        label: 'Save',
        onPressed: () async {
          context.read<StaffCubit>().createStaff({
            'edit_id': widget.editId != 0 ? widget.editId : null,
            'role_id': roleId,
            'name': name, 
            'password': password,
            'email': email,
            'phone': phone,
            'department_id': departmentId,
            'warehouse_id': warehouseId,
            'branch_id': branchId,
            'dob': dob,
            'current_address': currentAddress,
            'permanent_address': permanentAddress,
            'opening_balance': openingBalance,
            'image': image.path != ''
                ? await MultipartFile.fromFile(image.path)
                : null,
            'applicable_for_leave': applicableForLeave,
            'signature': signature.path != ''
                ? await MultipartFile.fromFile(signature.path)
                : null,
            'documents':
                documents.map((e) => MultipartFile.fromFile(e.path)).toList(),
            'mid_name': midName,
            'last_name': lastName,
            'father_name': fatherName,
            'mother_name': motherName,
            'spouse_name': spouseName,
            'pan_number': panNumber,
            'aadhar_number': aadharNumber,
            'alt_phone': altPhone,
            'leave_limit': leaveLimit,
            'bank_name': bankName,
            'branch_name': bankBranch,
            'account_name': accountName,
            'account_number': accountNumber,
            'ifsc_code': ifscCode,
            'date_of_joining': dateOfJoining,
            'basic_salary': basicSalary,
            'emplpyee_type_id': employeeTypeId,
            'designation_id': designationId,
            'grade': grade,
            'capabilities': capabilities,
            'experience': experience,
            'license': license,
            'hra': hra,
            'conveyance': conveyance,
            'education_allowance': educationAllowance,
            'medical_reimbursement': medicalReimbursement,
            'special_allowance': specialAllowance,
            'speciality': speciality,
            'options': options, 
            'offer_letter' : offerLetter.path != '' ? await MultipartFile.fromFile(offerLetter.path) : null,
            'staff_professional_information':
                staffProfessionalInformation.map((e) => e.toJson()).toList(),
            // multiple files
            'staff_education_informations': staffEducationInformations.map((e) => e.toJson()).toList(),
            'staff_assets': staffAssets.map((e) => e.toJson()).toList(),  
          }, context).then((value) {
            if (value.errors == null) {
              Navigator.pop(context); 
            }
          });
        },
      ),
      appBar: AppBar(
        title: const Text('Staff Update or Create'),
      ),
      body: SingleChildScrollView(
          child: XContainer(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.editId != 0)
            XCard(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 35, backgroundImage: NetworkImage(imageUrl)),
                    const SizedBox(height: 10),
                    Text(name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(email,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 10),
                    ProfileExtra(
                        title: 'Department',
                        value: departmentId != null
                            ? departments
                                    ?.firstWhere((element) =>
                                        element.id.toString() ==
                                        departmentId.toString())
                                    .name ??
                                ''
                            : ''),
                    // ProfileExtra(
                    //     title: 'Branch',
                    //     value: branchId != null
                    //         ? branches
                    //                 ?.firstWhere((element) =>
                    //                     element.id.toString() ==
                    //                     branchId.toString())
                    //                 .name ??
                    //             ''
                    //         : ''),
                    ProfileExtra(title: 'Leave Limit', value: leaveLimit),
                    ProfileExtra(
                        title: 'Opening Balance', value: openingBalance),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 10),

          personalDetails(context),
          Address(),
          EmergencyAndHealth(),
          joinDetails(),
          ProfessionalInfo(),
          bankDetails(context),
          salaryDetails(context),
          //RolesDetails(context),
          const SizedBox(height: 50),
        ],
      ))),
    );
  }

  Container ProfessionalInfo() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            'Professional Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          SizedBox(
            // height: staffProfessionalInformation.length > 1 ? 500 : 0,
            child: ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Professional Information ${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            staffProfessionalInformation.removeAt(index);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    XInput(
                      initialValue:
                          staffProfessionalInformation[index].companyName ?? '',
                      onChanged: (value) => {
                        staffProfessionalInformation[index].companyName = value, 
                      },
                      label: 'Company Name',
                      hintText: 'Enter company name',
                    ),
                    XInput(
                      type: 'date',
                      initialValue:
                          staffProfessionalInformation[index].joiningDate ?? '',
                      onChanged: (value) => {
                        staffProfessionalInformation[index].joiningDate = value,
                        setState(() {}) 
                      },
                      label: 'Joining Date',
                      hintText: 'Chooose joining date',
                    ),
                    XInput(
                      type: 'date',
                      initialValue:
                          staffProfessionalInformation[index].relievingDate ??
                              '',
                      onChanged: (value) => {
                        staffProfessionalInformation[index].relievingDate = value, 
                        setState(() {})
                      },
                      label: 'Relieving Date',
                      hintText: 'Chooose relieving date',
                    ),
                    XInput(
                      initialValue:
                          staffProfessionalInformation[index].totalExperience ??
                              '',
                      onChanged: (value) =>
                          {
                            staffProfessionalInformation[index].totalExperience =
                                value,
                          },
                      label: 'Total Experience',
                      hintText: 'Enter total experience',
                    ),
                    XInput(
                      initialValue:
                          staffProfessionalInformation[index].contactNumber ??
                              '',
                      onChanged: (value) => {
                         staffProfessionalInformation[index].contactNumber = value,
                      },
                      label: 'Contact Number',
                      hintText: 'Enter contact number',
                    ),
                    XSelect(
                      value:
                          staffProfessionalInformation[index].designationId ??
                              '',
                      onChanged: (value) => {
                         staffProfessionalInformation[index].designationId = value,
                         setState(() {})
                      },
                      label: 'Designation',
                      options: designations
                              ?.map((e) => DropDownItem(
                                  value: e.id.toString(), label: e.name))
                              .toList() ??
                          [],
                    ),
                    XInput(
                      initialValue:
                          staffProfessionalInformation[index].salary ?? '',
                      onChanged: (value) => {
                         staffProfessionalInformation[index].salary = value,
                      },
                      label: 'Salary',
                      hintText: 'Enter salary',
                    ), 
                    XFileImage( 
                      onChanged: (value) async {
                        
                        context.read<main.MainCubit>().postRes('upload-file', {
                          'file' : await MultipartFile.fromFile(value.path)
                        }, context, multipart: true).then((value) {
                              if(value.errors == null) {
                                staffProfessionalInformation[index].joiningLetterDocument = value.data['path'];
                                setState(() {});
                              }
                        });
                        
                        // staffProfessionalInformation[index].joiningLetterDocument =
                        //      MultipartFile.fromFile(value.path); 
                      },
                      label: 'Joining Letter Document',
                    ),
                    XFileImage( 
                      onChanged: (value) async { 
                        
                        context.read<main.MainCubit>().postRes('upload-file', {
                          'file' : await MultipartFile.fromFile(value.path)
                        }, context, multipart: true).then((value) {
                              if(value.errors == null) {
                                staffProfessionalInformation[index].relievingLetterDocument = value.data['path'];
                              }
                        });
                        //  staffProfessionalInformation[index].relievingLetterDocument = await MultipartFile.fromFile(value.path);
                         setState(() {});  
                      }, 
                      label: 'Relieving Letter Document',
                    ),
                    XFileImage(
                      onChanged: (value) async {
                        context.read<main.MainCubit>().postRes('upload-file', {
                          'file' : await MultipartFile.fromFile(value.path)
                        }, context, multipart: true).then((value) {
                              if(value.errors == null) {
                                staffProfessionalInformation[index].paySlipDocument = value.data['path'];
                              }
                        });
                        // staffProfessionalInformation[index].paySlipDocument = await MultipartFile.fromFile(value.path);
                        setState(() {});  
                      },
                      label: 'Pay Slip Document',
                    ),
                    XFileImage(
                      // file: staffProfessionalInformation['bank_statement_document'],
                      onChanged: (value) async {
                        context.read<main.MainCubit>().postRes('upload-file', {
                          'file' : await MultipartFile.fromFile(value.path)
                        }, context, multipart: true).then((value) {
                              if(value.errors == null) {
                                staffProfessionalInformation[index].bankStatementDocument = value.data['path'];
                              }
                        });
                      //  staffProfessionalInformation[index].bankStatementDocument = await MultipartFile.fromFile(value.path); 
                       setState(() {}); 
                      },  
                      label: 'Bank Statement Document',
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: staffProfessionalInformation.length,
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          XButton(
            label: 'Add More',
            onPressed: () {
              staffProfessionalInformation.add(StaffProfessionalInformation());
              setState(() {});
            },
          ),
          const SizedBox(
            height: 9,
          ),
          const Text(
            'Education Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          SizedBox(
            // height: staffEducationInformations.length > 1 ? 500 : 0,
            child: ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return Column(children: [
                  Row(
                    children: [
                      Text(
                        'Education Information ${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          staffEducationInformations.removeAt(index);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  XInput(
                    initialValue:
                        staffEducationInformations[index].institutionName ?? '',
                    onChanged: (value) => {
                      staffEducationInformations[index].institutionName = value, 
                    },
                    label: 'Institution Name',
                    hintText: 'Enter institution name',
                  ),
                  XSelect(
                    value:
                        staffEducationInformations[index].educationType ?? '',
                    onChanged: (value) => {
                      staffEducationInformations[index].educationType = value,
                      setState(() {})
                    },
                    label: 'Education Type',
                    options: ['SSC', 'HSC', 'BSC', 'MSC', 'PHD']
                        .map((e) => DropDownItem(value: e, label: e))
                        .toList(),
                  ),
                  XInput(
                    type: 'date',
                    initialValue:
                        staffEducationInformations[index].joiningDate ?? '',
                    onChanged: (value) => {
                      staffEducationInformations[index].joiningDate = value,
                      setState(() {})
                    },
                    label: 'Joining Date',
                    hintText: 'Chooose joining date',
                  ), 
                  XInput(
                    type: 'date',
                    initialValue:
                        staffEducationInformations[index].passingDate ?? '',
                    onChanged: (value) => {
                      staffEducationInformations[index].passingDate = value,
                      setState(() {})
                    },
                    label: 'Passing Date',
                    hintText: 'Chooose passing date',
                  ),
                  XFileImage(
                    allowMultiple: true,  
                    // file: staffEducationInformations[index].educationDocumenents ?? '',
                    onChangedMultiple : (value) async {
                      List<MultipartFile> files = [];
                      List<String> paths = [];
                      for (var file in value) {
                        context.read<main.MainCubit>().postRes('upload-file', {
                          'file' : await MultipartFile.fromFile(file.path)
                        }, context, multipart: true).then((value) {
                              if(value.errors == null) {
                                paths.add(value.data['path']); 
                              }
                        });
                      }
                      
                      staffEducationInformations[index].educationDocuments = paths.map((e) => EducationDocuments(
                        educationFile: e
                      )).toList(); 
                      
                      
                      // staffEducationInformations[index].educationDocuments = value.map((e) =>
                      //   EducationDocuments(
                      //     educationFile: e.path, 
                      //   )
                      // ).toList(); 
                      
                      // staffEducationInformations[index].educationDocuments = value.map((e)  =>  EducationDocuments(
                      //   educationFile: e.path, 
                      // )).toList();
                      setState(() {});
                    }, 
                    onChanged: (value) { 
                      // log('value: $value');  
                      // // staffEducationInformations[index].educationDocuments = value.map((e) => staffEducationInformations[index].educationDocuments?.add(
                      // //   EducationDocuments(
                      // //     educationFile: 'sdsd'   
                      // //   )
                      // // )).toList();
                      // setState(() {}); 
                    },
                    label: 'Education Documenents',
                  ),
                ]);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: staffEducationInformations.length,
            ),
          ),
          
          const SizedBox(
            height: 9,
          ),
          
          XButton(
            label: 'Add More',
            onPressed: () {
              staffEducationInformations.add(StaffEducationInformations());
              setState(() {});
            },
          ), 
          
          const SizedBox(
            height: 9,
          ),  


          const Text(
            'Assets',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          SizedBox(
            // height: staffAssets.length > 1 ? 500 : 0,
            child: ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return Column(children: [
                  Row(
                    children: [
                      Text(
                        'Assets ${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          staffAssets.removeAt(index);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  XInput(
                    initialValue:
                        staffAssets[index].assetType ?? '',
                    onChanged: (value) => {
                      staffAssets[index].assetType = value,
                    },
                    label: 'Asset Type',
                    hintText: 'Enter asset type',
                  ),
                  XInput(
                    initialValue:
                        staffAssets[index].addOn ?? '',
                    onChanged: (value) => {
                      staffAssets[index].addOn = value,
                    },
                    label: 'Add On',
                    hintText: 'Enter add on', 
                  ),
                  XInput(
                    type: 'date',
                    initialValue:
                        staffAssets[index].issueDate ?? '',
                    onChanged: (value) => {
                      staffAssets[index].issueDate = value,
                      setState(() {})
                    },
                    label: 'Issue Date',
                    hintText: 'Chooose issue date',
                  ), 
                  XInput(
                    type: 'date',
                    initialValue:
                        staffAssets[index].returnDate ?? '',
                    onChanged: (value) => {
                      staffAssets[index].returnDate = value,
                      setState(() {}) 
                    },
                    label: 'Return Date',
                    hintText: 'Chooose return date',
                  ),
                ]);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: staffAssets.length,
            ),
          ),
          
          const SizedBox(
            height: 9,
          ),
          
          XButton(
            label: 'Add More',
            onPressed: () {
              staffAssets.add(StaffAssets());
              setState(() {});
            },
          ), 
          
          const SizedBox(
            height: 9,
          ),  
          
           
           
          
        ],
      ),
    );
  }

  Column joinDetails() {
    return Column(
      children: [
        const Text(
          'Joining Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 9,
        ),
        XInput(
          initialValue: options['experience'],
          onChanged: (value) => {setData('experience', value)},
          label: 'Experience',
          hintText: 'Enter experience',
        ),
        XSelect(
          value: options['source_of_hire'],
          onChanged: (value) => {setData('source_of_hire', value)},
          label: 'Source of Hire',
          options: [
            'Direct',
            'Indirect',
            'News Paper',
            'Other',
            'Referral',
            'Social Media',
            'Website'
          ].map((e) => DropDownItem(value: e, label: e)).toList(),
        ),
        XSelect(
          value: options['heihest_qualification'],
          onChanged: (value) => {setData('heihest_qualification', value)},
          label: 'Highest Qualification',
          options: ['10th', '12th', 'Graduation', 'Post Graduation', 'Other']
              .map((e) => DropDownItem(value: e, label: e))
              .toList(),
        ),
        XFileImage(
          stringFileUrls: options['offer_letter'] != null ? [options['offer_letter']] : [],
          file: offerLetter,
          onChanged: (value) {
            offerLetter = value;
          },
          label: 'Offer Letter',
        ),
        XInput(
          initialValue: options['additional_info'],
          onChanged: (value) => {setData('additional_info', value)},
          label: 'Additional Information',
          hintText: 'Enter additional information',
        ),
        XInput(
          initialValue: options['skill_set'],
          onChanged: (value) => {setData('skill_set', value)},
          label: 'Skill Set',
          hintText: 'Enter skill set',
        ),
      ],
    );
  }

  Column EmergencyAndHealth() {
    return Column(
      children: [
        const Text(
          'Emergency Contact Information',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 9,
        ),
        XInput(
          initialValue: options['emergency_contact_name'],
          onChanged: (value) => {setData('emergency_contact_name', value)},
          label: 'Contact Name',
          hintText: 'Enter name',
        ),
        XInput(
          initialValue: options['emergency_contact_number'],
          onChanged: (value) => {setData('emergency_contact_number', value)},
          label: 'Contact Number',
          hintText: 'Enter contact number',
        ),
        XInput(
          initialValue: options['emergency_contact_alt_number'],
          onChanged: (value) =>
              {setData('emergency_contact_alt_number', value)},
          label: 'Alternate Contact Number',
          hintText: 'Enter alternate contact number',
        ),
        XSelect(
          value: options['emergency_contact_relation'],
          onChanged: (value) => {setData('emergency_contact_relation', value)},
          label: 'Relation',
          options: relationships
              .map((e) => DropDownItem(value: e, label: e))
              .toList(),
        ),
        const Text(
          'Health Information',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 9,
        ),
        XSelect(
          value: options['religion'],
          onChanged: (value) => {setData('religion', value)},
          label: 'Religion',
          options: ['Hindu', 'Muslim', 'Christian', 'Sikh', 'Other']
              .map((e) => DropDownItem(value: e, label: e))
              .toList(),
        ),
        XSelect(
          value: options['allergic_status'],
          onChanged: (value) => {setData('allergic_status', value)},
          label: 'Allergic Status',
          options: ['Yes', 'No']
              .map((e) => DropDownItem(value: e, label: e))
              .toList(),
        ),
        XSelect(
          value: options['blood_group'],
          onChanged: (value) => {setData('blood_group', value)},
          label: 'Blood Group',
          options:
              bloodGroups.map((e) => DropDownItem(value: e, label: e)).toList(),
        ),
        XSelect(
          value: options['medications'],
          onChanged: (value) => {setData('medications', value)},
          label: 'Medications',
          options: ['Yes', 'No']
              .map((e) => DropDownItem(value: e, label: e))
              .toList(),
        ),
        XInput(
          initialValue: options['medical_history'],
          onChanged: (value) => {setData('medical_history', value)},
          label: 'Medical History',
          hintText: 'Enter medical history',
        ),
        const SizedBox(
          height: 9,
        ),
      ],
    );
  }

  Column Address() {
    return Column(
      children: [
        TabBar(
          unselectedLabelColor: Colors.black,
          // labelColor: Colors.red,
          tabs: const [
            Tab(
              text: 'Current Address',
            ),
            Tab( 
              text: 'Permanent Address',
            ),
          ],
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 850,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    XInput(
                      initialValue: options['billing_attention'],
                      onChanged: (value) =>
                          {setData('billing_attention', value)},
                      label: 'Attention',
                      hintText: 'Enter attention',
                    ),
                    XInput(
                      initialValue: options['billing_address'],
                      onChanged: (value) => {setData('billing_address', value)},
                      height: 0.2,
                      label: 'Address',
                      hintText: 'Enter address',
                    ),
                    XSelect(
                      value: options['billing_country_id'],
                      onChanged: (value) =>
                          {setData('billing_country_id', value)},
                      label: 'Country',
                      options: countries
                          .map((e) => DropDownItem(
                              value: e.id.toString(), label: e.name))
                          .toList(),
                    ),
                    XSelect(
                      value: options['billing_state_id'],
                      onChanged: (value) =>
                          {setData('billing_state_id', value)},
                      label: 'State',
                      options: countries
                              .where((element) =>
                                  element.id.toString() ==
                                  options['billing_country_id'])
                              .firstOrNull
                              ?.states
                              ?.map((e) => DropDownItem(
                                  value: e.id.toString(), label: e.name))
                              .toList() ??
                          [],
                    ),
                    XSelect(
                      value: options['billing_city_id'],
                      onChanged: (value) => {setData('billing_city_id', value)},
                      label: 'City',
                      options: countries
                              .where((element) =>
                                  element.id.toString() ==
                                  options['billing_country_id'])
                              .firstOrNull
                              ?.states
                              ?.where((element) =>
                                  element.id.toString() ==
                                  options['billing_state_id'])
                              .firstOrNull
                              ?.cities
                              ?.map((e) => DropDownItem(
                                  value: e.id.toString(), label: e.name))
                              .toList() ??
                          [],
                    ),
                    XInput(
                      initialValue: options['billing_zip'],
                      onChanged: (value) => {setData('billing_zip', value)},
                      label: 'Zip Code',
                      hintText: 'Enter zip code',
                    ),
                    XInput(
                      initialValue: options['billing_phone'],
                      onChanged: (value) => {setData('billing_phone', value)},
                      label: 'Phone',
                      hintText: 'Enter phone',
                    ),
                    XInput(
                      initialValue: options['billing_fax'],
                      onChanged: (value) => {setData('billing_fax', value)},
                      label: 'Fax',
                      hintText: 'Enter fax',
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    XInput(
                      initialValue: options['shipping_attention'],
                      onChanged: (value) =>
                          {setData('shipping_attention', value)},
                      label: 'Attention',
                      hintText: 'Enter attention',
                    ),
                    XInput(
                      initialValue: options['shipping_address'],
                      onChanged: (value) =>
                          {setData('shipping_address', value)},
                      height: 0.2,
                      label: 'Address',
                      hintText: 'Enter address',
                    ),
                    XSelect(
                      value: options['shipping_country_id'],
                      onChanged: (value) =>
                          {setData('shipping_country_id', value)},
                      label: 'Country',
                      options: countries
                          .map((e) => DropDownItem(
                              value: e.id.toString(), label: e.name))
                          .toList(),
                    ),
                    XSelect(
                      value: options['shipping_state_id'],
                      onChanged: (value) =>
                          {setData('shipping_state_id', value)},
                      label: 'State',
                      options: countries
                              .where((element) =>
                                  element.id.toString() ==
                                  options['shipping_country_id'])
                              .firstOrNull
                              ?.states
                              ?.map((e) => DropDownItem(
                                  value: e.id.toString(), label: e.name))
                              .toList() ??
                          [],
                    ),
                    XSelect(
                      value: options['shipping_city_id'],
                      onChanged: (value) =>
                          {setData('shipping_city_id', value)},
                      label: 'City',
                      options: countries
                              .where((element) =>
                                  element.id.toString() ==
                                  options['shipping_country_id'])
                              .firstOrNull
                              ?.states
                              ?.where((element) =>
                                  element.id.toString() ==
                                  options['shipping_state_id'])
                              .firstOrNull
                              ?.cities
                              ?.map((e) => DropDownItem(
                                  value: e.id.toString(), label: e.name))
                              .toList() ??
                          [],
                    ),
                    XInput(
                      initialValue: options['shipping_zip'],
                      onChanged: (value) => {setData('shipping_zip', value)},
                      label: 'Zip Code',
                      hintText: 'Enter zip code',
                    ),
                    XInput(
                      initialValue: options['shipping_phone'],
                      onChanged: (value) => {setData('shipping_phone', value)},
                      label: 'Phone',
                      hintText: 'Enter phone',
                    ),
                    XInput(
                      initialValue: options['shipping_fax'],
                      onChanged: (value) => {setData('shipping_fax', value)},
                      label: 'Fax',
                      hintText: 'Enter fax',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Column RolesDetails(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Roles',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 9,
        ),
        XMenu(
          height: 0.4,
          sectionTitle: 'HR Management',
          children: [
            XMenuItem(
                icon: CupertinoIcons.doc_plaintext,
                onTap: () {},
                title: 'Departments'),
            XMenuItem(
                icon: CupertinoIcons.doc_person,
                onTap: () {},
                title: 'Employee Types'),
            XMenuItem(
                icon: Icons.design_services_outlined,
                onTap: () {},
                title: 'Designation'),
            XMenuItem(
                icon: Icons.supervised_user_circle_sharp,
                onTap: () {},
                title: 'Staffs'),
            XMenuItem(
                icon: CupertinoIcons.checkmark_shield,
                onTap: () {},
                title: 'Roles'),
            XMenuItem(
                icon: CupertinoIcons.money_dollar,
                onTap: () {},
                title: 'Payroll'),
            XMenuItem(
                icon: CupertinoIcons.doc_append,
                onTap: () {},
                title: 'Salary Advance'),
            XMenuItem(
                icon: CupertinoIcons.person_crop_circle_badge_checkmark,
                onTap: () {},
                title: 'Attendance'),
            XMenuItem(
                icon: Icons.mobile_friendly_outlined,
                onTap: () {},
                title: 'Salaries'),
          ],
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
          initialValue: dateOfJoining,
          onChanged: (value) {
            context
                .read<StaffCubit>()
                .changeFormValues('date_of_joining', value);
          },
          label: 'Date of Joining',
          hintText: 'Chooose date of joining',
        ),
        XInput(
          model: 'basic_salary',
          errorBags: errorBags,
          keyboardType: TextInputType.number,
          initialValue: basicSalary,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('basic_salary', value);
          },
          label: 'Basic Salary',
          hintText: 'Enter basic salary',
        ),
        XSelect(
          model: 'employee_type_id',
          errorBags: errorBags,
          value: employeeTypeId,
          onChanged: (value) {
            context
                .read<StaffCubit>()
                .changeFormValues('employee_type_id', value);
          },
          label: 'Employee Type',
          isMandatory: true,
          options: employeeTypes
                  ?.map((e) =>
                      DropDownItem(value: e.id.toString(), label: e.name))
                  .toList() ??
              [],
        ),
        XSelect(
          model: 'designation_id',
          errorBags: errorBags,
          value: designationId,
          onChanged: (value) {
            context
                .read<StaffCubit>()
                .changeFormValues('designation_id', value);
          },
          label: 'Designation',
          isMandatory: true,
          options: designations
                  ?.map((e) =>
                      DropDownItem(value: e.id.toString(), label: e.name))
                  .toList() ??
              [],
        ),
        XInput(
          model: 'grade',
          errorBags: errorBags,
          initialValue: grade,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('grade', value);
          },
          label: 'Grade',
          hintText: 'Enter grade',
        ),
        XInput(
          model: 'speciality',
          errorBags: errorBags,
          initialValue: capabilities,
          onChanged: (value) {
            speciality = value;
          },
          label: 'Speciality',
          hintText: 'Enter speciality',
        ),
        XInput(
          model: 'license',
          errorBags: errorBags,
          initialValue: capabilities,
          onChanged: (value) {
            license = value;
          },
          label: 'License',
          hintText: 'Enter license',
        ),
        XInput(
          model: 'capabilities',
          errorBags: errorBags,
          initialValue: capabilities,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('capabilities', value);
          },
          label: 'Capabilities',
          hintText: 'Enter capabilities',
        ),
        XInput(
          model: 'experience',
          errorBags: errorBags,
          initialValue: experience,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('experience', value);
          },
          label: 'Experience',
          hintText: 'Enter experience',
        ),
        XInput(
          model: 'hra',
          errorBags: errorBags,
          initialValue: hra,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('hra', value);
          },
          label: 'HRA',
          hintText: 'Enter hra',
        ),
        XInput(
          model: 'conveyance',
          errorBags: errorBags,
          initialValue: conveyance,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('conveyance', value);
          },
          label: 'Conveyance',
          hintText: 'Enter conveyance',
        ),
        XInput(
          model: 'education_allowance',
          errorBags: errorBags,
          initialValue: educationAllowance,
          onChanged: (value) {
            context
                .read<StaffCubit>()
                .changeFormValues('education_allowance', value);
          },
          label: 'Education Allowance',
          hintText: 'Enter education allowance',
        ),
        XInput(
          model: 'medical_reimbursement',
          errorBags: errorBags,
          initialValue: medicalReimbursement,
          onChanged: (value) {
            context
                .read<StaffCubit>()
                .changeFormValues('medical_reimbursement', value);
          },
          label: 'Medical Reimbursement',
          hintText: 'Enter medical reimbursement',
        ),
        XInput(
          model: 'special_allowance',
          errorBags: errorBags,
          initialValue: specialAllowance,
          onChanged: (value) {
            context
                .read<StaffCubit>()
                .changeFormValues('special_allowance', value);
          },
          label: 'Special Allowance',
          hintText: 'Enter special allowance',
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Column bankDetails(BuildContext context) {
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
          initialValue: bankName,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('bank_name', value);
          },
          label: 'Bank Name',
          hintText: 'Enter bank name',
        ),
        XInput(
          model: 'bank_branch',
          errorBags: errorBags,
          initialValue: bankBranch,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('bank_branch', value);
          },
          label: 'Bank Branch',
          hintText: 'Enter bank branch',
        ),
        XInput(
          model: 'account_name',
          errorBags: errorBags,
          initialValue: accountName,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('account_name', value);
          },
          label: 'Account Name',
          hintText: 'Enter account name',
        ),
        XInput(
          model: 'account_number',
          errorBags: errorBags,
          keyboardType: TextInputType.number,
          initialValue: accountNumber,
          onChanged: (value) {
            context
                .read<StaffCubit>()
                .changeFormValues('account_number', value);
          },
          label: 'Account Number',
          hintText: 'Enter account number',
        ),
        XInput(
          model: 'ifsc_code',
          errorBags: errorBags,
          initialValue: ifscCode,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('ifsc_code', value);
          },
          label: 'IFSC Code',
          hintText: 'Enter ifsc code',
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Column personalDetails(BuildContext context) {
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
          value: roleId,
          onChanged: (value) {
            context.read<StaffCubit>().changeRoleId(value.toString());
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
          initialValue: name,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('name', value);
          },
          isMandatory: true,
          label: 'Name',
          hintText: 'Enter name',
        ),

        XInput(
          model: 'password',
          errorBags: errorBags,
          initialValue: password,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('password', value);
          },
          isMandatory: true,
          label: 'Password',
          hintText: 'Enter password',
        ),

        XInput(
          model: 'email',
          errorBags: errorBags,
          isMandatory: true,
          initialValue: email,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('email', value);
          },
          label: 'Email',
          hintText: 'Enter email',
        ),

        XInput(
          model: 'phone',
          errorBags: errorBags,
          isMandatory: true,
          initialValue: phone,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('phone', value);
          },
          label: 'Phone',
          hintText: 'Enter phone',
        ),

        XSelect(
          value: departmentId,
          model: 'department_id',
          errorBags: errorBags,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('department_id', value);
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
          value: warehouseId,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('warehouse_id', value);
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
          value: branchId,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('branch_id', value);
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
          initialValue: dob,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('dob', value);
          },
          label: 'Date of Birth',
          hintText: 'Enter dob',
        ),

        // XInput(
        //   errorBags: errorBags,
        //   model: 'current_address',
        //   height: 0.1,
        //   isMandatory: true,
        //   initialValue: currentAddress,
        //   onChanged: (value) {
        //     context
        //         .read<StaffCubit>()
        //         .changeFormValues('current_address', value);
        //   },
        //   label: 'Current Address',
        //   hintText: 'Enter current address',
        // ),

        // XInput(
        //   errorBags: errorBags,
        //   model: 'permanent_address',
        //   height: 0.1,
        //   isMandatory: true,
        //   initialValue: permanentAddress,
        //   onChanged: (value) {
        //     context
        //         .read<StaffCubit>()
        //         .changeFormValues('permanent_address', value);
        //   },
        //   label: 'Permanent Address',
        //   hintText: 'Enter permanent address',
        // ),

        // XSelect(
        //   value: options['religion'],
        //   onChanged: (value) => {
        //     setData('religion', value)
        //   },
        //   label: 'Religion',
        //   options: ['Hindu', 'Muslim', 'Christian', 'Sikh', 'Other']
        //       .map((e) => DropDownItem(value: e, label: e))
        //       .toList(),
        // ),

        XInput(
          keyboardType: TextInputType.number,
          errorBags: errorBags,
          model: 'opening_balance',
          isMandatory: true,
          initialValue: openingBalance,
          onChanged: (value) {
            context
                .read<StaffCubit>()
                .changeFormValues('opening_balance', value);
          },
          label: 'Opening Balance',
          hintText: 'Enter opening balance',
        ),
 
        XFileImage( 
          stringFileUrls: data['image'] != null ? [data['image']] : [], 
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('image', value);
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
          initialValue: applicableForLeave,
          onChanged: (value) {
            context
                .read<StaffCubit>()
                .changeFormValues('applicable_for_leave', value);
          },
          label: 'Applicable For Leave',
          hintText: 'Enter applicable for leave',
        ),

        XFileImage(
          stringFileUrls: data['signature'] != null ? [data['signature']] : [], 
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('signature', value);
          },
          label: 'Signature',
          isMandatory: true,
        ),

        XFileImage(
          stringFileUrls: data['documents'] != null ? data['documents'] : [],
          allowMultiple: true,
          label: 'Documents',
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('documents', value);
          },
          isMandatory: true,
        ),

        XInput(
          model: 'mid_name',
          errorBags: errorBags,
          isMandatory: true,
          initialValue: midName,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('mid_name', value);
          },
          label: 'Middle Name',
          hintText: 'Enter middle name',
        ),

        XInput(
          errorBags: errorBags,
          model: 'last_name',
          isMandatory: true,
          initialValue: lastName,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('last_name', value);
          },
          label: 'Last Name',
          hintText: 'Enter last name',
        ),

        XInput(
          errorBags: errorBags,
          model: 'father_name',
          isMandatory: true,
          initialValue: fatherName,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('father_name', value);
          },
          label: 'Father Name',
          hintText: 'Enter father name',
        ),

        XInput(
          errorBags: errorBags,
          model: 'mother_name',
          isMandatory: true,
          initialValue: motherName,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('mother_name', value);
          },
          label: 'Mother Name',
          hintText: 'Enter mother name',
        ),

        XInput(
          errorBags: errorBags,
          model: 'spouse_name',
          isMandatory: true,
          initialValue: spouseName,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('spouse_name', value);
          },
          label: 'Spouse Name',
          hintText: 'Enter spouse name',
        ),

        XInput(
          errorBags: errorBags,
          model: 'pan_number',
          isMandatory: true,
          initialValue: panNumber,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('pan_number', value);
          },
          label: 'Pan Number',
          hintText: 'Enter pan number',
        ),

        XInput(
          errorBags: errorBags,
          model: 'aadhar_number',
          keyboardType: TextInputType.number,
          isMandatory: true,
          initialValue: aadharNumber,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('aadhar_number', value);
          },
          label: 'Aadhar Number',
          hintText: 'Enter aadhar number',
        ),

        XInput(
          errorBags: errorBags,
          model: 'alt_phone',
          keyboardType: TextInputType.number,
          isMandatory: true,
          initialValue: altPhone,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('alt_phone', value);
          },
          label: 'Alt Phone',
          hintText: 'Enter alt phone',
        ),

        XInput(
          errorBags: errorBags,
          model: 'leave_limit',
          keyboardType: TextInputType.number,
          isMandatory: true,
          initialValue: leaveLimit,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('leave_limit', value);
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

  void setValue(ChangeFormValuesState state) {
    switch (state.type) {
      case 'name':
        name = state.value;
        break;
      case 'password':
        password = state.value;
        break;
      case 'email':
        email = state.value;
        break;
      case 'phone':
        phone = state.value;
        break;
      case 'department_id':
        departmentId = state.value;
        break;
      case 'warehouse_id':
        warehouseId = state.value;
        break;
      case 'branch_id':
        branchId = state.value;
        break;
      case 'dob':
        dob = state.value;
        break;
      case 'current_address':
        currentAddress = state.value;
        break;
      case 'permanent_address':
        permanentAddress = state.value;
        break;
      case 'opening_balance':
        openingBalance = state.value;
        break;
      case 'image':
        image = state.value;
        break;
      case 'applicable_for_leave':
        applicableForLeave = state.value;
        break;
      case 'signature':
        signature = state.value;
        break;
      case 'mid_name':
        midName = state.value;
        break;
      case 'last_name':
        lastName = state.value;
        break;
      case 'father_name':
        fatherName = state.value;
        break;
      case 'mother_name':
        motherName = state.value;
        break;
      case 'spouse_name':
        spouseName = state.value;
        break;
      case 'pan_number':
        panNumber = state.value;
        break;
      case 'aadhar_number':
        aadharNumber = state.value;
        break;
      case 'alt_phone':
        altPhone = state.value;
        break;
      case 'leave_limit':
        leaveLimit = state.value;
        break;
      case 'bank_name':
        bankName = state.value;
        break;
      case 'bank_branch':
        bankBranch = state.value;
        break;
      case 'account_name':
        accountName = state.value;
        break;
      case 'account_number':
        accountNumber = state.value;
        break;
      case 'ifsc_code':
        ifscCode = state.value;
        break;
      case 'date_of_joining':
        dateOfJoining = state.value;
        break;
      case 'basic_salary':
        basicSalary = state.value;
        break;
      case 'employee_type_id':
        employeeTypeId = state.value;
        break;
      case 'designation_id':
        designationId = state.value;
        break;
      case 'grade':
        grade = state.value;
        break;
      case 'capabilities':
        capabilities = state.value;
        break;
      case 'experience':
        experience = state.value;
        break;
      case 'hra':
        hra = state.value;
        break;
      case 'conveyance':
        conveyance = state.value;
        break;
      case 'education_allowance':
        educationAllowance = state.value;
        break;
      case 'medical_reimbursement':
        medicalReimbursement = state.value;
        break;
      case 'special_allowance':
        specialAllowance = state.value;
        break;
    }
  }
}

class ProfileExtra extends StatelessWidget {
  String title = '';
  String value = '';
  ProfileExtra({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  Text(value,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            )),
        const SizedBox(height: 5),
      ],
    );
  }
}
