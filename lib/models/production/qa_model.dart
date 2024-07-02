class QaModel {
  String? status;
  String? message;
  List<Data>? data;
  Meta? meta;

  QaModel({this.status, this.message, this.data, this.meta});

  QaModel.fromJson(Map<String, dynamic> json) {
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
  int? teamId;
  String? name;
  String? description;
  String? status;
  String? priority;
  int? createdBy;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  Null? branchId;
  Null? vendorId;
  String? teamName;
  String? projectName;

  Data(
      {this.id,
      this.projectId,
      this.teamId,
      this.name,
      this.description,
      this.status,
      this.priority,
      this.createdBy,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt,
      this.branchId,
      this.vendorId,
      this.teamName,
      this.projectName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    teamId = json['team_id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    priority = json['priority'];
    createdBy = json['created_by'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    branchId = json['branch_id'];
    vendorId = json['vendor_id'];
    teamName = json['team_name'];
    projectName = json['project_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_id'] = this.projectId;
    data['team_id'] = this.teamId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['priority'] = this.priority;
    data['created_by'] = this.createdBy;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['branch_id'] = this.branchId;
    data['vendor_id'] = this.vendorId;
    data['team_name'] = this.teamName;
    data['project_name'] = this.projectName;
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
