import 'dart:convert';

AppDetailsModel appDetailsModelFromJson(String str) =>
    AppDetailsModel.fromJson(json.decode(str));

String appDetailsModelToJson(AppDetailsModel data) =>
    json.encode(data.toJson());

class AppDetailsModel {
  AppDetailsModel({
    required this.code,
    required this.message,
    required this.data,
    required this.format,
    required this.timestamp,
  });

  int? code;
  String? message;
  AppData? data;
  String? format;
  String? timestamp;

  AppDetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? AppData.fromJson(json['data']) : null;
    format = json['format'];
    timestamp = json['timestamp'];
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

class AppData {
  String? id;
  String? aboutUs;
  String? aboutUsUpdatedOn;
  String? createdOn;
  String? privacyPolicy;
  String? privacyPolicyUpdatedOn;
  String? termsAndConditions;
  String? termsAndConditionsUpdatedOn;

  AppData(
      {this.id,
      this.aboutUs,
      this.aboutUsUpdatedOn,
      this.createdOn,
      this.privacyPolicy,
      this.privacyPolicyUpdatedOn,
      this.termsAndConditions,
      this.termsAndConditionsUpdatedOn});

  AppData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    aboutUs = json['aboutUs'];
    aboutUsUpdatedOn = json['aboutUsUpdatedOn'];
    createdOn = json['createdOn'];
    privacyPolicy = json['privacyPolicy'];
    privacyPolicyUpdatedOn = json['privacyPolicyUpdatedOn'];
    termsAndConditions = json['termsAndConditions'];
    termsAndConditionsUpdatedOn = json['termsAndConditionsUpdatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['aboutUs'] = aboutUs;
    data['aboutUsUpdatedOn'] = aboutUsUpdatedOn;
    data['createdOn'] = createdOn;
    data['privacyPolicy'] = privacyPolicy;
    data['privacyPolicyUpdatedOn'] = privacyPolicyUpdatedOn;
    data['termsAndConditions'] = termsAndConditions;
    data['termsAndConditionsUpdatedOn'] = termsAndConditionsUpdatedOn;
    return data;
  }
}
