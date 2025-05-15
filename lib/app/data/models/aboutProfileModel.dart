// Setup / AboutProfileModel.dart
class AboutProfileModel {
  final int? code;
  final String? message;
  final UserProfileData? data;
  final String? format;
  final String? timestamp;

  AboutProfileModel({
    this.code,
    this.message,
    this.data,
    this.format,
    this.timestamp,
  });

  factory AboutProfileModel.fromJson(Map<String, dynamic> json) {
    return AboutProfileModel(
      code: json['code'],
      message: json['message'],
      data: json['data'] != null ? UserProfileData.fromJson(json['data']) : null,
      format: json['format'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['format'] = format;
    data['timestamp'] = timestamp;
    return data;
  }
}

class UserProfileData {
  final String? id;
  final Affirmations? affirmations;
  final bool? notificationsEnabled;
  final List<String>? areasToWork;
  final String? selectedTheme;
  final List<int> heardFrom;
  final bool? reminderNotification;
  final String? name;
  final String? email;
  final String? createdOn;
  final String? updatedOn;
  final int? ageGroup;
  final String? dob;
  final int? gender;
  final JournalInitial? journalInitial;
  final JournalReminders? journalReminders;
  final String? phoneCode;
  final String? phoneNumber;
  final String? subscriptionStatus;

  UserProfileData({
    this.id,
    this.affirmations,
    this.notificationsEnabled,
    this.areasToWork,
    this.selectedTheme,
    required this.heardFrom,
    this.reminderNotification,
    this.name,
    this.email,
    this.createdOn,
    this.updatedOn,
    this.ageGroup,
    this.dob,
    this.gender,
    this.journalInitial,
    this.journalReminders,
    this.phoneCode,
    this.phoneNumber,
    this.subscriptionStatus,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
      id: json['_id'],
      affirmations: json['affirmations'] != null
          ? Affirmations.fromJson(json['affirmations'])
          : null,
      notificationsEnabled: json['notificationsEnabled'],
      areasToWork: json['areasToWork'] != null
          ? List<String>.from(json['areasToWork'])
          : null,
      selectedTheme: json['selectedTheme'],
      heardFrom: List<int>.from(json["heardFrom"]?.map((x) => x) ?? []),
      reminderNotification: json['reminderNotification'],
      name: json['name'],
      email: json['email'],
      createdOn: json['createdOn'],
      updatedOn: json['updatedOn'],
      ageGroup: json['ageGroup'],
      dob: json['dob'],
      gender: json['gender'],
      journalInitial: json['journalInitial'] != null
          ? JournalInitial.fromJson(json['journalInitial'])
          : null,
      journalReminders: json['journalReminders'] != null
          ? JournalReminders.fromJson(json['journalReminders'])
          : null,
      phoneCode: json['phoneCode'],
      phoneNumber: json['phoneNumber'],
      subscriptionStatus: json['subscriptionStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    if (affirmations != null) {
      data['affirmations'] = affirmations!.toJson();
    }
    data['notificationsEnabled'] = notificationsEnabled;
    data['areasToWork'] = areasToWork;
    data['selectedTheme'] = selectedTheme;
    data['heardFrom'] = heardFrom.isNotEmpty ? heardFrom : null;
    data['reminderNotification'] = reminderNotification;
    data['name'] = name;
    data['email'] = email;
    data['createdOn'] = createdOn;
    data['updatedOn'] = updatedOn;
    data['ageGroup'] = ageGroup;
    data['dob'] = dob;
    data['gender'] = gender;
    if (journalInitial != null) {
      data['journalInitial'] = journalInitial!.toJson();
    }
    if (journalReminders != null) {
      data['journalReminders'] = journalReminders!.toJson();
    }
    data['phoneCode'] = phoneCode;
    data['phoneNumber'] = phoneNumber;
    data['subscriptionStatus'] = subscriptionStatus;
    return data;
  }
}

class Affirmations {
  final int? countPerDay;
  final String? startTime;
  final String? endTime;

  Affirmations({
    this.countPerDay,
    this.startTime,
    this.endTime,
  });

  factory Affirmations.fromJson(Map<String, dynamic> json) {
    return Affirmations(
      countPerDay: json['countPerDay'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countPerDay'] = countPerDay;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    return data;
  }
}

class JournalInitial {
  final int? question;
  final String? answer;

  JournalInitial({
    this.question,
    this.answer,
  });

  factory JournalInitial.fromJson(Map<String, dynamic> json) {
    return JournalInitial(
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['answer'] = answer;
    return data;
  }
}

class JournalReminders {
  final String? startTime;
  final String? endTime;

  JournalReminders({
    this.startTime,
    this.endTime,
  });

  factory JournalReminders.fromJson(Map<String, dynamic> json) {
    return JournalReminders(
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    return data;
  }
}