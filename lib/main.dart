import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_task/products/products_screen.dart';
import 'package:route_task/resources/bloc_observer.dart';

import 'app/app_root.dart';
import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initAppModule();
  Bloc.observer = AppBlocObserver();
  runApp(AppRoot());
}
