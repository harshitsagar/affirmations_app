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
  final List<String>? areasToWork;
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
  final String? subscriptionStatus;
  final Streak? streak;
  final Theme? theme;

  UserProfileData({
    this.id,
    this.affirmations,
    this.areasToWork,
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
    this.subscriptionStatus,
    this.streak,
    this.theme,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
      id: json['_id'],
      affirmations: json['affirmations'] != null
          ? Affirmations.fromJson(json['affirmations'])
          : null,
      areasToWork: json['areasToWork'] != null
          ? List<String>.from(json['areasToWork'])
          : null,
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
      subscriptionStatus: json['subscriptionStatus'],
      streak: json['streak'] != null ? Streak.fromJson(json['streak']) : null,
      theme: json['theme'] != null ? Theme.fromJson(json['theme']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    if (affirmations != null) {
      data['affirmations'] = affirmations!.toJson();
    }
    data['areasToWork'] = areasToWork;
    data['heardFrom'] = heardFrom;
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
    data['subscriptionStatus'] = subscriptionStatus;
    if (streak != null) {
      data['streak'] = streak!.toJson();
    }
    if (theme != null) {
      data['theme'] = theme!.toJson();
    }
    return data;
  }

  bool get isPremium => subscriptionStatus?.toLowerCase() == "active";
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

class Streak {
  final int? status;
  final int? current;
  final int? longest;
  final bool? broken;
  final String? lastUpdated;
  final Restore? restore;
  final Freeze? freeze;
  final MonthlyChallenge? monthlyChallenge;

  Streak({
    this.status,
    this.current,
    this.longest,
    this.broken,
    this.lastUpdated,
    this.restore,
    this.freeze,
    this.monthlyChallenge,
  });

  factory Streak.fromJson(Map<String, dynamic> json) {
    return Streak(
      status: json['status'],
      current: json['current'],
      longest: json['longest'],
      broken: json['broken'],
      lastUpdated: json['lastUpdated'],
      restore: json['restore'] != null ? Restore.fromJson(json['restore']) : null,
      freeze: json['freeze'] != null ? Freeze.fromJson(json['freeze']) : null,
      monthlyChallenge: json['monthlyChallenge'] != null
          ? MonthlyChallenge.fromJson(json['monthlyChallenge'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['current'] = current;
    data['longest'] = longest;
    data['broken'] = broken;
    data['lastUpdated'] = lastUpdated;
    if (restore != null) {
      data['restore'] = restore!.toJson();
    }
    if (freeze != null) {
      data['freeze'] = freeze!.toJson();
    }
    if (monthlyChallenge != null) {
      data['monthlyChallenge'] = monthlyChallenge!.toJson();
    }
    return data;
  }
}

class Restore {
  final int? totalAvailable;
  final List<dynamic>? used;

  Restore({
    this.totalAvailable,
    this.used,
  });

  factory Restore.fromJson(Map<String, dynamic> json) {
    return Restore(
      totalAvailable: json['totalAvailable'],
      used: json['used'] != null ? List<dynamic>.from(json['used']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalAvailable'] = totalAvailable;
    if (used != null) {
      data['used'] = used;
    }
    return data;
  }
}

class Freeze {
  final int? totalAvailable;
  final List<dynamic>? used;

  Freeze({
    this.totalAvailable,
    this.used,
  });

  factory Freeze.fromJson(Map<String, dynamic> json) {
    return Freeze(
      totalAvailable: json['totalAvailable'],
      used: json['used'] != null ? List<dynamic>.from(json['used']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalAvailable'] = totalAvailable;
    if (used != null) {
      data['used'] = used;
    }
    return data;
  }
}

class MonthlyChallenge {
  final List<dynamic>? completedDays;

  MonthlyChallenge({
    this.completedDays,
  });

  factory MonthlyChallenge.fromJson(Map<String, dynamic> json) {
    return MonthlyChallenge(
      completedDays: json['completedDays'] != null
          ? List<dynamic>.from(json['completedDays'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (completedDays != null) {
      data['completedDays'] = completedDays;
    }
    return data;
  }
}

class Theme {
  final String? id;
  final List<String>? backgroundGradient;
  final bool? deleted;
  final String? name;
  final String? primaryColor;
  final String? secondaryColor;
  final String? aspect;
  final String? createdOn;
  final String? updatedOn;
  final int? v;

  Theme({
    this.id,
    this.backgroundGradient,
    this.deleted,
    this.name,
    this.primaryColor,
    this.secondaryColor,
    this.aspect,
    this.createdOn,
    this.updatedOn,
    this.v,
  });

  factory Theme.fromJson(Map<String, dynamic> json) {
    return Theme(
      id: json['_id'],
      backgroundGradient: json['backgroundGradient'] != null
          ? List<String>.from(json['backgroundGradient'])
          : null,
      deleted: json['deleted'],
      name: json['name'],
      primaryColor: json['primaryColor'],
      secondaryColor: json['secondaryColor'],
      aspect: json['aspect'],
      createdOn: json['createdOn'],
      updatedOn: json['updatedOn'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    if (backgroundGradient != null) {
      data['backgroundGradient'] = backgroundGradient;
    }
    data['deleted'] = deleted;
    data['name'] = name;
    data['primaryColor'] = primaryColor;
    data['secondaryColor'] = secondaryColor;
    data['aspect'] = aspect;
    data['createdOn'] = createdOn;
    data['updatedOn'] = updatedOn;
    data['__v'] = v;
    return data;
  }
}