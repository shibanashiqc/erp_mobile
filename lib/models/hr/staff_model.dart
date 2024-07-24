class StaffModel {
  String? status;
  String? message;
  List<Data>? data;
  Meta? meta;

  StaffModel({this.status, this.message, this.data, this.meta});

  StaffModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? roleId;
  String? name;
  String? email;
  String? phone;
  int? departmentId;
  int? warehouseId;
  int? branchId;
  String? dob;
  String? currentAddress;
  String? permanentAddress;
  String? openingBalance;
  String? image;
  String? applicableForLeave;
  String? signature;
  String? createdAt;
  String? updatedAt;
  String? midName;
  String? lastName;
  String? fatherName;
  String? motherName;
  String? spouseName;
  String? panNumber;
  String? aadharNumber;
  String? altPhone;
  int? leaveLimit;
  String? billingAttention;
  int? billingCountryId;
  String? billingAddress;
  int? billingStateId;
  int? billingCityId;
  String? billingZip;
  String? billingPhone;
  String? billingFax;
  String? shippingAttention;
  int? shippingCountryId;
  String? shippingAddress;
  int? shippingStateId;
  int? shippingCityId;
  String? shippingZip;
  String? shippingPhone;
  String? shippingFax;
  dynamic vendorId;
  String? speciality;
  String? license;
  String? emergencyContactName;
  String? emergencyContactNumber;
  String? emergencyContactAltNumber;
  String? emergencyContactRelation;
  String? religion;
  String? employeeId;
  String? gender;
  dynamic maritalStatus;
  String? aadharImage;
  ProfessionalDetail? professionalDetail;
  HealthInformation? healthInformation;
  List<StaffProfessionalInformation>? staffProfessionalInformation;
  List<StaffAssets>? staffAssets;
  List<StaffEducationInformations>? staffEducationInformations;
  Payroll? payroll;
  Bank? bank;

  Data(
      {this.id,
      this.userId,
      this.roleId,
      this.name,
      this.email,
      this.phone,
      this.departmentId,
      this.warehouseId,
      this.branchId,
      this.dob,
      this.currentAddress,
      this.permanentAddress,
      this.openingBalance,
      this.image,
      this.applicableForLeave,
      this.signature,
      this.createdAt,
      this.updatedAt,
      this.midName,
      this.lastName,
      this.fatherName,
      this.motherName,
      this.spouseName,
      this.panNumber,
      this.aadharNumber,
      this.altPhone,
      this.leaveLimit,
      this.billingAttention,
      this.billingCountryId,
      this.billingAddress,
      this.billingStateId,
      this.billingCityId,
      this.billingZip,
      this.billingPhone,
      this.billingFax,
      this.shippingAttention,
      this.shippingCountryId,
      this.shippingAddress,
      this.shippingStateId,
      this.shippingCityId,
      this.shippingZip,
      this.shippingPhone,
      this.shippingFax,
      this.vendorId,
      this.speciality,
      this.license,
      this.emergencyContactName,
      this.emergencyContactNumber,
      this.emergencyContactAltNumber,
      this.emergencyContactRelation,
      this.religion,
      this.employeeId,
      this.gender,
      this.maritalStatus,
      this.aadharImage,
      this.professionalDetail,
      this.healthInformation,
      this.staffProfessionalInformation,
      this.staffAssets,
      this.staffEducationInformations,
      this.payroll,
      this.bank});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    roleId = json['role_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    departmentId = json['department_id'];
    warehouseId = json['warehouse_id'];
    branchId = json['branch_id'];
    dob = json['dob'];
    currentAddress = json['current_address'];
    permanentAddress = json['permanent_address'];
    openingBalance = json['opening_balance'];
    image = json['image'];
    applicableForLeave = json['applicable_for_leave'];
    signature = json['signature'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    midName = json['mid_name'];
    lastName = json['last_name'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    spouseName = json['spouse_name'];
    panNumber = json['pan_number'];
    aadharNumber = json['aadhar_number'];
    altPhone = json['alt_phone'];
    leaveLimit = json['leave_limit'];
    billingAttention = json['billing_attention'];
    billingCountryId = json['billing_country_id'];
    billingAddress = json['billing_address'];
    billingStateId = json['billing_state_id'];
    billingCityId = json['billing_city_id'];
    billingZip = json['billing_zip'];
    billingPhone = json['billing_phone'];
    billingFax = json['billing_fax'];
    shippingAttention = json['shipping_attention'];
    shippingCountryId = json['shipping_country_id'];
    shippingAddress = json['shipping_address'];
    shippingStateId = json['shipping_state_id'];
    shippingCityId = json['shipping_city_id'];
    shippingZip = json['shipping_zip'];
    shippingPhone = json['shipping_phone'];
    shippingFax = json['shipping_fax'];
    vendorId = json['vendor_id'];
    speciality = json['speciality'];
    license = json['license'];
    emergencyContactName = json['emergency_contact_name'];
    emergencyContactNumber = json['emergency_contact_number'];
    emergencyContactAltNumber = json['emergency_contact_alt_number'];
    emergencyContactRelation = json['emergency_contact_relation'];
    religion = json['religion'];
    employeeId = json['employee_id'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    aadharImage = json['aadhar_image'];
    professionalDetail = json['professional_detail'] != null
        ? new ProfessionalDetail.fromJson(json['professional_detail'])
        : null;
    healthInformation = json['health_information'] != null
        ? new HealthInformation.fromJson(json['health_information'])
        : null;
    if (json['staff_professional_information'] != null) {
      staffProfessionalInformation = <StaffProfessionalInformation>[];
      json['staff_professional_information'].forEach((v) {
        staffProfessionalInformation!
            .add(new StaffProfessionalInformation.fromJson(v));
      });
    }
    if (json['staff_assets'] != null) {
      staffAssets = <StaffAssets>[];
      json['staff_assets'].forEach((v) {
        staffAssets!.add(new StaffAssets.fromJson(v));
      });
    }
    if (json['staff_education_informations'] != null) {
      staffEducationInformations = <StaffEducationInformations>[];
      json['staff_education_informations'].forEach((v) {
        staffEducationInformations!
            .add(new StaffEducationInformations.fromJson(v));
      });
    }
    
    payroll =
        json['payroll'] != null ? new Payroll.fromJson(json['payroll']) : null;
    bank = json['bank'] != null ? new Bank.fromJson(json['bank']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['department_id'] = this.departmentId;
    data['warehouse_id'] = this.warehouseId;
    data['branch_id'] = this.branchId;
    data['dob'] = this.dob;
    data['current_address'] = this.currentAddress;
    data['permanent_address'] = this.permanentAddress;
    data['opening_balance'] = this.openingBalance;
    data['image'] = this.image;
    data['applicable_for_leave'] = this.applicableForLeave;
    data['signature'] = this.signature;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['mid_name'] = this.midName;
    data['last_name'] = this.lastName;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['spouse_name'] = this.spouseName;
    data['pan_number'] = this.panNumber;
    data['aadhar_number'] = this.aadharNumber;
    data['alt_phone'] = this.altPhone;
    data['leave_limit'] = this.leaveLimit;
    data['billing_attention'] = this.billingAttention;
    data['billing_country_id'] = this.billingCountryId;
    data['billing_address'] = this.billingAddress;
    data['billing_state_id'] = this.billingStateId;
    data['billing_city_id'] = this.billingCityId;
    data['billing_zip'] = this.billingZip;
    data['billing_phone'] = this.billingPhone;
    data['billing_fax'] = this.billingFax;
    data['shipping_attention'] = this.shippingAttention;
    data['shipping_country_id'] = this.shippingCountryId;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_state_id'] = this.shippingStateId;
    data['shipping_city_id'] = this.shippingCityId;
    data['shipping_zip'] = this.shippingZip;
    data['shipping_phone'] = this.shippingPhone;
    data['shipping_fax'] = this.shippingFax;
    data['vendor_id'] = this.vendorId;
    data['speciality'] = this.speciality;
    data['license'] = this.license;
    data['emergency_contact_name'] = this.emergencyContactName;
    data['emergency_contact_number'] = this.emergencyContactNumber;
    data['emergency_contact_alt_number'] = this.emergencyContactAltNumber;
    data['emergency_contact_relation'] = this.emergencyContactRelation;
    data['religion'] = this.religion;
    data['employee_id'] = this.employeeId;
    data['gender'] = this.gender;
    data['marital_status'] = this.maritalStatus;
    data['aadhar_image'] = this.aadharImage;
    if (this.professionalDetail != null) {
      data['professional_detail'] = this.professionalDetail!.toJson();
    }
    if (this.healthInformation != null) {
      data['health_information'] = this.healthInformation!.toJson();
    }
    if (this.staffProfessionalInformation != null) {
      data['staff_professional_information'] =
          this.staffProfessionalInformation!.map((v) => v.toJson()).toList();
    }
    if (this.staffAssets != null) {
      data['staff_assets'] = this.staffAssets!.map((v) => v.toJson()).toList();
    }
    if (this.staffEducationInformations != null) {
      data['staff_education_informations'] =
          this.staffEducationInformations!.map((v) => v.toJson()).toList();
    }
    if (this.payroll != null) {
      data['payroll'] = this.payroll!.toJson();
    }
    if (this.bank != null) {
      data['bank'] = this.bank!.toJson();
    }
    return data;
  }
}
class Payroll {
  int? id;
  int? staffId;
  String? dateOfJoining;
  String? basicSalary;
  String? hra;
  String? conveyance;
  String? educationAllowance;
  String? specialAllowance;
  String? medicalReimbursement;
  int? emplpyeeTypeId;
  int? rovisionTime;
  String? createdAt;
  String? updatedAt;
  dynamic esi;
  dynamic epf;
  int? departmentId;
  int? designationId;
  String? grade;
  String? capabilities;
  String? experience;
  dynamic vendorId;

  Payroll(
      {this.id,
      this.staffId,
      this.dateOfJoining,
      this.basicSalary,
      this.hra,
      this.conveyance,
      this.educationAllowance,
      this.specialAllowance,
      this.medicalReimbursement,
      this.emplpyeeTypeId,
      this.rovisionTime,
      this.createdAt,
      this.updatedAt,
      this.esi,
      this.epf,
      this.departmentId,
      this.designationId,
      this.grade,
      this.capabilities,
      this.experience,
      this.vendorId});

  Payroll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    dateOfJoining = json['date_of_joining'];
    basicSalary = json['basic_salary'];
    hra = json['hra'];
    conveyance = json['conveyance'];
    educationAllowance = json['education_allowance'];
    specialAllowance = json['special_allowance'];
    medicalReimbursement = json['medical_reimbursement'];
    emplpyeeTypeId = json['emplpyee_type_id'];
    rovisionTime = json['rovision_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    esi = json['esi'];
    epf = json['epf'];
    departmentId = json['department_id'];
    designationId = json['designation_id'];
    grade = json['grade'];
    capabilities = json['capabilities'];
    experience = json['experience'];
    vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['date_of_joining'] = this.dateOfJoining;
    data['basic_salary'] = this.basicSalary;
    data['hra'] = this.hra;
    data['conveyance'] = this.conveyance;
    data['education_allowance'] = this.educationAllowance;
    data['special_allowance'] = this.specialAllowance;
    data['medical_reimbursement'] = this.medicalReimbursement;
    data['emplpyee_type_id'] = this.emplpyeeTypeId;
    data['rovision_time'] = this.rovisionTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['esi'] = this.esi;
    data['epf'] = this.epf;
    data['department_id'] = this.departmentId;
    data['designation_id'] = this.designationId;
    data['grade'] = this.grade;
    data['capabilities'] = this.capabilities;
    data['experience'] = this.experience;
    data['vendor_id'] = this.vendorId;
    return data;
  }
}

class Bank {
  int? id;
  int? staffId;
  String? bankName;
  String? branchName;
  String? accountName;
  String? accountNumber;
  String? createdAt;
  String? updatedAt;
  String? ifscCode;
  dynamic vendorId;

  Bank(
      {this.id,
      this.staffId,
      this.bankName,
      this.branchName,
      this.accountName,
      this.accountNumber,
      this.createdAt,
      this.updatedAt,
      this.ifscCode,
      this.vendorId});

  Bank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ifscCode = json['ifsc_code'];
    vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['ifsc_code'] = this.ifscCode;
    data['vendor_id'] = this.vendorId;
    return data;
  }
}

class ProfessionalDetail {
  int? id;
  int? staffId;
  String? experience;
  String? sourceOfHire;
  String? skillSet;
  String? heihestQualification;
  String? additionalInfo;
  dynamic stateId;
  int? departmentId;
  int? designationId;
  dynamic currentSalary;
  dynamic joiningDate;
  String? offerLetter;
  String? createdAt;
  String? updatedAt;
  dynamic vendorId;

  ProfessionalDetail(
      {this.id,
      this.staffId,
      this.experience,
      this.sourceOfHire,
      this.skillSet,
      this.heihestQualification,
      this.additionalInfo,
      this.stateId,
      this.departmentId,
      this.designationId,
      this.currentSalary,
      this.joiningDate,
      this.offerLetter,
      this.createdAt,
      this.updatedAt,
      this.vendorId});

  ProfessionalDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    experience = json['experience'];
    sourceOfHire = json['source_of_hire'];
    skillSet = json['skill_set'];
    heihestQualification = json['heihest_qualification'];
    additionalInfo = json['additional_info'];
    stateId = json['state_id'];
    departmentId = json['department_id'];
    designationId = json['designation_id'];
    currentSalary = json['current_salary'];
    joiningDate = json['joining_date'];
    offerLetter = json['offer_letter'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['experience'] = this.experience;
    data['source_of_hire'] = this.sourceOfHire;
    data['skill_set'] = this.skillSet;
    data['heihest_qualification'] = this.heihestQualification;
    data['additional_info'] = this.additionalInfo;
    data['state_id'] = this.stateId;
    data['department_id'] = this.departmentId;
    data['designation_id'] = this.designationId;
    data['current_salary'] = this.currentSalary;
    data['joining_date'] = this.joiningDate;
    data['offer_letter'] = this.offerLetter;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['vendor_id'] = this.vendorId;
    return data;
  }
}

class HealthInformation {
  int? id;
  int? staffId;
  dynamic allergicStatus;
  dynamic allergicType;
  dynamic bloodGroup;
  dynamic medications;
  dynamic medicationType;
  dynamic medicalHistory;
  String? createdAt;
  String? updatedAt;

  HealthInformation(
      {this.id,
      this.staffId,
      this.allergicStatus,
      this.allergicType,
      this.bloodGroup,
      this.medications,
      this.medicationType,
      this.medicalHistory,
      this.createdAt,
      this.updatedAt});

  HealthInformation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    allergicStatus = json['allergic_status'];
    allergicType = json['allergic_type'];
    bloodGroup = json['blood_group'];
    medications = json['medications'];
    medicationType = json['medication_type'];
    medicalHistory = json['medical_history'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['allergic_status'] = this.allergicStatus;
    data['allergic_type'] = this.allergicType;
    data['blood_group'] = this.bloodGroup;
    data['medications'] = this.medications;
    data['medication_type'] = this.medicationType;
    data['medical_history'] = this.medicalHistory;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class StaffProfessionalInformation {
  int? id;
  int? staffId;
  String? companyName;
  String? joiningDate;
  String? relievingDate;
  String? totalExperience;
  dynamic contactNumber; 
  dynamic designationId;
  dynamic salary;
  dynamic joiningLetterDocument;
  dynamic relievingLetterDocument;
  dynamic paySlipDocument;
  dynamic bankStatementDocument;
  String? createdAt;
  String? updatedAt;

  StaffProfessionalInformation(
      {this.id,
      this.staffId,
      this.companyName,
      this.joiningDate,
      this.relievingDate,
      this.totalExperience,
      this.contactNumber,
      this.designationId,
      this.salary,
      this.joiningLetterDocument,
      this.relievingLetterDocument,
      this.paySlipDocument,
      this.bankStatementDocument,
      this.createdAt,
      this.updatedAt});

  StaffProfessionalInformation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    companyName = json['company_name'];
    joiningDate = json['joining_date'];
    relievingDate = json['relieving_date'];
    totalExperience = json['total_experience'];
    contactNumber = json['contact_number'];
    designationId = json['designation_id'];
    salary = json['salary'];
    joiningLetterDocument = json['joining_letter_document'];
    relievingLetterDocument = json['relieving_letter_document'];
    paySlipDocument = json['pay_slip_document'];
    bankStatementDocument = json['bank_statement_document'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    // data['staff_id'] = this.staffId;
    data['company_name'] = this.companyName;
    data['joining_date'] = this.joiningDate;
    data['relieving_date'] = this.relievingDate;
    data['total_experience'] = this.totalExperience;
    data['contact_number'] = this.contactNumber;
    data['designation_id'] = this.designationId;
    data['salary'] = this.salary;
    data['joining_letter_document'] = this.joiningLetterDocument;
    data['relieving_letter_document'] = this.relievingLetterDocument;
    data['pay_slip_document'] = this.paySlipDocument;
    data['bank_statement_document'] = this.bankStatementDocument;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    return data;
  }
}

class StaffAssets {
  int? id;
  int? staffId;
  String? assetType;
  String? addOn;
  String? issueDate;
  String? returnDate;
  String? createdAt;
  String? updatedAt;

  StaffAssets(
      {this.id,
      this.staffId,
      this.assetType,
      this.addOn,
      this.issueDate,
      this.returnDate,
      this.createdAt,
      this.updatedAt});

  StaffAssets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    assetType = json['asset_type'];
    addOn = json['add_on'];
    issueDate = json['issue_date'];
    returnDate = json['return_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    // data['staff_id'] = this.staffId;
    data['asset_type'] = this.assetType;
    data['add_on'] = this.addOn;
    data['issue_date'] = this.issueDate;
    data['return_date'] = this.returnDate;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    return data;
  }
}

class StaffEducationInformations {
  int? id;
  int? staffId;
  String? institutionName;
  String? educationType;
  String? joiningDate;
  String? passingDate;
  String? createdAt;
  String? updatedAt;
  List<EducationDocuments>? educationDocuments;

  StaffEducationInformations(
      {this.id,
      this.staffId,
      this.institutionName,
      this.educationType,
      this.joiningDate,
      this.passingDate,
      this.createdAt,
      this.updatedAt,
      this.educationDocuments});

  StaffEducationInformations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    institutionName = json['institution_name'];
    educationType = json['education_type'];
    joiningDate = json['joining_date'];
    passingDate = json['passing_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['education_documents'] != null) {
      educationDocuments = <EducationDocuments>[];
      json['education_documents'].forEach((v) {
        educationDocuments!.add(new EducationDocuments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    // data['staff_id'] = this.staffId;
    data['institution_name'] = this.institutionName;
    data['education_type'] = this.educationType;
    data['joining_date'] = this.joiningDate;
    data['passing_date'] = this.passingDate;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    if (this.educationDocuments != null) {
      data['education_documents'] =
          this.educationDocuments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EducationDocuments {
  int? id;
  int? staffId;
  int? staffEducationInformationId;
  dynamic educationFile; 
  String? createdAt;
  String? updatedAt;

  EducationDocuments(
      {this.id,
      this.staffId,
      this.staffEducationInformationId,
      this.educationFile,
      this.createdAt,
      this.updatedAt});

  EducationDocuments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    staffEducationInformationId = json['staff_education_information_id'];
    educationFile = json['education_file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id; 
    // data['staff_id'] = this.staffId; 
    // data['staff_education_information_id'] = this.staffEducationInformationId;
    data['education_file'] = this.educationFile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? perPage;
  int? total;
  int? lastPage;
  int? from;
  int? to;
  dynamic prevPageUrl;

  Meta(
      {this.currentPage,
      this.perPage,
      this.total,
      this.lastPage,
      this.from,
      this.to,
      this.prevPageUrl});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    perPage = json['per_page'];
    total = json['total'];
    lastPage = json['last_page'];
    from = json['from'];
    to = json['to'];
    prevPageUrl = json['prev_page_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    data['last_page'] = this.lastPage;
    data['from'] = this.from;
    data['to'] = this.to;
    data['prev_page_url'] = this.prevPageUrl;
    return data;
  }
}
