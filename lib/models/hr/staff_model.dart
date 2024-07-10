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
  dynamic billingAttention;
  dynamic billingCountryId;
  dynamic billingAddress;
  dynamic billingStateId;
  dynamic billingCityId;
  dynamic billingZip;
  dynamic billingPhone;
  dynamic billingFax;
  dynamic shippingAttention;
  dynamic shippingCountryId;
  dynamic shippingAddress;
  dynamic shippingStateId;
  dynamic shippingCityId;
  dynamic shippingZip;
  dynamic shippingPhone;
  dynamic shippingFax;
  dynamic vendorId;
  dynamic speciality;
  dynamic license;

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
      this.license});

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
  String? prevPageUrl;

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
