class GetFeaturesPetRequest{
  final String fileName;
  final String file;

  GetFeaturesPetRequest({
    required this.fileName,
    required this.file
  });

  factory GetFeaturesPetRequest.fromJson(Map<String, dynamic> json){
    return GetFeaturesPetRequest(
      fileName: json['fileName'],
      file: json['file']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'fileName': fileName,
      'file': file
    };
  }
}