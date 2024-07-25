import 'package:cubit_products/data/model/product_model.dart';
import 'package:cubit_products/data/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _productRepository;
  ProductCubit(this._productRepository) : super(ProductInitialState());

  Future<void> getProducts() async {
    try {
      final product = await _productRepository.getProducts();
      emit(ProductSuccessState(product));
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }
}
