class UploadResponse {
  final int status;
  final Map<String, dynamic> data;
  final String imageUrl;

  UploadResponse({required this.status, required this.data, required this.imageUrl});

  factory UploadResponse.fromJson(Map<String, dynamic> json) {
    return UploadResponse(
      status: json['status'],
      data: json['data'],
      imageUrl: json['imageUrl'],
    );
  }
}

