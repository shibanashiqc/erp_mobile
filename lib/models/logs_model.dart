class LogModel {
  String? status;
  String? message;
  List<Data>? data;

  LogModel({this.status, this.message, this.data});

  LogModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? username;
  int? userId;
  String? email;
  String? action;
  String? ip;
  String? userAgent;
  String? route;
  String? loggableType;
  int? loggableId;
  String? createdAt;
  String? updatedAt;
  int? vendorId;
  User? user;

  Data(
      {this.id,
      this.username,
      this.userId,
      this.email,
      this.action,
      this.ip,
      this.userAgent,
      this.route,
      this.loggableType,
      this.loggableId,
      this.createdAt,
      this.updatedAt,
      this.vendorId,
      this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    userId = json['user_id'];
    email = json['email'];
    action = json['action'];
    ip = json['ip'];
    userAgent = json['user_agent'];
    route = json['route'];
    loggableType = json['loggable_type'];
    loggableId = json['loggable_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vendorId = json['vendor_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['action'] = this.action;
    data['ip'] = this.ip;
    data['user_agent'] = this.userAgent;
    data['route'] = this.route;
    data['loggable_type'] = this.loggableType;
    data['loggable_id'] = this.loggableId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['vendor_id'] = this.vendorId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  dynamic phone;
  dynamic address;
  dynamic countryId;
  dynamic cityId;
  dynamic postalCode;
  dynamic about;
  String? emailVerifiedAt;
  dynamic twoFactorConfirmedAt;
  dynamic currentTeamId;
  dynamic profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  int? roleId;
  int? status;
  dynamic image;
  dynamic currentBranchId;
  int? vendorId;
  dynamic subscriptionId;
  int? isVendor;
  dynamic foundersName;
  dynamic emailId;
  dynamic mobileNumber;
  dynamic alternateMobileNumber;
  dynamic businessName;
  dynamic businessAddress;
  dynamic businessLicenseNumber;
  dynamic businessType;
  String? profilePhotoUrl;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.countryId,
      this.cityId,
      this.postalCode,
      this.about,
      this.emailVerifiedAt,
      this.twoFactorConfirmedAt,
      this.currentTeamId,
      this.profilePhotoPath,
      this.createdAt,
      this.updatedAt,
      this.roleId,
      this.status,
      this.image,
      this.currentBranchId,
      this.vendorId,
      this.subscriptionId,
      this.isVendor,
      this.foundersName,
      this.emailId,
      this.mobileNumber,
      this.alternateMobileNumber,
      this.businessName,
      this.businessAddress,
      this.businessLicenseNumber,
      this.businessType,
      this.profilePhotoUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    postalCode = json['postal_code'];
    about = json['about'];
    emailVerifiedAt = json['email_verified_at'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roleId = json['role_id'];
    status = json['status'];
    image = json['image'];
    currentBranchId = json['current_branch_id'];
    vendorId = json['vendor_id'];
    subscriptionId = json['subscription_id'];
    isVendor = json['is_vendor'];
    foundersName = json['founders_name'];
    emailId = json['email_id'];
    mobileNumber = json['mobile_number'];
    alternateMobileNumber = json['alternate_mobile_number'];
    businessName = json['business_name'];
    businessAddress = json['business_address'];
    businessLicenseNumber = json['business_license_number'];
    businessType = json['business_type'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    data['postal_code'] = this.postalCode;
    data['about'] = this.about;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['two_factor_confirmed_at'] = this.twoFactorConfirmedAt;
    data['current_team_id'] = this.currentTeamId;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['role_id'] = this.roleId;
    data['status'] = this.status;
    data['image'] = this.image;
    data['current_branch_id'] = this.currentBranchId;
    data['vendor_id'] = this.vendorId;
    data['subscription_id'] = this.subscriptionId;
    data['is_vendor'] = this.isVendor;
    data['founders_name'] = this.foundersName;
    data['email_id'] = this.emailId;
    data['mobile_number'] = this.mobileNumber;
    data['alternate_mobile_number'] = this.alternateMobileNumber;
    data['business_name'] = this.businessName;
    data['business_address'] = this.businessAddress;
    data['business_license_number'] = this.businessLicenseNumber;
    data['business_type'] = this.businessType;
    data['profile_photo_url'] = this.profilePhotoUrl;
    return data;
  }
}
