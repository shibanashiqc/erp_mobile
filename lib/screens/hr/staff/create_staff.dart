// ignore_for_file: must_be_immutable
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:erp_mobile/cubit/hr/staff/staff_cubit.dart';
import 'package:erp_mobile/models/hr/hr_extra_data_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/x_button.dart';
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
  String? title = '';
  String? description = '';
  int? status = 1;
  CreateStaff(
      {super.key, this.editId, this.title, this.description, this.status});

  @override
  State<CreateStaff> createState() => _CreateStaffState();
}

class _CreateStaffState extends State<CreateStaff> {
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

  @override
  void initState() {
    super.initState();
    if (widget.editId != null) {}

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final response = await context.read<StaffCubit>().getExtraData();
      roles = response.data?.roles;
      departments = response.data?.departments;
      warehouses = response.data?.warehouses;
      branches = response.data?.branches;
      employeeTypes = response.data?.employeeTypes;
      designations = response.data?.designations;
      setState(() {
      });
    });
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
            'image': image.path != '' ? await MultipartFile.fromFile(image.path) : null,
            'applicable_for_leave': applicableForLeave,
            'signature': signature.path != '' ? await MultipartFile.fromFile(signature.path) : null, 
            'documents': documents.map((e) => MultipartFile.fromFile(e.path)).toList(), 
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
            'license' : license,
            'hra': hra,
            'conveyance': conveyance,
            'education_allowance': educationAllowance,
            'medical_reimbursement': medicalReimbursement,
            'special_allowance': specialAllowance,
            'speciality': speciality,
            
          }, 
          context
          ).then((value) {
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          personalDetails(context),
          bankDetails(context),
          salaryDetails(context),
          //RolesDetails(context),
          const SizedBox(height: 50),
        ],
      ))),
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
            context.read<StaffCubit>().changeFormValues('date_of_joining', value);
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
                  ?.map((e) => DropDownItem(value: e.id.toString(), label: e.name))
                  .toList() ?? [],
        ),
        XSelect(
          model: 'designation_id',
          errorBags: errorBags,
          value: designationId,
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('designation_id', value);
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
            context.read<StaffCubit>().changeFormValues('account_number', value);
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
                  ?.map((e) => DropDownItem(value: e.id.toString(), label: e.name))
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
                  ?.map((e) => DropDownItem(value: e.id.toString(), label: e.name))
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
                  ?.map((e) => DropDownItem(value: e.id.toString(), label: e.name))
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
                  ?.map((e) => DropDownItem(value: e.id.toString(), label: e.name))
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

        XInput(
          errorBags: errorBags,
          model: 'current_address',
          height: 0.1,
          isMandatory: true,
          initialValue: currentAddress,
          onChanged: (value) {
            context
                .read<StaffCubit>()
                .changeFormValues('current_address', value);
          },
          label: 'Current Address',
          hintText: 'Enter current address',
        ),

        XInput(
          errorBags: errorBags,
          model: 'permanent_address',
          height: 0.1,
          isMandatory: true,
          initialValue: permanentAddress,
          onChanged: (value) {
            context
                .read<StaffCubit>()
                .changeFormValues('permanent_address', value);
          },
          label: 'Permanent Address',
          hintText: 'Enter permanent address',
        ),

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
          onChanged: (value) {
            context.read<StaffCubit>().changeFormValues('signature', value);
          },
          label: 'Signature',
          isMandatory: true,
        ),

        XFileImage(
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
