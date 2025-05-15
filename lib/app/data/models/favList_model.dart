class FavoriteListModel {
  int? code;
  String? message;
  List<Data>? data;
  int? page;
  int? limit;
  int? size;
  bool? hasMore;
  String? format;
  String? timestamp;

  FavoriteListModel(
      {this.code,
        this.message,
        this.data,
        this.page,
        this.limit,
        this.size,
        this.hasMore,
        this.format,
        this.timestamp});

  FavoriteListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? sId;
  String? name;
  bool? isLiked;

  Data({this.sId, this.name, this.isLiked});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    isLiked = json['isLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['isLiked'] = this.isLiked;
    return data;
  }
}