class MontlyCalenderModel {
  int? code;
  String? message;
  List<MontlyCalenderModelData>? data;
  String? format;
  String? timestamp;

  MontlyCalenderModel(
      {this.code, this.message, this.data, this.format, this.timestamp});

  MontlyCalenderModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MontlyCalenderModelData>[];
      json['data'].forEach((v) {
        data!.add(new MontlyCalenderModelData.fromJson(v));
      });
    }
    format = json['format'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['format'] = this.format;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class MontlyCalenderModelData {
  int? day;
  String? date;
  bool? goalCompleted;
  bool? streakFreeze;
  bool? streakRestore;
  bool? streakBroken;

  MontlyCalenderModelData(
      {this.day,
        this.date,
        this.goalCompleted,
        this.streakFreeze,
        this.streakRestore,
        this.streakBroken});

  MontlyCalenderModelData.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    date = json['date'];
    goalCompleted = json['goalCompleted'];
    streakFreeze = json['streakFreeze'];
    streakRestore = json['streakRestore'];
    streakBroken = json['streakBroken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['date'] = this.date;
    data['goalCompleted'] = this.goalCompleted;
    data['streakFreeze'] = this.streakFreeze;
    data['streakRestore'] = this.streakRestore;
    data['streakBroken'] = this.streakBroken;
    return data;
  }
}