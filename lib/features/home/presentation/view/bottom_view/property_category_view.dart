import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PropertyTypesScreen extends StatefulWidget {
  const PropertyTypesScreen({super.key});

  @override
  _PropertyTypesScreenState createState() => _PropertyTypesScreenState();
}

class _PropertyTypesScreenState extends State<PropertyTypesScreen> {
  late Future<Map<String, int>> propertyTypeCounts;

  @override
  void initState() {
    super.initState();
    propertyTypeCounts = fetchPropertyTypesAndCounts();
  }

  Future<Map<String, int>> fetchPropertyTypesAndCounts() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.68:3000/property/find/types'));
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

  Map<String, String> propertyTypeImages = {
    'BEACH': 'assets/images/beach.jpg',
    'MOUNTAIN': 'assets/images/mountain.jpg',
    'VILLAGE': 'assets/images/village.jpg',
    // Add more property types and their image paths as needed
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Types'),
      ),
      body: FutureBuilder<Map<String, int>>(
        future: propertyTypeCounts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final type = snapshot.data!.keys.toList()[index];
                final count = snapshot.data![type];
                final imagePath = propertyTypeImages[type] ??
                    'assets/images/default_image.jpg';

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      leading: Image.asset(
                        imagePath,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text('$type Properties'),
                      subtitle: Text('Count: $count'),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
