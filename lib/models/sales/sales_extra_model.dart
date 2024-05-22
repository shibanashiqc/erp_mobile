class SalesExtraModel {
  String? status;
  String? message;
  Data? data;

  SalesExtraModel({this.status, this.message, this.data});

  SalesExtraModel.fromJson(Map<String, dynamic> json) {
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
  List<Customers>? customers;
  List<Products>? products;
  List<SalesPersons>? salesPersons;
  List<PaymentTerms>? paymentTerms;

  Data({this.customers, this.products, this.salesPersons, this.paymentTerms});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['customers'] != null) {
      customers = <Customers>[];
      json['customers'].forEach((v) {
        customers!.add(new Customers.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    if (json['sales_persons'] != null) {
      salesPersons = <SalesPersons>[];
      json['sales_persons'].forEach((v) {
        salesPersons!.add(new SalesPersons.fromJson(v));
      });
    }
    if (json['payment_terms'] != null) {
      paymentTerms = <PaymentTerms>[];
      json['payment_terms'].forEach((v) {
        paymentTerms!.add(new PaymentTerms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customers != null) {
      data['customers'] = this.customers!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.salesPersons != null) {
      data['sales_persons'] =
          this.salesPersons!.map((v) => v.toJson()).toList();
    }
    if (this.paymentTerms != null) {
      data['payment_terms'] =
          this.paymentTerms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customers {
  int? id;
  String? name;
  dynamic phone;

  Customers({this.id, this.name, this.phone});

  Customers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone']; 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? price;

  Products({this.id, this.name, this.price});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}

class SalesPersons {
  int? id;
  String? name;

  SalesPersons({this.id, this.name});

  SalesPersons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class PaymentTerms {
  int? id;
  String? name;
  dynamic percentage;

  PaymentTerms({this.id, this.name});

  PaymentTerms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['percentage'] = this.percentage;
    return data;
  }
}




