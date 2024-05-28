import 'dart:convert';

import 'package:http/http.dart' as http;

class PropertyTypeCount {
  final String type;
  final int count;

  PropertyTypeCount({required this.type, required this.count});

  factory PropertyTypeCount.fromJson(Map<String, dynamic> json) {
    return PropertyTypeCount(
      type: json['type'],
      count: json['count'],
    );
  }
}


Future<Map<String, int>> fetchPropertyTypesAndCounts() async {
  final response =await http.get(Uri.parse('http://192.168.1.68:3000/property/find/types'));
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final Map<String, int> propertyTypeCounts = data.map((key, value) {
      return MapEntry(key, value as int);
    });
    return propertyTypeCounts;
  } else {
    throw Exception('Failed to fetch property types and counts');
  }
}

