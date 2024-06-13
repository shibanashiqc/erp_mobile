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
  List<CustomerTypes>? customerTypes;
  List<Country>? country;

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
    
     if (json['customer_types'] != null) {
      customerTypes = <CustomerTypes>[];
      json['customer_types'].forEach((v) {
        customerTypes!.add(new CustomerTypes.fromJson(v));
      });
    }
    if (json['country'] != null) {
      country = <Country>[];
      json['country'].forEach((v) {
        country!.add(new Country.fromJson(v));
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
    if (this.customerTypes != null) {
      data['customer_types'] =
          this.customerTypes!.map((v) => v.toJson()).toList();
    }
    if (this.country != null) {
      data['country'] = this.country!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerTypes {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  CustomerTypes({this.id, this.name, this.createdAt, this.updatedAt});

  CustomerTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
} 

class Country {
  int? id;
  String? code;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<States>? states;

  Country(
      {this.id,
      this.code,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.states});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['states'] != null) {
      states = <States>[];
      json['states'].forEach((v) {
        states!.add(new States.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.states != null) {
      data['states'] = this.states!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class States {
  int? id;
  int? countryId;
  String? code;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Cities>? cities;

  States(
      {this.id,
      this.countryId,
      this.code,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.cities});

  States.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    code = json['code'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['code'] = this.code;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  int? id;
  int? stateId;
  String? name;
  String? createdAt;
  String? updatedAt;

  Cities({this.id, this.stateId, this.name, this.createdAt, this.updatedAt});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateId = json['state_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_id'] = this.stateId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Customers {
  int? id;
  String? name;
  dynamic phone;
  String? email;

  Customers({this.id, this.name, this.phone, this.email});

  Customers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone']; 
    email = json['email']; 
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
  dynamic days;

  PaymentTerms({this.id, this.name});

  PaymentTerms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    percentage = json['percentage'];
    days = json['days'];
  } 

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['percentage'] = this.percentage;
    data['days'] = this.days;
    return data;
  }
}




