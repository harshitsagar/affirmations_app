

import 'dart:convert';

AffirmationListModel affirmationListModelFromJson(String str) => AffirmationListModel.fromJson(json.decode(str));

String affirmationListModelToJson(AffirmationListModel data) => json.encode(data.toJson());

class AffirmationListModel {
  int code;
  String message;
  List<AffirmationListModelData> data;
  int page;
  int limit;
  int size;
  bool hasMore;
  String format;
  DateTime timestamp;

  AffirmationListModel({
    required this.code,
    required this.message,
    required this.data,
    required this.page,
    required this.limit,
    required this.size,
    required this.hasMore,
    required this.format,
    required this.timestamp,
  });

  factory AffirmationListModel.fromJson(Map<String, dynamic> json) => AffirmationListModel(
    code: json["code"],
    message: json["message"],
    data: List<AffirmationListModelData>.from(json["data"].map((x) => AffirmationListModelData.fromJson(x))),
    page: json["page"],
    limit: json["limit"],
    size: json["size"],
    hasMore: json["hasMore"],
    format: json["format"],
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "page": page,
    "limit": limit,
    "size": size,
    "hasMore": hasMore,
    "format": format,
    "timestamp": timestamp.toIso8601String(),
  };
}

class AffirmationListModelData {
  String id;
  String name;
  List<dynamic> affirmations;
  int totalAffirmation;
  DateTime createdOn;

  AffirmationListModelData({
    required this.id,
    required this.name,
    required this.affirmations,
    required this.totalAffirmation,
    required this.createdOn,
  });

  factory AffirmationListModelData.fromJson(Map<String, dynamic> json) => AffirmationListModelData(
    id: json["_id"],
    name: json["name"],
    affirmations: List<dynamic>.from(json["affirmations"].map((x) => x)),
    totalAffirmation: json["totalAffirmation"],
    createdOn: DateTime.parse(json["createdOn"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "affirmations": List<dynamic>.from(affirmations.map((x) => x)),
    "totalAffirmation": totalAffirmation,
    "createdOn": createdOn.toIso8601String(),
  };
}
