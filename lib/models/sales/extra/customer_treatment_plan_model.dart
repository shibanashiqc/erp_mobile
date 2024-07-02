class CustomerTreatmentPlanModel {
  String? status;
  String? message;
  List<Data>? data;
  Meta? meta;

  CustomerTreatmentPlanModel({this.status, this.message, this.data, this.meta});

  CustomerTreatmentPlanModel.fromJson(Map<String, dynamic> json) {
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
  int? customerId;
  String? invoiceNumber;
  String? totalCost;
  String? totalDiscount;
  String? totalTax;
  String? grandTotal;
  String? createdAt;
  String? updatedAt;
  List<Items>? items;

  Data(
      {this.id,
      this.customerId,
      this.invoiceNumber,
      this.totalCost,
      this.totalDiscount,
      this.totalTax,
      this.grandTotal,
      this.createdAt,
      this.updatedAt,
      this.items});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    invoiceNumber = json['invoice_number'];
    totalCost = json['total_cost'];
    totalDiscount = json['total_discount'];
    totalTax = json['total_tax'];
    grandTotal = json['grand_total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['invoice_number'] = this.invoiceNumber;
    data['total_cost'] = this.totalCost;
    data['total_discount'] = this.totalDiscount;
    data['total_tax'] = this.totalTax;
    data['grand_total'] = this.grandTotal;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  int? customerTreatmentId;
  String? itemName;
  int? proceedureId;
  int? unit;
  String? cost;
  int? discountValue;
  String? discountAmount;
  int? taxValue;
  String? taxAmount;
  String? total;
  String? createdAt;
  String? updatedAt;
  int? isCompleted = 0;

  Items(
      {this.id,
      this.customerTreatmentId,
      this.itemName,
      this.proceedureId,
      this.unit,
      this.cost,
      this.discountValue,
      this.discountAmount,
      this.taxValue,
      this.taxAmount,
      this.total,
      this.createdAt,
      this.updatedAt,
      this.isCompleted = 0});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerTreatmentId = json['customer_treatment_id'];
    itemName = json['item_name'];
    proceedureId = json['proceedure_id'];
    unit = json['unit'];
    cost = json['cost'];
    discountValue = json['discount_value'];
    discountAmount = json['discount_amount'];
    taxValue = json['tax_value'];
    taxAmount = json['tax_amount'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isCompleted = json['is_completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_treatment_id'] = this.customerTreatmentId;
    data['item_name'] = this.itemName;
    data['proceedure_id'] = this.proceedureId;
    data['unit'] = this.unit;
    data['cost'] = this.cost;
    data['discount_value'] = this.discountValue;
    data['discount_amount'] = this.discountAmount;
    data['tax_value'] = this.taxValue;
    data['tax_amount'] = this.taxAmount;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_completed'] = this.isCompleted;
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
