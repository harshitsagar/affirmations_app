class HomeScreenModel {
  HomeScreenModel({
    required this.code,
    required this.message,
    required this.data,
    required this.page,
    required this.limit,
    required this.format,
    required this.timestamp,
  });

  final int? code;
  final String? message;
  final List<HomeScreenModelData> data;
  final int? page;
  final int? limit;
  final String? format;
  final DateTime? timestamp;

  factory HomeScreenModel.fromJson(Map<String, dynamic> json){
    return HomeScreenModel(
      code: json["code"],
      message: json["message"],
      data: json["data"] == null ? [] : List<HomeScreenModelData>.from(json["data"]!.map((x) => HomeScreenModelData.fromJson(x))),
      page: json["page"],
      limit: json["limit"],
      format: json["format"],
      timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
    );
  }

}

class HomeScreenModelData {
  HomeScreenModelData({
    required this.id,
    required this.theme,
    required this.categoryRef,
    required this.createdOn,
    required this.text,
  });

  final String? id;
  final List<String> theme;
  final String? categoryRef;
  final DateTime? createdOn;
  final String? text;

  factory HomeScreenModelData.fromJson(Map<String, dynamic> json){
    return HomeScreenModelData(
      id: json["_id"],
      theme: json["theme"] == null ? [] : List<String>.from(json["theme"]!.map((x) => x)),
      categoryRef: json["categoryRef"],
      createdOn: DateTime.tryParse(json["createdOn"] ?? ""),
      text: json["text"],
    );
  }

}
