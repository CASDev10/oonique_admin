import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/app/my_app.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app/app_bloc_observer.dart';
import 'config/environment.dart';
import 'core/initializer/init_app.dart';
import 'core/network/my_http_overrides.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  HttpOverrides.global = MyHttpOverrides();
  if (!kIsWeb) {
    await Permission.notification.request();
  }
  await initApp(Environment.fromEnv(AppEnv.dev));
  runApp(const OoniqueApp());
}
