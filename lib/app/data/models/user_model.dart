import 'dart:convert';

import 'package:affirmations_app/app/helpers/services/themeServices.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int code;
  final String message;
  final UserData data;
  final String format;
  final DateTime timestamp;

  UserModel({
    required this.code,
    required this.message,
    required this.data,
    required this.format,
    required this.timestamp,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    code: json["code"],
    message: json["message"],
    data: UserData.fromJson(json["data"]),
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

class UserData {
  final String accessToken;
  final User user;

  UserData({
    required this.accessToken,
    required this.user,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    accessToken: json["accessToken"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "user": user.toJson(),
  };
}

class User {
  final String id;
  final Affirmations affirmations;
  final List<String> areasToWork;
  final List<int> heardFrom;
  final bool reminderNotification;
  final String name;
  final String email;
  final DateTime createdOn;
  final DateTime updatedOn;
  final int? ageGroup;
  final DateTime? dob;
  final int? gender;
  final JournalInitial? journalInitial;
  final JournalReminders? journalReminders;
  final String subscriptionStatus;
  final Streak streak;
  Theme theme;

  User({
    required this.id,
    required this.affirmations,
    required this.areasToWork,
    required this.heardFrom,
    required this.reminderNotification,
    required this.name,
    required this.email,
    required this.createdOn,
    required this.updatedOn,
    this.ageGroup,
    this.dob,
    this.gender,
    this.journalInitial,
    this.journalReminders,
    required this.subscriptionStatus,
    required this.streak,
    required this.theme,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"] ?? "",
    affirmations: Affirmations.fromJson(json["affirmations"] ?? {}),
    areasToWork: List<String>.from(json["areasToWork"]?.map((x) => x) ?? []),
    heardFrom: List<int>.from(json["heardFrom"]?.map((x) => x) ?? []),
    reminderNotification: json["reminderNotification"] ?? false,
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    createdOn: DateTime.parse(json["createdOn"] ?? DateTime.now().toIso8601String()),
    updatedOn: DateTime.parse(json["updatedOn"] ?? DateTime.now().toIso8601String()),
    ageGroup: json["ageGroup"],
    dob: json["dob"] != null ? DateTime.parse(json["dob"]) : null,
    gender: json["gender"],
    journalInitial: json["journalInitial"] != null
        ? JournalInitial.fromJson(json["journalInitial"])
        : null,
    journalReminders: json["journalReminders"] != null
        ? JournalReminders.fromJson(json["journalReminders"])
        : null,
    subscriptionStatus: json["subscriptionStatus"]?.toString().toLowerCase() ?? "inactive",
    streak: Streak.fromJson(json["streak"] ?? {}),
    theme: json["theme"] != null
        ? Theme.fromJson(json["theme"])
        : Theme(
      id: ThemeService.getDefaultTheme().sId!,
      backgroundGradient: ThemeService.getDefaultTheme().backgroundGradient!,
      deleted: ThemeService.getDefaultTheme().deleted ?? false,
      name: ThemeService.getDefaultTheme().name!,
      primaryColor: ThemeService.getDefaultTheme().primaryColor!,
      secondaryColor: ThemeService.getDefaultTheme().secondaryColor!,
      aspect: ThemeService.getDefaultTheme().aspect!,
      createdOn: DateTime.now(),
      updatedOn: DateTime.now(),
      v: 0,
    ),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "affirmations": affirmations.toJson(),
    "areasToWork": List<dynamic>.from(areasToWork.map((x) => x)),
    "heardFrom": List<dynamic>.from(heardFrom.map((x) => x)),
    "reminderNotification": reminderNotification,
    "name": name,
    "email": email,
    "createdOn": createdOn.toIso8601String(),
    "updatedOn": updatedOn.toIso8601String(),
    "ageGroup": ageGroup,
    "dob": dob?.toIso8601String(),
    "gender": gender,
    "journalInitial": journalInitial?.toJson(),
    "journalReminders": journalReminders?.toJson(),
    "subscriptionStatus": subscriptionStatus,
    "streak": streak.toJson(),
    "theme": theme.toJson(),
  };

  bool get isPremium => subscriptionStatus == "active";
  Theme? get currentTheme => theme;

}

class Affirmations {
  final int countPerDay;
  final String? startTime;
  final String? endTime;

  Affirmations({
    required this.countPerDay,
    this.startTime,
    this.endTime,
  });

  factory Affirmations.fromJson(Map<String, dynamic> json) => Affirmations(
    countPerDay: json["countPerDay"] ?? 0,
    startTime: json["startTime"],
    endTime: json["endTime"],
  );

  Map<String, dynamic> toJson() => {
    "countPerDay": countPerDay,
    "startTime": startTime,
    "endTime": endTime,
  };
}

class JournalInitial {
  final int question;
  final String answer;

  JournalInitial({
    required this.question,
    required this.answer,
  });

  factory JournalInitial.fromJson(Map<String, dynamic> json) => JournalInitial(
    question: json["question"] ?? 0,
    answer: json["answer"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
  };
}

class JournalReminders {
  final String startTime;
  final String endTime;

  JournalReminders({
    required this.startTime,
    required this.endTime,
  });

  factory JournalReminders.fromJson(Map<String, dynamic> json) =>
      JournalReminders(
        startTime: json["startTime"] ?? "",
        endTime: json["endTime"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "startTime": startTime,
    "endTime": endTime,
  };
}

class Streak {
  final int status;
  final int current;
  final int longest;
  final bool broken;
  final Restore restore;
  final Freeze freeze;

  Streak({
    required this.status,
    required this.current,
    required this.longest,
    required this.broken,
    required this.restore,
    required this.freeze,
  });

  factory Streak.fromJson(Map<String, dynamic> json) => Streak(
    status: json["status"] ?? 0,
    current: json["current"] ?? 0,
    longest: json["longest"] ?? 0,
    broken: json["broken"] ?? false,
    restore: Restore.fromJson(json["restore"] ?? {}),
    freeze: Freeze.fromJson(json["freeze"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "current": current,
    "longest": longest,
    "broken": broken,
    "restore": restore.toJson(),
    "freeze": freeze.toJson(),
  };
}

class Restore {
  final int totalAvailable;

  Restore({
    required this.totalAvailable,
  });

  factory Restore.fromJson(Map<String, dynamic> json) => Restore(
    totalAvailable: json["totalAvailable"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "totalAvailable": totalAvailable,
  };
}

class Freeze {
  final int totalAvailable;

  Freeze({
    required this.totalAvailable,
  });

  factory Freeze.fromJson(Map<String, dynamic> json) => Freeze(
    totalAvailable: json["totalAvailable"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "totalAvailable": totalAvailable,
  };
}

class Theme {
  final String id;
  final List<String> backgroundGradient;
  final bool deleted;
  final String name;
  final String primaryColor;
  final String secondaryColor;
  final String aspect;
  final DateTime createdOn;
  final DateTime updatedOn;
  final int v;

  Theme({
    required this.id,
    required this.backgroundGradient,
    required this.deleted,
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.aspect,
    required this.createdOn,
    required this.updatedOn,
    required this.v,
  });

  factory Theme.fromJson(Map<String, dynamic> json) => Theme(
    id: json["_id"] ?? "",
    backgroundGradient:
    List<String>.from(json["backgroundGradient"]?.map((x) => x) ?? []),
    deleted: json["deleted"] ?? false,
    name: json["name"] ?? "",
    primaryColor: json["primaryColor"] ?? "",
    secondaryColor: json["secondaryColor"] ?? "",
    aspect: json["aspect"] ?? "",
    createdOn: DateTime.parse(json["createdOn"]),
    updatedOn: DateTime.parse(json["updatedOn"]),
    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "backgroundGradient":
    List<dynamic>.from(backgroundGradient.map((x) => x)),
    "deleted": deleted,
    "name": name,
    "primaryColor": primaryColor,
    "secondaryColor": secondaryColor,
    "aspect": aspect,
    "createdOn": createdOn.toIso8601String(),
    "updatedOn": updatedOn.toIso8601String(),
    "__v": v,
  };
}