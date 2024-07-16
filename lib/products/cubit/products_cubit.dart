import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:route_task/data/repository/products/products.dart';
import 'package:route_task/data/response/products/products_model.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._productRepo) : super(ProductsInitial());

  final BaseProductRepo _productRepo;
  List<Products> products = [];
  getproducts() async {
    products.clear();
    emit(LoadGetProductsState());

    try {
      final result = await _productRepo.getProducts();
      result.fold((error) {
        debugPrint(error.message);
        emit(FailureGetProductsState());
      }, (products) {
        debugPrint(products.length.toString());
        for (var i = 0; i < products.length; i++) {
          this.products.add(products[i]);
          if (i == 10) emit(SuccessGetProductsState());
        }
        emit(SuccessGetProductsState());
      });
    } catch (e) {
      debugPrint(e.toString());
      emit(FailureGetProductsState());
    }
  }
}
