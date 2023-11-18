// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:todo_mini/core/theme_manager.dart';
import 'package:todo_mini/data/models/todo.dart';
import 'package:todo_mini/injector.dart';

const String TODOS_LOCAL_KEY = "todo";
const String THEME_LOCAL_KEY = "theme";

///Add Task Text on Home Page
Text addTaskWidget = Text("Add Task",
    style: sl<ThemeManager>().currentThemeData.textTheme.titleLarge);

// First initialization
List<Todo> firstTodos = [
  Todo(content: "Your first todo!!!", dueDate: DateTime(2024, 1, 1)),
  Todo(content: "Add something now!!!", dueDate: DateTime(2025, 1, 1)),
];

// Defaults
const ThemeMode defaultThemeMode = ThemeMode.system;
