class RestoreStreakModel {
  RestoreStreakModel({
    required this.code,
    required this.message,
    required this.data,
    required this.format,
    required this.timestamp,
  });

  final int? code;
  final String? message;
  final RestoreStreakModelData? data;
  final String? format;
  final DateTime? timestamp;

  factory RestoreStreakModel.fromJson(Map<String, dynamic> json){
    return RestoreStreakModel(
      code: json["code"],
      message: json["message"],
      data: json["data"] == null ? null : RestoreStreakModelData.fromJson(json["data"]),
      format: json["format"],
      timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
    );
  }

}

class RestoreStreakModelData {
  RestoreStreakModelData({
    required this.goalCompleted,
    required this.streakFreeze,
    required this.streakRestore,
    required this.streakBroken,
    required this.streakCount,
    required this.categoryShown,
    required this.categoryRemaining,
    required this.id,
    required this.userRef,
    required this.createdOn,
    required this.updatedOn,
    required this.v,
  });

  final bool? goalCompleted;
  final bool? streakFreeze;
  final bool? streakRestore;
  final bool? streakBroken;
  final int? streakCount;
  final List<dynamic> categoryShown;
  final List<dynamic> categoryRemaining;
  final String? id;
  final String? userRef;
  final DateTime? createdOn;
  final DateTime? updatedOn;
  final int? v;

  factory RestoreStreakModelData.fromJson(Map<String, dynamic> json){
    return RestoreStreakModelData(
      goalCompleted: json["goalCompleted"],
      streakFreeze: json["streakFreeze"],
      streakRestore: json["streakRestore"],
      streakBroken: json["streakBroken"],
      streakCount: json["streakCount"],
      categoryShown: json["categoryShown"] == null ? [] : List<dynamic>.from(json["categoryShown"]!.map((x) => x)),
      categoryRemaining: json["categoryRemaining"] == null ? [] : List<dynamic>.from(json["categoryRemaining"]!.map((x) => x)),
      id: json["_id"],
      userRef: json["userRef"],
      createdOn: DateTime.tryParse(json["createdOn"] ?? ""),
      updatedOn: DateTime.tryParse(json["updatedOn"] ?? ""),
      v: json["__v"],
    );
  }

}
