import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/app/app_module.dart';
import 'package:sge_flutter/app/app_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sge_flutter/core/storage/hive_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Carrega variáveis do arquivo .env
  await dotenv.load(fileName: '.env');

  // Inicializa Hive
  await HiveConfig.start();

  // Inicializa Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
