class CustomerAppointmentModel {
  String? status;
  String? message;
  Data? data;

  CustomerAppointmentModel({this.status, this.message, this.data});

  CustomerAppointmentModel.fromJson(Map<String, dynamic> json) {
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
  int? totalAppointments;
  int? completedAppointments;
  int? uncomfirmedAppointments;
  int? comfirmedAppointments;

  Data(
      {this.totalAppointments,
      this.completedAppointments,
      this.uncomfirmedAppointments,
      this.comfirmedAppointments});

  Data.fromJson(Map<String, dynamic> json) {
    totalAppointments = json['total_appointments'];
    completedAppointments = json['completed_appointments'];
    uncomfirmedAppointments = json['uncomfirmed_appointments'];
    comfirmedAppointments = json['comfirmed_appointments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_appointments'] = this.totalAppointments;
    data['completed_appointments'] = this.completedAppointments;
    data['uncomfirmed_appointments'] = this.uncomfirmedAppointments;
    data['comfirmed_appointments'] = this.comfirmedAppointments;
    return data;
  }
}
