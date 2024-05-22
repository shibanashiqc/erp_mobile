class VendorModel {
  String? status;
  String? message;
  List<Data>? data;
  Meta? meta;

  VendorModel({this.status, this.message, this.data, this.meta});

  VendorModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? lastName;
  String? companyName;
  String? vendorDisplayName;
  String? email;
  String? phone;
  String? mobile;
  String? pan;
  int? currencyId;
  int? paymentTermId;
  int? languageId;
  String? document;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.name,
      this.lastName,
      this.companyName,
      this.vendorDisplayName,
      this.email,
      this.phone,
      this.mobile,
      this.pan,
      this.currencyId,
      this.paymentTermId,
      this.languageId,
      this.document,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['last_name'];
    companyName = json['company_name'];
    vendorDisplayName = json['vendor_display_name'];
    email = json['email'];
    phone = json['phone'];
    mobile = json['mobile'];
    pan = json['pan'];
    currencyId = json['currency_id'];
    paymentTermId = json['payment_term_id'];
    languageId = json['language_id'];
    document = json['document'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['company_name'] = this.companyName;
    data['vendor_display_name'] = this.vendorDisplayName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['mobile'] = this.mobile;
    data['pan'] = this.pan;
    data['currency_id'] = this.currencyId;
    data['payment_term_id'] = this.paymentTermId;
    data['language_id'] = this.languageId;
    data['document'] = this.document;
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
