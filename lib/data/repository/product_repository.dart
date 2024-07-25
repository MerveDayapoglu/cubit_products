import 'package:cubit_products/data/model/product_model.dart';
import 'package:cubit_products/data/provider/product_provider.dart';

abstract class IProductRepository {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductDetail(int id);
}

class ProductRepository implements IProductRepository {
  final ProductProvider productProvider;

  ProductRepository(this.productProvider);

  @override
  Future<List<ProductModel>> getProducts() async {
    List<ProductModel> products = await productProvider.getProducts();
    return products;
  }

  @override
  Future<ProductModel> getProductDetail(int id) async {
    ProductModel productModel = await productProvider.getProductDetail(id);
    return productModel;
  }
}
