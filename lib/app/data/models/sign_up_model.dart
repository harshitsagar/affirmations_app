import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  int code;
  String message;
  String format;
  DateTime timestamp;

  SignUpModel({
    required this.code,
    required this.message,
    required this.format,
    required this.timestamp,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        code: json["code"],
        message: json["message"],
        format: json["format"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "format": format,
        "timestamp": timestamp.toIso8601String(),
      };
}
