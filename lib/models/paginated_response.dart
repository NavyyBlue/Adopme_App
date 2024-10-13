class PaginatedResponse<T> {
  int? count;
  int? totalPages;
  List<T>? data;
  String? nextPageUrl;
  String? prevPageUrl;

  PaginatedResponse(
      {this.count,
        this.totalPages,
        this.data,
        this.nextPageUrl,
        this.prevPageUrl});

  PaginatedResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    count = json['count'];
    totalPages = json['totalPages'];
    if (json['data'] != null) {
      data = <T>[];
      json['data'].forEach((v) {
        data!.add(fromJsonT(v));
      });
    }
    nextPageUrl = json['nextPageUrl'];
    prevPageUrl = json['prevPageUrl'];
  }

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = this.count;
    data['totalPages'] = this.totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => toJsonT(v)).toList();
    }
    data['nextPageUrl'] = this.nextPageUrl;
    data['prevPageUrl'] = this.prevPageUrl;
    return data;
  }
}