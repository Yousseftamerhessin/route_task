part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

class LoadGetProductsState extends ProductsState {}

class SuccessGetProductsState extends ProductsState {}

class FailureGetProductsState extends ProductsState {}
