class ProjectTaskModel {
  String? status;
  String? message;
  List<Data>? data;
  Meta? meta;

  ProjectTaskModel({this.status, this.message, this.data, this.meta});

  ProjectTaskModel.fromJson(Map<String, dynamic> json) {
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
  int? projectId;
  int? userId;
  String? name;
  String? description;
  String? status;
  String? priority;
  String? startDate;
  String? deadline;
  String? completionDate;
  String? createdAt;
  String? updatedAt;
  dynamic vendorId;
  String? createdByName;


  Data(
      {this.id,
      this.projectId,
      this.userId,
      this.name,
      this.description,
      this.status,
      this.priority,
      this.startDate,
      this.deadline,
      this.completionDate,
      this.createdAt,
      this.updatedAt,
      this.vendorId, 
      this.createdByName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    userId = json['user_id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    priority = json['priority'];
    startDate = json['start_date'];
    deadline = json['deadline'];
    completionDate = json['completion_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vendorId = json['vendor_id'];
    createdByName = json['created_by_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_id'] = this.projectId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['priority'] = this.priority;
    data['start_date'] = this.startDate;
    data['deadline'] = this.deadline;
    data['completion_date'] = this.completionDate;
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
