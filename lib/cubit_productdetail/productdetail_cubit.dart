import 'package:cubit_products/data/model/product_model.dart';
import 'package:cubit_products/data/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'productdetail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductRepository _productRepository;

  ProductDetailCubit(this._productRepository)
      : super(ProductDetailInitialState());

  Future<void> getProductDetail(int id) async {
    try {
      final product = await _productRepository.getProductDetail(id);
      emit(ProductDetailSuccessState(product));
    } catch (e) {
      emit(ProductDetailErrorState(e.toString()));
    }
  }
}
