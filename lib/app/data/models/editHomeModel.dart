class EditHomeModel {
  EditHomeModel({
    required this.code,
    required this.message,
    required this.data,
    required this.format,
    required this.timestamp,
  });

  final int code;
  final String message;
  final EditHomeModelData data;
  final String format;
  final DateTime timestamp;

  factory EditHomeModel.fromJson(Map<String, dynamic> json) {
    return EditHomeModel(
      code: json["code"] as int,
      message: json["message"] as String,
      data: EditHomeModelData.fromJson(json["data"]),
      format: json["format"] as String,
      timestamp: DateTime.parse(json["timestamp"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data.toJson(),
    "format": format,
    "timestamp": timestamp.toIso8601String(),
  };
}

class EditHomeModelData {
  EditHomeModelData({
    this.goalCompleted = false,
    this.streakFreeze = false,
    this.streakRestore = false,
    this.streakBroken = false,
    this.streakCount = 0,
    this.categoryShown = const [],
    this.categoryRemaining = const [],
    this.affirmationShown = const [],
    this.affirmationSeen = 0,
    required this.id,
    required this.userRef,
    required this.createdOn,
    required this.updatedOn,
    this.v = 0,
  });

  final bool goalCompleted;
  final bool streakFreeze;
  final bool streakRestore;
  final bool streakBroken;
  final int streakCount;
  final List<String> categoryShown;
  final List<String> categoryRemaining;
  final List<String> affirmationShown;
  final int affirmationSeen;
  final String id;
  final String userRef;
  final DateTime createdOn;
  final DateTime updatedOn;
  final int v;

  factory EditHomeModelData.fromJson(Map<String, dynamic> json) {
    return EditHomeModelData(
      goalCompleted: json["goalCompleted"] as bool? ?? false,
      streakFreeze: json["streakFreeze"] as bool? ?? false,
      streakRestore: json["streakRestore"] as bool? ?? false,
      streakBroken: json["streakBroken"] as bool? ?? false,
      streakCount: json["streakCount"] as int? ?? 0,
      categoryShown: List<String>.from(json["categoryShown"]?.map((x) => x?.toString() ?? "") ?? []),
      categoryRemaining: List<String>.from(json["categoryRemaining"]?.map((x) => x?.toString() ?? "") ?? []),
      affirmationShown: List<String>.from(json["affirmationShown"]?.map((x) => x?.toString() ?? "") ?? []),
      affirmationSeen: json["affirmationSeen"] as int? ?? 0,
      id: json["_id"] as String? ?? "",
      userRef: json["userRef"] as String? ?? "",
      createdOn: DateTime.parse(json["createdOn"]?.toString() ?? DateTime.now().toIso8601String()),
      updatedOn: DateTime.parse(json["updatedOn"]?.toString() ?? DateTime.now().toIso8601String()),
      v: json["__v"] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "goalCompleted": this.goalCompleted,
    "streakFreeze": this.streakFreeze,
    "streakRestore": this.streakRestore,
    "streakBroken": this.streakBroken,
    "streakCount": this.streakCount,
    "categoryShown": List<dynamic>.from(this.categoryShown.map((x) => x)),
    "categoryRemaining": List<dynamic>.from(this.categoryRemaining.map((x) => x)),
    "affirmationShown": List<dynamic>.from(this.affirmationShown.map((x) => x)),
    "affirmationSeen": this.affirmationSeen,
    "_id": this.id,
    "userRef": this.userRef,
    "createdOn": this.createdOn.toIso8601String(),
    "updatedOn": this.updatedOn.toIso8601String(),
    "__v": this.v,
  };
}