import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_task/app/di.dart';
import 'package:route_task/products/cubit/products_cubit.dart';
import 'package:route_task/products/products_screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot._internal();
  static const _instance = AppRoot._internal();
  factory AppRoot() => _instance;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ProductsCubit(instance())),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: ThemeManger.getLightTheme(),
          // onGenerateRoute: RouteManger.route,
          // initialRoute: RouteName.splashView,
          home: ProductsScreen(),
          // home: HomeCartView(),
        ));
  }
}
