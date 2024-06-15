class ProjectChatModel {
  String? status;
  String? message;
  List<Data>? data;
  Meta? meta;

  ProjectChatModel({this.status, this.message, this.data, this.meta});

  ProjectChatModel.fromJson(Map<String, dynamic> json) {
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
  String? message;
  String? attachment;
  int? isRead;
  int? isPinned;
  int? isArchived;
  int? isDeleted;
  int? isStarred;
  int? isMentioned;
  int? isEdited;
  int? isForwarded;
  int? isReplied;
  dynamic replyTo;
  String? createdAt;
  String? updatedAt;
  dynamic vendorId;
  String? sender;
  String? profile;

  Data(
      {this.id,
      this.projectId,
      this.userId,
      this.message,
      this.attachment,
      this.isRead,
      this.isPinned,
      this.isArchived,
      this.isDeleted,
      this.isStarred,
      this.isMentioned,
      this.isEdited,
      this.isForwarded,
      this.isReplied,
      this.replyTo,
      this.createdAt,
      this.updatedAt,
      this.vendorId,
      this.sender,
      this.profile});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    userId = json['user_id'];
    message = json['message'];
    attachment = json['attachment'];
    isRead = json['is_read'];
    isPinned = json['is_pinned'];
    isArchived = json['is_archived'];
    isDeleted = json['is_deleted'];
    isStarred = json['is_starred'];
    isMentioned = json['is_mentioned'];
    isEdited = json['is_edited'];
    isForwarded = json['is_forwarded'];
    isReplied = json['is_replied'];
    replyTo = json['reply_to'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vendorId = json['vendor_id'];
    sender = json['sender'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_id'] = this.projectId;
    data['user_id'] = this.userId;
    data['message'] = this.message;
    data['attachment'] = this.attachment;
    data['is_read'] = this.isRead;
    data['is_pinned'] = this.isPinned;
    data['is_archived'] = this.isArchived;
    data['is_deleted'] = this.isDeleted;
    data['is_starred'] = this.isStarred;
    data['is_mentioned'] = this.isMentioned;
    data['is_edited'] = this.isEdited;
    data['is_forwarded'] = this.isForwarded;
    data['is_replied'] = this.isReplied;
    data['reply_to'] = this.replyTo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['vendor_id'] = this.vendorId;
    data['sender'] = this.sender;
    data['profile'] = this.profile;
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
