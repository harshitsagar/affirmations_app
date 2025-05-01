import 'dart:convert';

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
  final bool notificationsEnabled;
  final List<int> areasToWork;
  final int? selectedTheme; // Nullable
  final int heardFrom;
  final bool reminderNotification;
  final String name;
  final String email;
  final DateTime createdOn;
  final DateTime updatedOn;
  final int? ageGroup; // Nullable
  final DateTime? dob; // Nullable
  final int? gender; // Nullable
  final JournalInitial? journalInitial; // Nullable
  final JournalReminders? journalReminders; // Nullable
  final String? phoneCode; // Nullable
  final String? phoneNumber; // Nullable

  User({
    required this.id,
    required this.affirmations,
    required this.notificationsEnabled,
    required this.areasToWork,
    this.selectedTheme,
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
    this.phoneCode,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    affirmations: Affirmations.fromJson(json["affirmations"] ?? {}), // Handle null
    notificationsEnabled: json["notificationsEnabled"] ?? false,
    areasToWork: List<int>.from(json["areasToWork"]?.map((x) => x) ?? []),
    selectedTheme: json["selectedTheme"],
    heardFrom: json["heardFrom"] ?? 0,
    reminderNotification: json["reminderNotification"] ?? false,
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    createdOn: DateTime.parse(json["createdOn"]),
    updatedOn: DateTime.parse(json["updatedOn"]),
    ageGroup: json["ageGroup"],
    dob: json["dob"] != null ? DateTime.parse(json["dob"]) : null,
    gender: json["gender"],
    journalInitial: json["journalInitial"] != null
        ? JournalInitial.fromJson(json["journalInitial"])
        : null,
    journalReminders: json["journalReminders"] != null
        ? JournalReminders.fromJson(json["journalReminders"])
        : null,
    phoneCode: json["phoneCode"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "affirmations": affirmations.toJson(),
    "notificationsEnabled": notificationsEnabled,
    "areasToWork": List<dynamic>.from(areasToWork.map((x) => x)),
    "selectedTheme": selectedTheme,
    "heardFrom": heardFrom,
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
    "phoneCode": phoneCode,
    "phoneNumber": phoneNumber,
  };
}

class Affirmations {
  final int countPerDay;
  final String? startTime; // Nullable
  final String? endTime; // Nullable

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