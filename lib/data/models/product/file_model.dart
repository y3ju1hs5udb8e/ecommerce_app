class FileModel {
  final String originalname;
  final String filename;
  final String location;

  FileModel({
    required this.originalname,
    required this.filename,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'originalname': originalname,
      'filename': filename,
      'location': location,
    };
  }

  factory FileModel.fromMap(Map<String, dynamic> map) {
    return FileModel(
      originalname: map['originalname'] as String,
      filename: map['filename'] as String,
      location: map['location'] as String,
    );
  }

  factory FileModel.empty() => FileModel(
        originalname: '',
        filename: '',
        location: '',
      );
}
