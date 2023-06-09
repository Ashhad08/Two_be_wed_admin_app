class ExtraService {
  String name;
  num budget;

  ExtraService({
    required this.name,
    required this.budget,
  });

  factory ExtraService.fromJson(Map<String, dynamic> json) => ExtraService(
        name: json["name"],
        budget: json["budget"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "budget": budget,
      };
}
