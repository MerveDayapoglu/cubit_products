part of 'product_cubit.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductSuccessState extends ProductState {
  final List<ProductModel> productModel;
  ProductSuccessState(this.productModel);
}

class ProductErrorState extends ProductState {
  final String error;
  ProductErrorState(this.error);
}
