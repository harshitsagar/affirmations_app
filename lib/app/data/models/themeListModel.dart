class ThemeListModel {
  int? code;
  String? message;
  List<ThemeListModelData>? data;
  int? page;
  int? limit;
  int? size;
  bool? hasMore;
  String? format;
  String? timestamp;

  ThemeListModel(
      {this.code,
        this.message,
        this.data,
        this.page,
        this.limit,
        this.size,
        this.hasMore,
        this.format,
        this.timestamp});

  ThemeListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ThemeListModelData>[];
      json['data'].forEach((v) {
        data!.add(new ThemeListModelData.fromJson(v));
      });
    }
    page = json['page'];
    limit = json['limit'];
    size = json['size'];
    hasMore = json['hasMore'];
    format = json['format'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['size'] = this.size;
    data['hasMore'] = this.hasMore;
    data['format'] = this.format;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class ThemeListModelData {
  String? sId;
  List<String>? backgroundGradient;
  bool? deleted;
  String? name;
  String? primaryColor;
  String? secondaryColor;
  String? aspect;
  String? createdOn;
  String? updatedOn;
  int? iV;

  ThemeListModelData(
      {this.sId,
        this.backgroundGradient,
        this.deleted,
        this.name,
        this.primaryColor,
        this.secondaryColor,
        this.aspect,
        this.createdOn,
        this.updatedOn,
        this.iV});

  ThemeListModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    backgroundGradient = json['backgroundGradient'].cast<String>();
    deleted = json['deleted'];
    name = json['name'];
    primaryColor = json['primaryColor'];
    secondaryColor = json['secondaryColor'];
    aspect = json['aspect'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['backgroundGradient'] = this.backgroundGradient;
    data['deleted'] = this.deleted;
    data['name'] = this.name;
    data['primaryColor'] = this.primaryColor;
    data['secondaryColor'] = this.secondaryColor;
    data['aspect'] = this.aspect;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    data['__v'] = this.iV;
    return data;
  }
}