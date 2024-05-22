class ProductExtraModel {
  String? status;
  String? message;
  Data? data;

  ProductExtraModel({this.status, this.message, this.data});

  ProductExtraModel.fromJson(Map<String, dynamic> json) {
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
  List<ProductTypes>? productTypes;
  List<ProductBrands>? productBrands;
  List<Category>? category;
  List<SubCategory>? subCategory;
  List<Units>? units;
  List<Staffs>? staffs;
  List<InventoryTypes>? inventoryTypes;
  ModeOfReceive? modeOfReceive;

  Data(
      {this.productTypes,
      this.productBrands,
      this.category,
      this.subCategory,
      this.units,
      this.staffs,
      this.inventoryTypes,
      this.modeOfReceive});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['product_types'] != null) {
      productTypes = <ProductTypes>[];
      json['product_types'].forEach((v) {
        productTypes!.add(new ProductTypes.fromJson(v));
      });
    }
    if (json['product_brands'] != null) {
      productBrands = <ProductBrands>[];
      json['product_brands'].forEach((v) {
        productBrands!.add(new ProductBrands.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['sub_category'] != null) {
      subCategory = <SubCategory>[];
      json['sub_category'].forEach((v) {
        subCategory!.add(new SubCategory.fromJson(v));
      });
    }
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units!.add(new Units.fromJson(v));
      });
    }
    if (json['staffs'] != null) {
      staffs = <Staffs>[];
      json['staffs'].forEach((v) {
        staffs!.add(new Staffs.fromJson(v));
      });
    }
    if (json['inventory_types'] != null) {
      inventoryTypes = <InventoryTypes>[];
      json['inventory_types'].forEach((v) {
        inventoryTypes!.add(new InventoryTypes.fromJson(v));
      });
    }
    modeOfReceive = json['mode_of_receive'] != null
        ? new ModeOfReceive.fromJson(json['mode_of_receive'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productTypes != null) {
      data['product_types'] =
          this.productTypes!.map((v) => v.toJson()).toList();
    }
    if (this.productBrands != null) {
      data['product_brands'] =
          this.productBrands!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.subCategory != null) {
      data['sub_category'] = this.subCategory!.map((v) => v.toJson()).toList();
    }
    if (this.units != null) {
      data['units'] = this.units!.map((v) => v.toJson()).toList();
    }
    if (this.staffs != null) {
      data['staffs'] = this.staffs!.map((v) => v.toJson()).toList();
    }
    if (this.inventoryTypes != null) {
      data['inventory_types'] =
          this.inventoryTypes!.map((v) => v.toJson()).toList();
    }
    if (this.modeOfReceive != null) {
      data['mode_of_receive'] = this.modeOfReceive!.toJson();
    }
    return data;
  }
}

class ProductTypes {
  int? id;
  String? name;

  ProductTypes({this.id, this.name});

  ProductTypes.fromJson(Map<String, dynamic> json) {
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

class ModeOfReceive {
  String? courier;
  String? self;
  String? salesPerson;
  String? container;
  String? other;

  ModeOfReceive(
      {this.courier, this.self, this.salesPerson, this.container, this.other});

  ModeOfReceive.fromJson(Map<String, dynamic> json) {
    courier = json['courier'];
    self = json['self'];
    salesPerson = json['sales_person'];
    container = json['container'];
    other = json['other'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courier'] = this.courier;
    data['self'] = this.self;
    data['sales_person'] = this.salesPerson;
    data['container'] = this.container;
    data['other'] = this.other;
    return data;
  }
}

class InventoryTypes {
  int? id;
  String? name;

  InventoryTypes({this.id, this.name});

  InventoryTypes.fromJson(Map<String, dynamic> json) {
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

class Staffs {
  int? id;
  String? name;

  Staffs({this.id, this.name});

  Staffs.fromJson(Map<String, dynamic> json) {
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

class Units {
  int? id;
  String? name;

  Units({this.id, this.name});

  Units.fromJson(Map<String, dynamic> json) {
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

class SubCategory {
  int? id;
  String? name;
  int? categoryId;

  SubCategory({this.id, this.name, this.categoryId});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
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

class ProductBrands {
  int? id;
  String? name;

  ProductBrands({this.id, this.name});

  ProductBrands.fromJson(Map<String, dynamic> json) {
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
