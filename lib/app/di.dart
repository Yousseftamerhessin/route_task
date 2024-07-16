import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:route_task/data/data_services/products/products.dart';
import 'package:route_task/data/repository/products/products.dart';

import '../data/network/network_info.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // network info
  instance.registerLazySingleton<BaseNetworkInfo>(
      () => NetworkInfo(Connectivity()));

  // remote data services

  instance.registerLazySingleton<BaseProductServices>(() => ProductsServices());

  // repository

  instance.registerLazySingleton<BaseProductRepo>(
      () => ProductsRepo(instance(), instance()));
}
