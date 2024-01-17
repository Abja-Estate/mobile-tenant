import 'dart:convert';

class TenanInfo {
  String email;
  String phone;
  String unitID;
  String startDate;
  String endDate;
  String name;
  String surname;
  bool canDelete;
  String selfie;
  String idPhoto;
  String receiptDoc;
  String rentalDoc;
  String createdAt;
  String addedAt;

  TenanInfo({
    required this.email,
    required this.phone,
    required this.unitID,
    required this.startDate,
    required this.endDate,
    required this.name,
    required this.surname,
    required this.canDelete,
    required this.selfie,
    required this.idPhoto,
    required this.receiptDoc,
    required this.rentalDoc,
    required this.createdAt,
    required this.addedAt,
  });

  factory TenanInfo.fromJson(Map<String, dynamic> json) {
    return TenanInfo(
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      unitID: json['unitID'] ?? "",
      startDate: json['startDate'] ?? "",
      endDate: json['endDate'] ?? "",
      name: json['name'] ?? "",
      surname: json['surname'] ?? "",
      canDelete: json['canDelete'] ?? false,
      selfie: json['selfie'] ?? "",
      idPhoto: json['idPhoto'] ?? "",
      receiptDoc: json['receiptDoc'] ?? "",
      rentalDoc: json['rentalDoc'] ?? "",
      createdAt: json['created_at'] ?? "",
      addedAt: json['added_at'] ?? "",
    );
  }
}
