class HrExtraDataModel {
  String? status;
  String? message;
  Data? data;

  HrExtraDataModel({this.status, this.message, this.data});

  HrExtraDataModel.fromJson(Map<String, dynamic> json) {
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
  List<Roles>? roles;
  List<Departments>? departments;
  List<Designations>? designations;
  List<EmployeeTypes>? employeeTypes;
  List<Branches>? branches;
  List<Warehouses>? warehouses;
  List<Modules>? modules;

  Data(
      {this.roles,
      this.departments,
      this.designations,
      this.employeeTypes,
      this.branches,
      this.warehouses,
      this.modules});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    if (json['departments'] != null) {
      departments = <Departments>[];
      json['departments'].forEach((v) {
        departments!.add(new Departments.fromJson(v));
      });
    }
    if (json['designations'] != null) {
      designations = <Designations>[];
      json['designations'].forEach((v) {
        designations!.add(new Designations.fromJson(v));
      });
    }
    if (json['employee_types'] != null) {
      employeeTypes = <EmployeeTypes>[];
      json['employee_types'].forEach((v) {
        employeeTypes!.add(new EmployeeTypes.fromJson(v));
      });
    }
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(new Branches.fromJson(v));
      });
    }
    if (json['warehouses'] != null) {
      warehouses = <Warehouses>[];
      json['warehouses'].forEach((v) {
        warehouses!.add(new Warehouses.fromJson(v));
      });
    }
    if (json['modules'] != null) {
      modules = <Modules>[];
      json['modules'].forEach((v) {
        modules!.add(new Modules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    if (this.departments != null) {
      data['departments'] = this.departments!.map((v) => v.toJson()).toList();
    }
    if (this.designations != null) {
      data['designations'] = this.designations!.map((v) => v.toJson()).toList();
    }
    if (this.employeeTypes != null) {
      data['employee_types'] =
          this.employeeTypes!.map((v) => v.toJson()).toList();
    }
    if (this.branches != null) {
      data['branches'] = this.branches!.map((v) => v.toJson()).toList();
    }
    if (this.warehouses != null) {
      data['warehouses'] = this.warehouses!.map((v) => v.toJson()).toList();
    }
    if (this.modules != null) {
      data['modules'] = this.modules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Roles({this.id, this.name, this.createdAt, this.updatedAt});

  Roles.fromJson(Map<String, dynamic> json) {
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

class Departments {
  int? id;
  String? name;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;

  Departments(
      {this.id,
      this.name,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  Departments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Designations {
  int? id;
  int? departmentId;
  String? name;
  int? status;
  String? createdAt;
  String? updatedAt;

  Designations(
      {this.id,
      this.departmentId,
      this.name,
      this.status,
      this.createdAt,
      this.updatedAt});

  Designations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentId = json['department_id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['department_id'] = this.departmentId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Branches {
  int? id;
  String? name;
  String? address;
  int? status;
  String? createdAt;
  String? updatedAt;

  Branches(
      {this.id,
      this.name,
      this.address,
      this.status,
      this.createdAt,
      this.updatedAt});

  Branches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Modules {
  int? id;
  String? name;
  String? slug;
  String? icon;
  String? route;
  int? isActive;
  int? notRoute;
  String? createdAt;
  String? updatedAt;
  int? position;
  List<Items>? items;

  Modules(
      {this.id,
      this.name,
      this.slug,
      this.icon,
      this.route,
      this.isActive,
      this.notRoute,
      this.createdAt,
      this.updatedAt,
      this.position,
      this.items});

  Modules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    route = json['route'];
    isActive = json['is_active'];
    notRoute = json['not_route'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    position = json['position'];
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
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['icon'] = this.icon;
    data['route'] = this.route;
    data['is_active'] = this.isActive;
    data['not_route'] = this.notRoute;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['position'] = this.position;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  int? moduleId;
  String? name;
  String? slug;
  String? route;
  String? createdAt;
  String? updatedAt;
  int? isHidden;
  int? position;

  Items(
      {this.id,
      this.moduleId,
      this.name,
      this.slug,
      this.route,
      this.createdAt,
      this.updatedAt,
      this.isHidden,
      this.position});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleId = json['module_id'];
    name = json['name'];
    slug = json['slug'];
    route = json['route'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isHidden = json['is_hidden'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['module_id'] = this.moduleId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['route'] = this.route;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_hidden'] = this.isHidden;
    data['position'] = this.position;
    return data;
  }
}

class EmployeeTypes {
  int? id;
  String? name;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;

  EmployeeTypes(
      {this.id,
      this.name,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  EmployeeTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Warehouses {
  int? id;
  String? name;
  String? address;
  int? status;
  String? createdAt;
  String? updatedAt;

  Warehouses(
      {this.id,
      this.name,
      this.address,
      this.status,
      this.createdAt,
      this.updatedAt});

  Warehouses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
} 
