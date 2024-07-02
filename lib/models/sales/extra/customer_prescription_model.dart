class CustomerPrescriptionModel {
  String? status;
  String? message;
  List<Data>? data;
  Meta? meta;

  CustomerPrescriptionModel({this.status, this.message, this.data, this.meta});

  CustomerPrescriptionModel.fromJson(Map<String, dynamic> json) {
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
  int? drugId;
  String? drugName;
  String? strength;
  String? dosage;
  String? duration;
  String? durationType;
  int? morning;
  int? afternoon;
  int? night;
  int? beforeFood = 0;
  int? afterFood = 0; 
  String? note;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.customerId,
      this.drugId,
      this.drugName,
      this.strength,
      this.dosage,
      this.duration,
      this.durationType,
      this.morning,
      this.afternoon,
      this.night,
      this.beforeFood = 0, 
      this.afterFood = 0,
      this.note,
      this.createdAt, 
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) { 
    id = json['id'];
    customerId = json['customer_id'];
    drugId = json['drug_id'];
    drugName = json['drug_name'];
    strength = json['strength'];
    dosage = json['dosage'];
    duration = json['duration'];
    durationType = json['duration_type'];
    morning = json['morning'];
    afternoon = json['afternoon'];
    night = json['night'];
    beforeFood = json['before_food'];
    afterFood = json['after_food'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['drug_id'] = this.drugId;
    data['drug_name'] = this.drugName;
    data['strength'] = this.strength;
    data['dosage'] = this.dosage;
    data['duration'] = this.duration;
    data['duration_type'] = this.durationType;
    data['morning'] = this.morning;
    data['afternoon'] = this.afternoon;
    data['night'] = this.night;
    data['before_food'] = this.beforeFood;
    data['after_food'] = this.afterFood;
    data['note'] = this.note;
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
