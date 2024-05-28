import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:real_estate_app/features/property/domain/entity/property_entity.dart';

class Property {
  // Your Property class implementation
  // Define the properties of a property, similar to the Property model in your server.
}

class PropertySearchScreen extends StatefulWidget {
  const PropertySearchScreen({super.key});

  @override
  _PropertySearchScreenState createState() => _PropertySearchScreenState();
}

class _PropertySearchScreenState extends State<PropertySearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<PropertyEntity> _searchResults = [];

  void _performSearch() async {
    String searchQuery = _searchController.text.trim();
    if (searchQuery.isEmpty) return;

    // Make an API request to search for properties based on the type
    const String baseUrl =
        'http://192.168.1.68:3000/'; // Replace with your API base URL
    const String searchEndpoint =
        'property/search'; // Replace with the search endpoint on your server

    Uri uri = Uri.parse('http://192.168.1.68:3000/property/search?type=beach');
    final response = await http.get(uri);
    print('Response Body: ${response.body}');
    print('Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      // Parse the API response and update the search results
      List<dynamic> jsonData = jsonDecode(response.body);
      setState(() {
        _searchResults =
            jsonData.map((data) => PropertyEntity.fromJson(data)).toList();
      });
    } else {
      // Handle API error, e.g., display a message to the user
      // You can also show a snackbar or error dialog here.
      print('Failed to perform search. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Enter Property Type',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _performSearch,
            child: const Text('Search'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                // Display the search results as a list of properties
                return ListTile(
                  title: Text(_searchResults[index].title),
                  subtitle: Text(_searchResults[index].type),
                  // Add more property details here if needed
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
