

import 'tenanModel.dart';

class PropertInfo {
  String bedroom;
  String landlordID;
  String propertyID;
  String unitID;
  String bathroom;
  String lightMeter;
  String waterMeter;
  String toilet;
  bool wifi;
  bool power;
  String store;
  bool isTaken;
  String monthlyCost;
  String extraWages;
  String tax;
  String photo;
  TenanInfo tenantInfo;

  PropertInfo({
    required this.bedroom,
    required this.landlordID,
    required this.propertyID,
    required this.unitID,
    required this.bathroom,
    required this.lightMeter,
    required this.waterMeter,
    required this.toilet,
    required this.wifi,
    required this.power,
    required this.store,
    required this.isTaken,
    required this.monthlyCost,
    required this.extraWages,
    required this.tax,
    required this.photo,
    required this.tenantInfo,
  });

  factory PropertInfo.fromJson(Map<String, dynamic> json) {
    return PropertInfo(
      bedroom: json['bedroom'] ?? "",
      landlordID: json['landlordID'] ?? "",
      propertyID: json['propertyID'] ?? "",
      unitID: json['unitID'] ?? "",
      bathroom: json['bathroom'] ?? "",
      lightMeter: json['lightMeter'] ?? "",
      waterMeter: json['waterMeter'] ?? "",
      toilet: json['toilet'] ?? "",
      wifi: json['wifi'] ?? false,
      power: json['power'] ?? false,
      store: json['store'] ?? "",
      isTaken: json['isTaken'] ?? false,
      monthlyCost: json['monthlyCost'] ?? "",
      extraWages: json['extraWages'] ?? "",
      tax: json['tax'] ?? "",
      photo: json['photo'] ?? "",
      tenantInfo: TenanInfo.fromJson(json['tenantInfo'] ?? {}),
    );
  }
}