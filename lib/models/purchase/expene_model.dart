class ExpenseModel {
  String? status;
  String? message;
  List<Data>? data;
  Meta? meta;

  ExpenseModel({this.status, this.message, this.data, this.meta});

  ExpenseModel.fromJson(Map<String, dynamic> json) {
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
  String? date;
  int? categoryId;
  String? amount;
  int? purchaseVendorId;
  String? invoice;
  String? note;
  int? customerId;
  String? image;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.date,
      this.categoryId,
      this.amount,
      this.purchaseVendorId,
      this.invoice,
      this.note,
      this.customerId,
      this.image,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    categoryId = json['category_id'];
    amount = json['amount'];
    purchaseVendorId = json['purchase_vendor_id'];
    invoice = json['invoice'];
    note = json['note'];
    customerId = json['customer_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['category_id'] = this.categoryId;
    data['amount'] = this.amount;
    data['purchase_vendor_id'] = this.purchaseVendorId;
    data['invoice'] = this.invoice;
    data['note'] = this.note;
    data['customer_id'] = this.customerId;
    data['image'] = this.image;
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
