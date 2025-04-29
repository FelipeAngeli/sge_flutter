import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'core/storage/hive_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
