class PosOrderModel {
  String? status;
  String? message;
  List<Data>? data;
  Meta? meta;

  PosOrderModel({this.status, this.message, this.data, this.meta});

  PosOrderModel.fromJson(Map<String, dynamic> json) {
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
  String? subTotal;
  String? tax;
  String? discount;
  String? grandTotal;
  String? createdAt;
  String? updatedAt;
  String? code;
  int? customerId;
  String? paymentMethod;
  String? name;
  dynamic email;
  String? phone;
  dynamic address;
  dynamic streetAddress;
  dynamic city;
  dynamic state;
  dynamic zip;
  dynamic country;
  dynamic note;
  Customer? customer;
  List<Items>? items;

  Data(
      {this.id,
      this.subTotal,
      this.tax,
      this.discount,
      this.grandTotal,
      this.createdAt,
      this.updatedAt,
      this.code,
      this.customerId,
      this.paymentMethod,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.streetAddress,
      this.city,
      this.state,
      this.zip,
      this.country,
      this.note,
      this.customer,
      this.items});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subTotal = json['sub_total'];
    tax = json['tax'];
    discount = json['discount'];
    grandTotal = json['grand_total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    code = json['code'];
    customerId = json['customer_id'];
    paymentMethod = json['payment_method'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    streetAddress = json['street_address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
    note = json['note'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
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
    data['sub_total'] = this.subTotal;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['grand_total'] = this.grandTotal;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['code'] = this.code;
    data['customer_id'] = this.customerId;
    data['payment_method'] = this.paymentMethod;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['street_address'] = this.streetAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['note'] = this.note;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
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
      this.branchId});

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
    return data;
  }
}

class Items {
  int? id;
  String? name; 
  int? orderId;
  int? productId;
  int? quantity;
  String? price;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Items(
      {this.id,
      this.name,
      this.orderId,
      this.productId,
      this.quantity,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.product});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    orderId = json['order_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name; 
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
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
  String? expiryDate;
  String? manufacturingDate;
  String? receivedDate;
  String? modeOfReceive;
  String? billImage;
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
