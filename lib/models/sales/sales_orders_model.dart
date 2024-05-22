class SalesOrderModel {
  String? status;
  String? message;
  List<Data>? data;
  Meta? meta;

  SalesOrderModel({this.status, this.message, this.data, this.meta});

  SalesOrderModel.fromJson(Map<String, dynamic> json) {
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
  String? orderNumber;
  String? reference;
  String? orderDate;
  String? shipDate;
  int? paymentTermId;
  int? salesPersonId;
  String? subTotal;
  dynamic paidAmount;
  dynamic balanceAmount;
  String? total;
  String? notes;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? phone;
  String? email; 
  dynamic branchId;
  Customer? customer;
  List<SalesOrderItems>? salesOrderItems;

  Data(
      {this.id,
      this.customerId,
      this.orderNumber,
      this.reference,
      this.orderDate,
      this.shipDate,
      this.paymentTermId,
      this.salesPersonId,
      this.subTotal,
      this.paidAmount,
      this.balanceAmount,
      this.total,
      this.notes,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.phone,
      this.email,
      this.branchId,
      this.customer,
      this.salesOrderItems});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    orderNumber = json['order_number'];
    reference = json['reference'];
    orderDate = json['order_date'];
    shipDate = json['ship_date'];
    paymentTermId = json['payment_term_id'];
    salesPersonId = json['sales_person_id'];
    subTotal = json['sub_total'];
    paidAmount = json['paid_amount'];
    balanceAmount = json['balance_amount'];
    total = json['total'];
    notes = json['notes'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    phone = json['phone'];
    email = json['email'];
    branchId = json['branch_id'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['sales_order_items'] != null) {
      salesOrderItems = <SalesOrderItems>[];
      json['sales_order_items'].forEach((v) {
        salesOrderItems!.add(new SalesOrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['order_number'] = this.orderNumber;
    data['reference'] = this.reference;
    data['order_date'] = this.orderDate;
    data['ship_date'] = this.shipDate;
    data['payment_term_id'] = this.paymentTermId;
    data['sales_person_id'] = this.salesPersonId;
    data['sub_total'] = this.subTotal;
    data['paid_amount'] = this.paidAmount;
    data['balance_amount'] = this.balanceAmount;
    data['total'] = this.total;
    data['notes'] = this.notes;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['branch_id'] = this.branchId;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.salesOrderItems != null) {
      data['sales_order_items'] =
          this.salesOrderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
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
  List<Addresses>? addresses;

  Customer(
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
      this.addresses});

  Customer.fromJson(Map<String, dynamic> json) {
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
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
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
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  int? id;
  int? customerId;
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
  String? createdAt;
  String? updatedAt;

  Addresses(
      {this.id,
      this.customerId,
      this.billingAttention,
      this.billingCountryId,
      this.billingAddress,
      this.billingStateId,
      this.billingCityId,
      this.billingZip,
      this.billingPhone,
      this.billingFax,
      this.shippingAttention,
      this.shippingCountryId,
      this.shippingAddress,
      this.shippingStateId,
      this.shippingCityId,
      this.shippingZip,
      this.shippingPhone,
      this.shippingFax,
      this.createdAt,
      this.updatedAt});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['billing_attention'] = this.billingAttention;
    data['billing_country_id'] = this.billingCountryId;
    data['billing_address'] = this.billingAddress;
    data['billing_state_id'] = this.billingStateId;
    data['billing_city_id'] = this.billingCityId;
    data['billing_zip'] = this.billingZip;
    data['billing_phone'] = this.billingPhone;
    data['billing_fax'] = this.billingFax;
    data['shipping_attention'] = this.shippingAttention;
    data['shipping_country_id'] = this.shippingCountryId;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_state_id'] = this.shippingStateId;
    data['shipping_city_id'] = this.shippingCityId;
    data['shipping_zip'] = this.shippingZip;
    data['shipping_phone'] = this.shippingPhone;
    data['shipping_fax'] = this.shippingFax;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SalesOrderItems {
  int? id;
  dynamic salesOrderId;
  dynamic productId;
  dynamic quantity;
  String? rate;
  String? totalPrice;
  String? createdAt;
  String? updatedAt;
  String? orderNumber;
  String? reference;
  String? orderDate;
  String? shipDate;
  dynamic paymentTermId;
  dynamic salesPersonId;
  Product? product;
  SalesPerson? salesPerson;
  PaymentTerm? paymentTerm;

  SalesOrderItems(
      {this.id,
      this.salesOrderId,
      this.productId,
      this.quantity,
      this.rate,
      this.totalPrice,
      this.createdAt,
      this.updatedAt,
      this.orderNumber,
      this.reference,
      this.orderDate,
      this.shipDate,
      this.paymentTermId,
      this.salesPersonId,
      this.product,
      this.salesPerson,
      this.paymentTerm});

  SalesOrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesOrderId = json['sales_order_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    rate = json['rate'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderNumber = json['order_number'];
    reference = json['reference'];
    orderDate = json['order_date'];
    shipDate = json['ship_date'];
    paymentTermId = json['payment_term_id'];
    salesPersonId = json['sales_person_id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    salesPerson = json['sales_person'] != null
        ? new SalesPerson.fromJson(json['sales_person'])
        : null;
    paymentTerm = json['payment_term'] != null
        ? new PaymentTerm.fromJson(json['payment_term'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sales_order_id'] = this.salesOrderId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['rate'] = this.rate;
    data['total_price'] = this.totalPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['order_number'] = this.orderNumber;
    data['reference'] = this.reference;
    data['order_date'] = this.orderDate;
    data['ship_date'] = this.shipDate;
    data['payment_term_id'] = this.paymentTermId;
    data['sales_person_id'] = this.salesPersonId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.salesPerson != null) {
      data['sales_person'] = this.salesPerson!.toJson();
    }
    if (this.paymentTerm != null) {
      data['payment_term'] = this.paymentTerm!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  int? productTypeId;
  int? productBrandId;
  int? categoryId;
  int? subCategoryId;
  String? price;
  int? quantity;
  String? name;
  String? sku;
  String? image;
  String? description;
  dynamic unit;
  dynamic taxType;
  String? taxRate;
  String? purchasePrice;
  String? salePrice;
  String? createdAt;
  String? updatedAt;
  int? productUnitId; 
  int? inventoryTypeId;
  dynamic expiryDate;
  dynamic manufacturingDate;
  dynamic receivedDate;
  dynamic modeOfReceive;
  dynamic billImage;
  dynamic branchId;

  Product(
      {this.id,
      this.productTypeId,
      this.productBrandId,
      this.categoryId,
      this.subCategoryId,
      this.price,
      this.quantity,
      this.name,
      this.sku,
      this.image,
      this.description,
      this.unit,
      this.taxType,
      this.taxRate,
      this.purchasePrice,
      this.salePrice,
      this.createdAt,
      this.updatedAt,
      this.productUnitId,
      this.inventoryTypeId,
      this.expiryDate,
      this.manufacturingDate,
      this.receivedDate,
      this.modeOfReceive,
      this.billImage,
      this.branchId});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productTypeId = json['product_type_id'];
    productBrandId = json['product_brand_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    price = json['price'];
    quantity = json['quantity'];
    name = json['name'];
    sku = json['sku'];
    image = json['image'];
    description = json['description'];
    unit = json['unit'];
    taxType = json['tax_type'];
    taxRate = json['tax_rate'];
    purchasePrice = json['purchase_price'];
    salePrice = json['sale_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productUnitId = json['product_unit_id'];
    inventoryTypeId = json['inventory_type_id'];
    expiryDate = json['expiry_date'];
    manufacturingDate = json['manufacturing_date'];
    receivedDate = json['received_date'];
    modeOfReceive = json['mode_of_receive'];
    billImage = json['bill_image'];
    branchId = json['branch_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_type_id'] = this.productTypeId;
    data['product_brand_id'] = this.productBrandId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    data['sku'] = this.sku;
    data['image'] = this.image;
    data['description'] = this.description;
    data['unit'] = this.unit;
    data['tax_type'] = this.taxType;
    data['tax_rate'] = this.taxRate;
    data['purchase_price'] = this.purchasePrice;
    data['sale_price'] = this.salePrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product_unit_id'] = this.productUnitId;
    data['inventory_type_id'] = this.inventoryTypeId;
    data['expiry_date'] = this.expiryDate;
    data['manufacturing_date'] = this.manufacturingDate;
    data['received_date'] = this.receivedDate;
    data['mode_of_receive'] = this.modeOfReceive;
    data['bill_image'] = this.billImage;
    data['branch_id'] = this.branchId;
    return data;
  }
}

class SalesPerson {
  int? id;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;
  dynamic branchId;

  SalesPerson(
      {this.id,
      this.name,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.branchId});

  SalesPerson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    branchId = json['branch_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['branch_id'] = this.branchId;
    return data;
  }
}

class PaymentTerm {
  int? id;
  String? name;
  String? days;
  String? createdAt;
  String? updatedAt;

  PaymentTerm({this.id, this.name, this.days, this.createdAt, this.updatedAt});

  PaymentTerm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    days = json['days'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['days'] = this.days;
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
  dynamic prevPageUrl;  

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
