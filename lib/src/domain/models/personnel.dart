import 'dart:convert';
import 'package:flutter/services.dart';

class Personnel {
  final int? id;
  final String name;
  final String title;
  final String email;
  final String phoneNumber;

  Personnel({
    this.id,
    required this.name,
    required this.title,
    required this.email,
    required this.phoneNumber,
  });

  factory Personnel.fromJson(Map<String, dynamic> json) {
    return Personnel(
      id: json['id'] as int?,
      name: json['name'] as String,
      title: json['title'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'name': name,
      'title': title,
      'email': email,
      'phoneNumber': phoneNumber,
    };
    if (id != null) {
      json['id'] = id;
    }

    return json;
  }
}

class PersonnelModel {
  static Future<List<Personnel>> loadPersonnelFromJson() async {
    final String jsonString = await rootBundle.loadString('lib/assets/mock_data.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((entry) => Personnel.fromJson(entry)).toList();
  }
}
