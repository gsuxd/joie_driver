class MetodoPago {
  final String nameComplete;
  final String numberCI;
  final String dateCI;
  final String bank;
  final String numberBank;
  final String typeBank;

  MetodoPago({
    required this.nameComplete,
    required this.numberCI,
    required this.dateCI,
    required this.bank,
    required this.numberBank,
    required this.typeBank,
  });

  factory MetodoPago.fromJson(Map<String, dynamic> json) => MetodoPago(
        nameComplete: json["nameComplete"],
        numberCI: json["number_ci"],
        dateCI: json["date_ci"],
        bank: json["bank"],
        numberBank: json["number_bank"],
        typeBank: json["type_bank"],
      );

  Map<String, dynamic> toJson() => {
        "nameComplete": nameComplete,
        "number_ci": numberCI,
        "date_ci": dateCI,
        "bank": bank,
        "number_bank": numberBank,
        "type_bank": typeBank,
      };
}
