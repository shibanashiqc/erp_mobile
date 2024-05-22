class AppointmentExtraModel {
  String? status;
  String? message;
  Data? data;

  AppointmentExtraModel({this.status, this.message, this.data});

  AppointmentExtraModel.fromJson(Map<String, dynamic> json) {
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
  List<Doctors>? doctors;
  List<Branches>? branches;
  List<AppointmentTypes>? appointmentTypes;
  List<Customers>? customers;

  Data({this.doctors, this.branches, this.appointmentTypes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['doctors'] != null) {
      doctors = <Doctors>[];
      json['doctors'].forEach((v) {
        doctors!.add(new Doctors.fromJson(v));
      });
    }
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(new Branches.fromJson(v));
      });
    }
    if (json['appointment_types'] != null) {
      appointmentTypes = <AppointmentTypes>[];
      json['appointment_types'].forEach((v) {
        appointmentTypes!.add(new AppointmentTypes.fromJson(v));
      });
    }
    if (json['customers'] != null) {
      customers = <Customers>[];
      json['customers'].forEach((v) {
        customers!.add(new Customers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctors != null) {
      data['doctors'] = this.doctors!.map((v) => v.toJson()).toList();
    }
    if (this.branches != null) {
      data['branches'] = this.branches!.map((v) => v.toJson()).toList();
    }
    if (this.appointmentTypes != null) {
      data['appointment_types'] =
          this.appointmentTypes!.map((v) => v.toJson()).toList();
    }
    
    if (this.customers != null) {
      data['customers'] = this.customers!.map((v) => v.toJson()).toList();
    }
    
    return data;
  }
}

class Doctors {
  int? id;
  String? name;

  Doctors({this.id, this.name});

  Doctors.fromJson(Map<String, dynamic> json) {
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

class Branches {
  int? id;
  String? name;
  Null? color;

  Branches({this.id, this.name, this.color});

  Branches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    return data;
  }
}

class AppointmentTypes {
  int? id;
  String? name;

  AppointmentTypes({this.id, this.name});

  AppointmentTypes.fromJson(Map<String, dynamic> json) {
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

class Customers {
  int? id;
  String? name;
  String? email;
  dynamic phone;

  Customers({this.id, this.name, this.email, this.phone});

  Customers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}