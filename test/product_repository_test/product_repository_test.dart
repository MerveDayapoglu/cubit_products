import 'package:cubit_products/data/model/product_model.dart';
import 'package:cubit_products/data/provider/product_provider.dart';
import 'package:cubit_products/data/repository/product_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Mockito tarafından oluşturulacak Mock sınıfının oluşturulması için
@GenerateMocks([ProductProvider])
import 'product_repository_test.mocks.dart';

void main() {
  late MockProductProvider mockProductProvider;
  late ProductRepository productRepository;

  setUp(() {
    mockProductProvider = MockProductProvider();
    productRepository = ProductRepository(mockProductProvider);
  });

  // Arrange
      final responsePayload = [
        ProductModel(
          id: 1,
          title: "Test Product 1",
          price: 10.0,
          description: "Test description 1",
          category: "Test category",
          image: "https://example.com/image1.jpg",
        ),
        ProductModel(
          id: 2,
          title: "Test Product 2",
          price: 20.0,
          description: "Test description 2",
          category: "Test category",
          image: "https://example.com/image2.jpg",
        ),
      ];

      when(mockProductProvider.getProducts()).thenAnswer((_) async => responsePayload);

  group('ProductRepository Tests', () {
    test('getProducts returns a list of products from ProductProvider', () async {

      final products = await productRepository.getProducts();
      expect(products, isA<List<ProductModel>>());
      expect(products.length, 2);
      expect(products[0].title, "Test Product 1");
    });

    test('getProductDetail returns a product detail from ProductProvider', () async {
      
      final responsePayload = ProductModel(
        id: 1,
        title: "Test Product 1",
        price: 10.0,
        description: "Test description 1",
        category: "Test category",
        image: "https://example.com/image1.jpg",
      );

      when(mockProductProvider.getProductDetail(1)).thenAnswer((_) async => responsePayload);

      
      final product = await productRepository.getProductDetail(1);

      
      expect(product, isA<ProductModel>());
      expect(product.title, "Test Product 1");
    });
  });
}
