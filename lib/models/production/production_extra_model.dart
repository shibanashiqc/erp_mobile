class ProductionExtraModel {
  String? status;
  String? message;
  Data? data;

  ProductionExtraModel({this.status, this.message, this.data});

  ProductionExtraModel.fromJson(Map<String, dynamic> json) {
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
  List<User>? users;
  List<Teams>? teams;
  List<Clients>? clients;
  List<Staffs>? staffs;

  Data({this.teams, this.clients});

  Data.fromJson(Map<String, dynamic> json) {
    
    
    if (json['users'] != null) {
      users = <User>[];
      json['users'].forEach((v) {
        users!.add(new User.fromJson(v));
      });
    }
    
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(new Teams.fromJson(v));
      });
    }
    if (json['clients'] != null) {
      clients = <Clients>[];
      json['clients'].forEach((v) {
        clients!.add(new Clients.fromJson(v));
      });
    }
    
    if (json['staffs'] != null) {
      staffs = <Staffs>[];
      json['staffs'].forEach((v) {
        staffs!.add(new Staffs.fromJson(v));
      });
    }
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    
    if (this.teams != null) {
      data['teams'] = this.teams!.map((v) => v.toJson()).toList();
    }
    if (this.clients != null) {
      data['clients'] = this.clients!.map((v) => v.toJson()).toList();
    }
    
    if (this.staffs != null) {
      data['staffs'] = this.staffs!.map((v) => v.toJson()).toList();
    }
    
    return data;
  }
}

class Staffs {
  int? id;
  String? name;
  String? email;

  Staffs(
      {this.id,
      this.name,
      this.email,
      });

  Staffs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}


class User {
  int? id;
  String? name;
  String? profilePhotoUrl;
  
  User({this.id, this.name, this.profilePhotoUrl});
  
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePhotoUrl = json['profile_photo_url'];
    
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_photo_url'] = this.profilePhotoUrl;
    
    return data;
  }
}

class Teams {
  int? id;
  int? userId;
  String? name;
  int? personalTeam;
  String? createdAt;
  String? updatedAt;
 dynamic branchId;
 dynamic vendorId;
  List<Users>? users;

  Teams(
      {this.id,
      this.userId,
      this.name,
      this.personalTeam,
      this.createdAt,
      this.updatedAt,
      this.branchId,
      this.vendorId,
      this.users});

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    personalTeam = json['personal_team'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    branchId = json['branch_id'];
    vendorId = json['vendor_id'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['personal_team'] = this.personalTeam;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['branch_id'] = this.branchId;
    data['vendor_id'] = this.vendorId;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  int? teamId;
  int? userId;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? isLeader;
 dynamic vendorId;

  Users(
      {this.id,
      this.teamId,
      this.userId,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.isLeader,
      this.vendorId});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    userId = json['user_id'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isLeader = json['is_leader'];
    vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['team_id'] = this.teamId;
    data['user_id'] = this.userId;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_leader'] = this.isLeader;
    data['vendor_id'] = this.vendorId;
    return data;
  }
}

class Clients {
  int? id;
  String? name;
  String? email;
  String? address;
  String? phone;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? countryId;
  dynamic branchId;
  dynamic vendorId;

  Clients(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.phone,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.countryId,
      this.branchId,
      this.vendorId});

  Clients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    countryId = json['country_id'];
    branchId = json['branch_id'];
    vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['country_id'] = this.countryId;
    data['branch_id'] = this.branchId;
    data['vendor_id'] = this.vendorId;
    return data;
  }
}
