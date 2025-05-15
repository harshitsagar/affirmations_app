class AffirmationTypesModel {
  int? code;
  String? message;
  List<AffirmationTypesModelData>? data;
  int? page;
  int? limit;
  int? size;
  bool? hasMore;
  String? format;
  String? timestamp;

  AffirmationTypesModel(
      {this.code,
        this.message,
        this.data,
        this.page,
        this.limit,
        this.size,
        this.hasMore,
        this.format,
        this.timestamp});

  AffirmationTypesModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AffirmationTypesModelData>[];
      json['data'].forEach((v) {
        data!.add(new AffirmationTypesModelData.fromJson(v));
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

class AffirmationTypesModelData {
  String? sId;
  String? name;

  AffirmationTypesModelData({this.sId, this.name});

  AffirmationTypesModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}