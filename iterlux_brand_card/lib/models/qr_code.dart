class QrCode {
  int? id;
  String name;
  String filePath;
  String storageUrl;
  bool isDefault;
  DateTime lastUpdated;
  String userId;
  bool needsUpload;
  bool needsRename;

  QrCode({
    this.id,
    this.name = 'Unnamed QR Code',
    this.filePath = '',
    this.storageUrl = '',
    this.isDefault = false,
    required this.lastUpdated,
    this.userId = '',
    this.needsUpload = false,
    this.needsRename = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'filePath': filePath,
      'storageUrl': storageUrl,
      'isDefault': isDefault ? 1 : 0,
      'lastUpdated': lastUpdated.toIso8601String(),
      'userId': userId,
      'needsUpload': needsUpload ? 1 : 0,
      'needsRename': needsRename ? 1 : 0,
    };
  }

  factory QrCode.fromMap(Map<String, dynamic> map) {
    return QrCode(
      id: map['id'],
      name: map['name'],
      filePath: map['filePath'],
      storageUrl: map['storageUrl'],
      isDefault: map['isDefault'] == 1,
      lastUpdated: DateTime.parse(map['lastUpdated']),
      userId: map['userId'],
      needsUpload: map['needsUpload'] == 1,
      needsRename: map['needsRename'] == 1,
    );
  }
}