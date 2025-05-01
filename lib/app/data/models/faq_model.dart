import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  FaqModel({
    required this.code,
    required this.message,
    required this.data,
    required this.format,
    required this.timestamp,
  });

  int code;
  String message;
  Data data;
  String format;
  DateTime timestamp;

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        format: json["format"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
        "format": format,
        "timestamp": timestamp.toIso8601String(),
      };
}

class Data {
  Data({
    required this.list,
    required this.total,
    required this.page,
    required this.limit,
    required this.size,
    required this.hasMore,
  });

  List<FAQData> list;
  int total;
  int page;
  int limit;
  int size;
  bool hasMore;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: List<FAQData>.from(json["list"].map((x) => FAQData.fromJson(x))),
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
        size: json["size"],
        hasMore: json["hasMore"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "total": total,
        "page": page,
        "limit": limit,
        "size": size,
        "hasMore": hasMore,
      };
}

class FAQData {
  FAQData({
    required this.id,
    required this.question,
    required this.answer,
    required this.deleted,
    required this.createdOn,
    required this.updatedOn,
  });

  String id;
  String question;
  String answer;
  bool deleted;
  DateTime createdOn;
  DateTime updatedOn;

  factory FAQData.fromJson(Map<String, dynamic> json) => FAQData(
        id: json["_id"],
        question: json["question"],
        answer: json["answer"],
        deleted: json["deleted"],
        createdOn: DateTime.parse(json["createdOn"]),
        updatedOn: DateTime.parse(json["updatedOn"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "question": question,
        "answer": answer,
        "deleted": deleted,
        "createdOn": createdOn.toIso8601String(),
        "updatedOn": updatedOn.toIso8601String(),
      };
}
