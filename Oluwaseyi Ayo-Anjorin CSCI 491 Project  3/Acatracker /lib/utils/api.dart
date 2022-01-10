// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

String variable = 'id';

class Class {
  final int id;
  final String className;

  Class({
    required this.id,
    required this.className,
  });

  static List<Class> classes = [];

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      className: json['classname'],
    );
  }

  static List<Class> getClass(List<dynamic> json) {
    classes.clear();
    for (int i = 0; i < json.length; i++) {
      classes.add(Class.fromJson(json[i]));
    }
    return classes;
  }
}

class ClassItem {
  final int id;
  final String className;
  final String collaborators;
  final String startDate;
  final String endDate;
  final String classRoom;
  final String score;
  final String status;

  ClassItem({
    required this.className,
    required this.classRoom,
    required this.collaborators,
    required this.endDate,
    required this.id,
    required this.score,
    required this.startDate,
    required this.status,
  });

  static List<ClassItem> classItems = [];

  factory ClassItem.fromJson(Map<String, dynamic> json) {
    return ClassItem(
      id: json['id'],
      className: json['classitem'],
      classRoom: json['classroom'],
      collaborators: json['collaborators'],
      startDate: json['startdate'],
      endDate: json['enddate'],
      score: json['score'].toString(),
      status: json['status'],
    );
  }

  static List<ClassItem> getClassItem(List<dynamic> json) {
    classItems.clear();
    for (int i = 0; i < json.length; i++) {
      classItems.add(ClassItem.fromJson(json[i]));
    }
    return classItems;
  }

  static void print(dynamic value) {
    print("Status Code: " + value.statusCode.toString());
    print("Body: " + value.body.toString());
    print("Reason Phrase: " + value.reasonPhrase.toString());
    print("Request: " + value.request.toString());
  }
}

Future<List<ClassItem>> getClassItems(String tableName) async {
  print(tableName);
  final response = await http
      .get(Uri.parse('http://localhost:3000/$tableName?order=$variable'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ClassItem.getClassItem(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List<Class>> getClass(String tableName) async {
  final response =
      await http.get(Uri.parse('http://localhost:3000/t_$tableName'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    return Class.getClass(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    throw Exception('Failed to load album');
  }
}

Future<http.Response> putClassItem(
  String tableName, {
  String? name,
  String? room,
  String? collab,
  String? startDate,
  String? endDate,
  String? score,
  String? status,
}) async {
  final response =
      await http.post(Uri.parse('http://localhost:3000/$tableName'), headers: {
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidG9kb191c2VyIn0.7KgBQICmvTmAWbfI6eYdeflPq3S1Zn8bVde7AnC9SoY",
    // "Content-Type": "application/json"
  }, body: {
    'classitem': name,
    'collaborators': collab,
    'startdate': startDate,
    'enddate': endDate,
    'classroom': room,
    'score': score,
    'status': status
  });

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    return response;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    throw Exception('Failed to load album');
  }
}

Future<http.Response> updateClassItem(
    String tableName, String columnName, String columnValue, int id) async {
  final response = await http
      .patch(Uri.parse('http://localhost:3000/$tableName?id=eq.$id'), headers: {
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidG9kb191c2VyIn0.7KgBQICmvTmAWbfI6eYdeflPq3S1Zn8bVde7AnC9SoY",
    // "Content-Type": "application/json"
  }, body: {
    columnName: columnValue,
  });

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    return response;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    return response;
  }
}

Future<http.Response> deleteClassItem(String tableName, int id) async {
  final response = await http.delete(
    Uri.parse('http://localhost:3000/$tableName?id=eq.$id'),
    headers: {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidG9kb191c2VyIn0.7KgBQICmvTmAWbfI6eYdeflPq3S1Zn8bVde7AnC9SoY",
      // "Content-Type": "application/json"
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    return response;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    return response;
    // throw Exception('Failed to load album');
  }
}

Future<http.Response> deleteClass(String tableName, String value) async {
  final response = await http.delete(
    Uri.parse('http://localhost:3000/$tableName?classname=eq.$value'),
    headers: {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidG9kb191c2VyIn0.7KgBQICmvTmAWbfI6eYdeflPq3S1Zn8bVde7AnC9SoY",
      // "Content-Type": "application/json"
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    return response;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    return response;
    // throw Exception('Failed to load album');
  }
}

Future<http.Response> putClass(String userName, String className) async {
  final response =
      await http.post(Uri.parse('http://localhost:3000/t_$userName'), headers: {
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidG9kb191c2VyIn0.7KgBQICmvTmAWbfI6eYdeflPq3S1Zn8bVde7AnC9SoY",
    // "Content-Type": "application/json"
  }, body: {
    'classname': 't_' + className,
  });

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    return response;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    throw Exception('Failed to load album');
  }
}

Future<http.Response> createTable(String tableName) async {
  final response = await http.post(
      Uri.parse('http://localhost:3000/rpc/create_table_class'),
      headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidG9kb191c2VyIn0.7KgBQICmvTmAWbfI6eYdeflPq3S1Zn8bVde7AnC9SoY",
      },
      body: {
        "t_name": tableName,
      });

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    return response;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    throw Exception('Failed to load album');
  }
}

Future<http.Response> deleteTable(String tableName) async {
  final response = await http.post(
      Uri.parse('http://localhost:3000/rpc/delete_table_class'),
      headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidG9kb191c2VyIn0.7KgBQICmvTmAWbfI6eYdeflPq3S1Zn8bVde7AnC9SoY",
      },
      body: {
        "t_name": tableName,
      });

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    return response;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    throw Exception('Failed to load album');
  }
}

Future<http.Response> createUser(String userName) async {
  final response = await http
      .post(Uri.parse('http://localhost:3000/rpc/create_table_user'), headers: {
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidG9kb191c2VyIn0.7KgBQICmvTmAWbfI6eYdeflPq3S1Zn8bVde7AnC9SoY",
  }, body: {
    "t_name": userName,
  });

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    return response;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.statusCode);
    print(response.body);
    print(response.reasonPhrase);
    print(response.request);
    return response;
  }
}
