part of 'productdetail_cubit.dart';

class ProductDetailState {}

final class ProductDetailInitialState extends ProductDetailState {}

final class ProductDetailSuccessState extends ProductDetailState {
  final ProductModel productModel;
  ProductDetailSuccessState(this.productModel);
}

final class ProductDetailErrorState extends ProductDetailState {
  final String error;
  ProductDetailErrorState(this.error);
}
