class CustomerInfoModel {
  String? status;
  String? message;
  Data? data;

  CustomerInfoModel({this.status, this.message, this.data});

  CustomerInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? customerTypeId;
  String? name;
  String? companyName;
  String? email;
  String? phone;
  String? alternatePhone;
  String? panNumber;
  String? image;
  String? createdAt;
  String? updatedAt;
  dynamic branchId;
  String? dob;
  String? bloodGroup;
  dynamic vendorId;
  dynamic genderId;

  Data(
      {this.id,
      this.customerTypeId,
      this.name,
      this.companyName,
      this.email,
      this.phone,
      this.alternatePhone,
      this.panNumber,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.branchId,
      this.dob,
      this.bloodGroup,
      this.vendorId,
      this.genderId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerTypeId = json['customer_type_id'];
    name = json['name'];
    companyName = json['company_name'];
    email = json['email'];
    phone = json['phone'];
    alternatePhone = json['alternate_phone'];
    panNumber = json['pan_number'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    branchId = json['branch_id'];
    dob = json['dob'];
    bloodGroup = json['blood_group'];
    vendorId = json['vendor_id'];
    genderId = json['gender_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_type_id'] = this.customerTypeId;
    data['name'] = this.name;
    data['company_name'] = this.companyName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['alternate_phone'] = this.alternatePhone;
    data['pan_number'] = this.panNumber;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['branch_id'] = this.branchId;
    data['dob'] = this.dob;
    data['blood_group'] = this.bloodGroup;
    data['vendor_id'] = this.vendorId;
    data['gender_id'] = this.genderId;
    return data;
  }
}
