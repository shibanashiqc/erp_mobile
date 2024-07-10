class CustomerTimelineModel {
  String? status;
  String? message;
  List<Data>? data;

  CustomerTimelineModel({this.status, this.message, this.data});

  CustomerTimelineModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? date;
  List<Items>? items;

  Data({this.date, this.items});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  int? customerId;
  String? invoiceNumber;
  String? totalCost;
  String? totalDiscount;
  String? totalTax;
  String? grandTotal;
  String? createdAt;
  String? updatedAt;
  String? module;
  String? notes;

  Items(
      {this.id,
      this.customerId,
      this.invoiceNumber,
      this.totalCost,
      this.totalDiscount,
      this.totalTax,
      this.grandTotal,
      this.createdAt,
      this.updatedAt,
      this.module,
      this.notes});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    invoiceNumber = json['invoice_number'];
    totalCost = json['total_cost'];
    totalDiscount = json['total_discount'];
    totalTax = json['total_tax'];
    grandTotal = json['grand_total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    module = json['module'];
    notes = json['notes'];
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
    data['module'] = this.module;
    data['notes'] = this.notes;
    return data;
  }
}
