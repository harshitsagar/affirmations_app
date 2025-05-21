// To parse this JSON data, do
//
//     final journalDetailModel = journalDetailModelFromJson(jsonString);

import 'dart:convert';

JournalDetailModel journalDetailModelFromJson(String str) => JournalDetailModel.fromJson(json.decode(str));

String journalDetailModelToJson(JournalDetailModel data) => json.encode(data.toJson());

class JournalDetailModel {
  int code;
  String message;
  JournalDetailModelData data;
  String format;
  DateTime timestamp;

  JournalDetailModel({
    required this.code,
    required this.message,
    required this.data,
    required this.format,
    required this.timestamp,
  });

  factory JournalDetailModel.fromJson(Map<String, dynamic> json) => JournalDetailModel(
    code: json["code"],
    message: json["message"],
    data: JournalDetailModelData.fromJson(json["data"]),
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

class JournalDetailModelData {
  List<Journal> journals;
  List<Graph> graph;

  JournalDetailModelData({
    required this.journals,
    required this.graph,
  });

  factory JournalDetailModelData.fromJson(Map<String, dynamic> json) => JournalDetailModelData(
    journals: List<Journal>.from(json["journals"].map((x) => Journal.fromJson(x))),
    graph: List<Graph>.from(json["graph"].map((x) => Graph.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "journals": List<dynamic>.from(journals.map((x) => x.toJson())),
    "graph": List<dynamic>.from(graph.map((x) => x.toJson())),
  };
}

class Graph {
  DateTime date;
  String morning;
  String night;
  String morningText;
  String nightText;

  Graph({
    required this.date,
    required this.morning,
    required this.night,
    required this.morningText,
    required this.nightText,
  });

  factory Graph.fromJson(Map<String, dynamic> json) => Graph(
    date: DateTime.parse(json["date"]),
    morning: json["morning"],
    night: json["night"],
    morningText: json["morningText"],
    nightText: json["nightText"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "morning": morning,
    "night": night,
    "morningText": morningText,
    "nightText": nightText,
  };
}

class Journal {
  String id;
  String userRef;
  String text;
  String mood;
  String type;
  DateTime createdOn;
  DateTime updatedOn;
  int v;

  Journal({
    required this.id,
    required this.userRef,
    required this.text,
    required this.mood,
    required this.type,
    required this.createdOn,
    required this.updatedOn,
    required this.v,
  });

  factory Journal.fromJson(Map<String, dynamic> json) => Journal(
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
