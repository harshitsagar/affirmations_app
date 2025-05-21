// To parse this JSON data, do
//
//     final addJournalModel = addJournalModelFromJson(jsonString);

import 'dart:convert';

AddJournalModel addJournalModelFromJson(String str) => AddJournalModel.fromJson(json.decode(str));

String addJournalModelToJson(AddJournalModel data) => json.encode(data.toJson());

class AddJournalModel {
  int code;
  String message;
  AddJournalModelData data;
  String format;
  DateTime timestamp;

  AddJournalModel({
    required this.code,
    required this.message,
    required this.data,
    required this.format,
    required this.timestamp,
  });

  factory AddJournalModel.fromJson(Map<String, dynamic> json) => AddJournalModel(
    code: json["code"],
    message: json["message"],
    data: AddJournalModelData.fromJson(json["data"]),
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

class AddJournalModelData {
  String id;
  String userRef;
  String text;
  String mood;
  String type;
  DateTime createdOn;
  DateTime updatedOn;
  int v;

  AddJournalModelData({
    required this.id,
    required this.userRef,
    required this.text,
    required this.mood,
    required this.type,
    required this.createdOn,
    required this.updatedOn,
    required this.v,
  });

  factory AddJournalModelData.fromJson(Map<String, dynamic> json) => AddJournalModelData(
    id: json["_id"],
    userRef: json["userRef"],
    text: json["text"],
    mood: json["mood"],
    type: json["type"],
    createdOn: DateTime.parse(json["createdOn"]),
    updatedOn: DateTime.parse(json["updatedOn"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userRef": userRef,
    "text": text,
    "mood": mood,
    "type": type,
    "createdOn": createdOn.toIso8601String(),
    "updatedOn": updatedOn.toIso8601String(),
    "__v": v,
  };
}
