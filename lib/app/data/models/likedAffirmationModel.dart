class LikedAffirmationModel {
  int? code;
  String? message;
  LikedAffirmationModelData? data;
  String? format;
  String? timestamp;

  LikedAffirmationModel(
      {this.code, this.message, this.data, this.format, this.timestamp});

  LikedAffirmationModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new LikedAffirmationModelData.fromJson(json['data']) : null;
    format = json['format'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['format'] = this.format;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class LikedAffirmationModelData {
  bool? deleted;
  bool? isLiked;
  String? sId;
  String? affirmationRef;
  String? userRef;
  int? iV;
  String? createdOn;
  String? updatedOn;

  LikedAffirmationModelData(
      {this.deleted,
        this.isLiked,
        this.sId,
        this.affirmationRef,
        this.userRef,
        this.iV,
        this.createdOn,
        this.updatedOn});

  LikedAffirmationModelData.fromJson(Map<String, dynamic> json) {
    deleted = json['deleted'];
    isLiked = json['isLiked'];
    sId = json['_id'];
    affirmationRef = json['affirmationRef'];
    userRef = json['userRef'];
    iV = json['__v'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deleted'] = this.deleted;
    data['isLiked'] = this.isLiked;
    data['_id'] = this.sId;
    data['affirmationRef'] = this.affirmationRef;
    data['userRef'] = this.userRef;
    data['__v'] = this.iV;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    return data;
  }
}