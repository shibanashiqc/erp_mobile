class QaTaskModel {
  String? status;
  String? message;
  List<Data>? data;
  Meta? meta;

  QaTaskModel({this.status, this.message, this.data, this.meta});

  QaTaskModel.fromJson(Map<String, dynamic> json) {
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
  int? qaId;
  int? userId;
  String? name;
  String? description; 
  String? status;
  String? priority;
  int? createdBy;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  dynamic vendorId;
  String? createdByName;
  

  Data(
      {this.id,
      this.qaId,
      this.userId,
      this.name,
      this.description,
      this.status,
      this.priority,
      this.createdBy,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt,
      this.vendorId,
      this.createdByName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qaId = json['qa_id'];
    userId = json['user_id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    priority = json['priority'];
    createdBy = json['created_by'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vendorId = json['vendor_id'];
    createdByName = json['created_by_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qa_id'] = this.qaId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['priority'] = this.priority;
    data['created_by'] = this.createdBy;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['vendor_id'] = this.vendorId;
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
