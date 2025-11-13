import 'package:flutter/material.dart';
import 'package:s_note/app/app.dart';
import 'package:s_note/app/di/get_it.dart' as di;
import 'package:s_note/app/provider/app_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([di.init()]);
  runApp(const AppProviders(child: NoteApp()));
}