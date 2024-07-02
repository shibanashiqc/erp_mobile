class CustomerExtraModel {
  String? status;
  String? message;
  Data? data;

  CustomerExtraModel({this.status, this.message, this.data});

  CustomerExtraModel.fromJson(Map<String, dynamic> json) {
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
  List<Proceedures>? proceedures;
  List<Drugs>? drugs;
  List<Invoices>? invoices;

  Data({this.proceedures, this.drugs});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['proceedures'] != null) {
      proceedures = <Proceedures>[];
      json['proceedures'].forEach((v) {
        proceedures!.add(new Proceedures.fromJson(v));
      });
    }
    if (json['drugs'] != null) {
      drugs = <Drugs>[];
      json['drugs'].forEach((v) {
        drugs!.add(new Drugs.fromJson(v));
      });
    }
    
    if (json['invoices'] != null) {
      invoices = <Invoices>[];
      json['invoices'].forEach((v) {
        invoices!.add(new Invoices.fromJson(v));
      });
    }
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.proceedures != null) {
      data['proceedures'] = this.proceedures!.map((v) => v.toJson()).toList();
    }
    if (this.drugs != null) {
      data['drugs'] = this.drugs!.map((v) => v.toJson()).toList();
    }
    
    if (this.invoices != null) {
      data['invoices'] = this.invoices!.map((v) => v.toJson()).toList();
    }
    
    return data;
  }
}

class Proceedures {
  int? id;
  String? name;
  String? price;
  String? createdAt;
  String? updatedAt;

  Proceedures({this.id, this.name, this.price, this.createdAt, this.updatedAt});

  Proceedures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Drugs {
  int? id;
  String? name;
  String? type;
  String? strength;
  String? dosage;
  String? note;
  String? createdAt;
  String? updatedAt;

  Drugs(
      {this.id,
      this.name,
      this.type,
      this.strength,
      this.dosage,
      this.note,
      this.createdAt,
      this.updatedAt});

  Drugs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    strength = json['strength'];
    dosage = json['dosage'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['strength'] = this.strength;
    data['dosage'] = this.dosage;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Invoices {
  int? id;
  int? customerId;
  String? invoiceNumber;
  String? totalCost;
  String? totalDiscount;
  String? totalTax;
  String? grandTotal;
  String? notes;
  String? createdAt;
  String? updatedAt;
  List<Items>? items;

  Invoices(
      {this.id,
      this.customerId,
      this.invoiceNumber,
      this.totalCost,
      this.totalDiscount,
      this.totalTax,
      this.grandTotal,
      this.notes,
      this.createdAt,
      this.updatedAt,
      this.items});

  Invoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    invoiceNumber = json['invoice_number'];
    totalCost = json['total_cost'];
    totalDiscount = json['total_discount'];
    totalTax = json['total_tax'];
    grandTotal = json['grand_total'];
    notes = json['notes'];
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
    data['notes'] = this.notes;
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
  int? appointmentInvoiceId;
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

  Items(
      {this.id,
      this.appointmentInvoiceId,
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
      this.updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentInvoiceId = json['appointment_invoice_id'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appointment_invoice_id'] = this.appointmentInvoiceId;
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
    return data;
  }
}