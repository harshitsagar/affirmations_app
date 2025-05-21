class HomeScreenModel {
  HomeScreenModel({
    required this.code,
    required this.message,
    required this.data,
    required this.format,
    required this.timestamp,
  });

  final int? code;
  final String? message;
  final HomeScreenData data;
  final String? format;
  final DateTime? timestamp;

  factory HomeScreenModel.fromJson(Map<String, dynamic> json) {
    return HomeScreenModel(
      code: json["code"],
      message: json["message"],
      data: HomeScreenData.fromJson(json["data"] ?? {}),
      format: json["format"],
      timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
    );
  }
}

class HomeScreenData {
  HomeScreenData({
    required this.affirmations,
    required this.page,
    required this.limit,
    required this.target,
    required this.streakCount,
    required this.journalPending,
    required this.showInterstitialAd,
    required this.goalCompleted,
  });

  final List<Affirmation> affirmations;
  final int? page;
  final int? limit;
  final int? target;
  final int? streakCount;
  final bool? journalPending;
  final bool? showInterstitialAd;
  final bool? goalCompleted;

  factory HomeScreenData.fromJson(Map<String, dynamic> json) {
    return HomeScreenData(
      affirmations: json["affirmations"] == null
          ? []
          : List<Affirmation>.from(json["affirmations"]!.map((x) => Affirmation.fromJson(x))),
      page: json["page"],
      limit: json["limit"],
      target: json["target"],
      streakCount: json["streakCount"],
      journalPending: json["journalPending"],
      showInterstitialAd: json["showInterstitialAd"],
      goalCompleted: json["goalCompleted"],
    );
  }
}

class Affirmation {
  Affirmation({
    required this.id,
    required this.theme,
    required this.categoryRef,
    required this.createdOn,
    required this.text,
  });

  final String id;
  final List<String> theme;
  final String categoryRef;
  final DateTime createdOn;
  final String text;

  factory Affirmation.fromJson(Map<String, dynamic> json) {
    return Affirmation(
      id: json["_id"] ?? "",
      theme: json["theme"] == null
          ? []
          : List<String>.from(json["theme"]!.map((x) => x.toString())),
      categoryRef: json["categoryRef"] ?? "",
      createdOn: DateTime.parse(json["createdOn"] ?? DateTime.now().toIso8601String()),
      text: json["text"] ?? "",
    );
  }
}