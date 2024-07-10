class ProductsModel {
  String? status;
  String? message;
  List<Data>? data;
  Meta? meta;

  ProductsModel({this.status, this.message, this.data, this.meta});

  ProductsModel.fromJson(Map<String, dynamic> json) {
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
  dynamic totalPrice; 
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
  int qty = 1;
  bool isSelected = false;
  String? barCode;
 
  Data(
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
      this.totalPrice,
      this.createdAt,
      this.updatedAt,
      this.productUnitId,
      this.inventoryTypeId,
      this.expiryDate,
      this.manufacturingDate,
      this.receivedDate,
      this.modeOfReceive,
      this.billImage,
      this.branchId,
      this.qty = 0,
      this.isSelected = false,  
      this.barCode
      });

  Data.fromJson(Map<String, dynamic> json) {
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
    totalPrice = json['total_price'];
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
    qty = json['qty'] ?? 0;  
    barCode = json['bar_code'];               
     
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
    data['total_price'] = this.totalPrice;
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
    data['qty'] = this.qty; 
    data['bar_code'] = this.barCode; 
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
