import 'dart:convert';

class SWAPIResponse<T> {
  final int count;
  final String? next;
  final String? previous;
  final List<T> results;

  SWAPIResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory SWAPIResponse.fromRawJson(
    String str,
    T Function(Map<String, dynamic>) fromJsonT,
  ) =>
      SWAPIResponse.fromJson(json.decode(str), fromJsonT);

  factory SWAPIResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return SWAPIResponse<T>(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
