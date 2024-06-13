class ProjectsModel {
  String? status;
  String? message;
  List<Data>? data;
  Meta? meta;

  ProjectsModel({this.status, this.message, this.data, this.meta});

  ProjectsModel.fromJson(Map<String, dynamic> json) {
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
  int? clientId;
  int? teamId;
  String? name;
  String? projectCode;
  String? tags;
  String? description;
  String? status;
  String? progress;
  String? startDate;
  String? deadline;
  String? budget;
  String? createdAt;
  String? updatedAt;
  dynamic branchId;
  dynamic vendorId;
  String? teamName;
  String? clientName;
  int? tasksCount;

  Data(
      {this.id,
      this.clientId,
      this.teamId,
      this.name,
      this.projectCode,
      this.tags,
      this.description,
      this.status,
      this.progress,
      this.startDate,
      this.deadline,
      this.budget,
      this.createdAt,
      this.updatedAt,
      this.branchId,
      this.vendorId,
      this.teamName,
      this.clientName,
      this.tasksCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    teamId = json['team_id'];
    name = json['name'];
    projectCode = json['project_code'];
    tags = json['tags'];
    description = json['description'];
    status = json['status'];
    progress = json['progress'];
    startDate = json['start_date'];
    deadline = json['deadline'];
    budget = json['budget'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    branchId = json['branch_id'];
    vendorId = json['vendor_id'];
    teamName = json['team_name'];
    clientName = json['client_name'];
    tasksCount = json['tasks_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['team_id'] = this.teamId;
    data['name'] = this.name;
    data['project_code'] = this.projectCode;
    data['tags'] = this.tags;
    data['description'] = this.description;
    data['status'] = this.status;
    data['progress'] = this.progress;
    data['start_date'] = this.startDate;
    data['deadline'] = this.deadline;
    data['budget'] = this.budget;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['branch_id'] = this.branchId;
    data['vendor_id'] = this.vendorId;
    data['team_name'] = this.teamName;
    data['client_name'] = this.clientName;
    data['tasks_count'] = this.tasksCount;
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
