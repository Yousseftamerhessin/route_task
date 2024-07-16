import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:route_task/data/data_services/products/products.dart';
import 'package:route_task/data/failure/failure.dart';
import 'package:route_task/data/network/network_info.dart';
import 'package:route_task/data/response/products/products_model.dart';

import '../../network/error_handler.dart';

abstract class BaseProductRepo {
  Future<Either<Failure, List<Products>>> getProducts();
}

class ProductsRepo implements BaseProductRepo {
  final BaseNetworkInfo _baseNetworkInfo;
  final BaseProductServices _dataServices;

  ProductsRepo(this._baseNetworkInfo, this._dataServices);
  @override
  Future<Either<Failure, List<Products>>> getProducts() async {
    if (await _baseNetworkInfo.checkConnection()) {
      try {
        final response = await _dataServices.getProducts();
        return Right(response);
      } on DioException catch (e) {
        return Left(e.response!.data['message']);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.failure());
    }
  }
}
