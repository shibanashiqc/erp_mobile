class AppointmentsModel {
  String? status;
  String? message;
  List<Data>? data;

  AppointmentsModel({this.status, this.message, this.data});

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? start;
  String? doctorName;
  String? branchName;
  String? appointmentTypeName;
  String? phone;
  String? appointmentTime;
  int? salesOrderId;
  String? color;
  String? duration;
  String? isCheckout;
  String? bloodGroup;
  String? age;
  String? dob;

  Data(
      {this.id,
      this.title,
      this.start,
      this.doctorName,
      this.branchName,
      this.appointmentTypeName,
      this.phone,
      this.appointmentTime,
      this.salesOrderId,
      this.color,
      this.duration,
      this.isCheckout,
      this.bloodGroup,
      this.age,
      this.dob});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    start = json['start'];
    doctorName = json['doctor_name'];
    branchName = json['branch_name'];
    appointmentTypeName = json['appointment_type_name'];
    phone = json['phone'];
    appointmentTime = json['appointment_time'];
    salesOrderId = json['sales_order_id'];
    color = json['color'];
    duration = json['duration'];
    isCheckout = json['is_checkout'];
    bloodGroup = json['blood_group'];
    age = json['age'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['start'] = this.start;
    data['doctor_name'] = this.doctorName;
    data['branch_name'] = this.branchName;
    data['appointment_type_name'] = this.appointmentTypeName;
    data['phone'] = this.phone;
    data['appointment_time'] = this.appointmentTime;
    data['sales_order_id'] = this.salesOrderId;
    data['color'] = this.color;
    data['duration'] = this.duration;
    data['is_checkout'] = this.isCheckout;
    data['blood_group'] = this.bloodGroup;
    data['age'] = this.age;
    data['dob'] = this.dob;
    return data;
  }
}
