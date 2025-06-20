class UploadImageRequest {
  final String filename;
  final String file;

  UploadImageRequest({required this.filename, required this.file});

  Map<String, dynamic> toJson() {
    return {
      'filename': filename,
      'file': file,
    };
  }
}
