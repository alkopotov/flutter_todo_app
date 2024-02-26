import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart' as intl;


var uuid =  const Uuid();

class Todo {
  
  Todo({
    required this.title,
    required this.completed,
    required this.due,
    required this.urgent,
    required this.id,
  });

  String id;
  String title;
  bool completed;
  DateTime due;
  bool urgent;

  void switchCompleted() {
    completed = !completed;
  }

  int get daysLeft {
    return due.difference(DateTime.now()).inDays;
  }

  Color get todoColor {
    if (completed) return const Color.fromARGB(255, 171, 243, 174);
    switch (daysLeft) {
      case < 0: return const Color.fromARGB(255, 142, 2, 2);
      case 0: return const Color.fromARGB(255, 184, 21, 21);
      case 1: return const Color.fromARGB(255, 244, 105, 105);
      case 2: return const Color.fromARGB(255, 183, 177, 4);
      case 3: return  const Color.fromARGB(255, 216, 212, 102);
      default: return const Color.fromARGB(255, 244, 242, 197);
    }
  }

  Color get todoTextColor {
    if (completed) return const Color.fromARGB(255, 0, 0, 0);
    if (daysLeft <= 1) {
      return const Color.fromARGB(255, 255, 255, 255);
    } else {
      return const Color.fromARGB(255, 0, 0, 0);
    }
  }

  String get todoText {
    if (completed) return title;
    switch (daysLeft) {
      case < 0: return '$title - просрочено';
      case 0: return '$title сегодня';
      case 1: return '$title завтра';
      case 2: return '$title послезавтра';
      default: return '$title - ${intl.DateFormat('dd/MM').format(due)}';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
      'due': due.toIso8601String(),
      'urgent': urgent,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    title: json['title'],
    id: json['id'],
    completed: json['completed'],
    due: DateTime.parse(json['due']),
    urgent: json['urgent']
  );
}