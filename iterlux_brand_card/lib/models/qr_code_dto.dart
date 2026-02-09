import 'package:cloud_firestore/cloud_firestore.dart';

class QrCodeDto {
  int? id;
  String name;
  String filePath;
  String storageUrl;
  bool isDefault;
  Timestamp lastUpdated;
  String userId;

  QrCodeDto({
    this.id,
    this.name = '',
    this.filePath = '',
    this.storageUrl = '',
    this.isDefault = false,
    required this.lastUpdated,
    this.userId = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'filePath': filePath,
      'storageUrl': storageUrl,
      'isDefault': isDefault,
      'lastUpdated': lastUpdated,
      'userId': userId,
    };
  }

  factory QrCodeDto.fromMap(Map<String, dynamic> map) {
    return QrCodeDto(
      id: map['id'],
      name: map['name'],
      filePath: map['filePath'],
      storageUrl: map['storageUrl'],
      isDefault: map['isDefault'],
      lastUpdated: map['lastUpdated'],
      userId: map['userId'],
    );
  }
}