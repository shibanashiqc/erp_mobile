class CustomersModel {
  String? status;
  String? message;
  List<Data>? data;
  Meta? meta;

  CustomersModel({this.status, this.message, this.data, this.meta});

  CustomersModel.fromJson(Map<String, dynamic> json) {
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
  int? customerTypeId;
  String? name;
  String? companyName;
  String? email;
  String? phone;
  String? alternatePhone;
  String? panNumber;
  String? image;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;
  dynamic branchId; 
  String? dob;
  String? bloodGroup;
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
      this.imageUrl,
      this.createdAt,
      this.updatedAt,
      this.branchId});

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
    imageUrl = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    branchId = json['branch_id'];
     dob = json['dob'];
    bloodGroup = json['blood_group'];
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
    data['image_url'] = this.imageUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['branch_id'] = this.branchId;
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
  Null? prevPageUrl;

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
