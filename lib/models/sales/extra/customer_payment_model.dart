class CustomerPatmentModel {
  String? status;
  String? message;
  List<Data>? data;
  Meta? meta;

  CustomerPatmentModel({this.status, this.message, this.data, this.meta});

  CustomerPatmentModel.fromJson(Map<String, dynamic> json) {
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
  String? recieptNumber;
  String? amountPaid;
  String? amountRemaining;
  String? amountToPay;
  String? modeOfPayment;
  String? notes;
  String? createdAt;
  String? updatedAt;
  List<Invoices>? invoices;

  Data(
      {this.id,
      this.customerId,
      this.recieptNumber,
      this.amountPaid,
      this.amountRemaining,
      this.amountToPay,
      this.modeOfPayment,
      this.notes,
      this.createdAt,
      this.updatedAt,
      this.invoices});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    recieptNumber = json['reciept_number'];
    amountPaid = json['amount_paid'];
    amountRemaining = json['amount_remaining'];
    amountToPay = json['amount_to_pay'];
    modeOfPayment = json['mode_of_payment'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['invoices'] != null) {
      invoices = <Invoices>[];
      json['invoices'].forEach((v) {
        invoices!.add(new Invoices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['reciept_number'] = this.recieptNumber;
    data['amount_paid'] = this.amountPaid;
    data['amount_remaining'] = this.amountRemaining;
    data['amount_to_pay'] = this.amountToPay;
    data['mode_of_payment'] = this.modeOfPayment;
    data['notes'] = this.notes;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.invoices != null) {
      data['invoices'] = this.invoices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Invoices {
  int? id;
  int? paymentRecieptId;
  int? appointmentInvoiceId;
  String? amountPaid;
  double? dueAfter;
  String? invoiceNumber;
  String? amountRemaining;
  String? createdAt;
  String? updatedAt;

  Invoices(
      {this.id,
      this.paymentRecieptId,
      this.appointmentInvoiceId,
      this.amountPaid,
      this.dueAfter,
      this.invoiceNumber, 
      this.amountRemaining,
      this.createdAt,
      this.updatedAt});

  Invoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentRecieptId = json['payment_reciept_id'];
    appointmentInvoiceId = json['appointment_invoice_id'];
    amountPaid = json['amount_paid'];
    amountRemaining = json['amount_remaining'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_reciept_id'] = this.paymentRecieptId;
    data['appointment_invoice_id'] = this.appointmentInvoiceId;
    data['amount_paid'] = this.amountPaid;
    data['amount_remaining'] = this.amountRemaining;
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
