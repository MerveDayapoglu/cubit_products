import 'package:cubit_products/data/model/product_model.dart';
import 'package:cubit_products/data/provider/product_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Mockito tarafından oluşturulacak Mock sınıfının oluşturulması için

@GenerateMocks([Dio])
import 'product_provider_test.mocks.dart';

void main() {
  late MockDio mockDio;
  late ProductProvider productProvider;
  //Her test öncesinde çalışacak hazırlık işlemleri 
  setUp(() {
    mockDio = MockDio();
    productProvider = ProductProvider();
    productProvider.dio =
        mockDio; 

    // Mockito'ya isteklerin nasıl cevap vereceğini belirtme
    //when(mockDio.get("products")): mockDio üzerinde get metodunu çağırıldığında nasıl cevap vermesi gerektiği belirtilir.
    //thenAnswer: Metodun ne döndüreceği belirtilir, burada Response nesnesi ile simüle edilmiş bir HTTP yanıtı verilir.
    when(mockDio.get("products")).thenAnswer(
      (_) async => Response(
        data: [
          {
            "id": 1,
            "title": "Test Product 1",
            "price": 10.0,
            "description": "Test description 1",
            "category": "Test category",
            "image": "https://example.com/image1.jpg"
          },
          {
            "id": 2,
            "title": "Test Product 2",
            "price": 20.0,
            "description": "Test description 2",
            "category": "Test category",
            "image": "https://example.com/image2.jpg"
          },
        ],
        statusCode: 200,
        requestOptions: RequestOptions(path: 'products'),
      ),
    );

    when(mockDio.get("products/1")).thenAnswer(
      (_) async => Response(
        data: {
          "id": 1,
          "title": "Test Product 1",
          "price": 10.0,
          "description": "Test description 1",
          "category": "Test category",
          "image": "https://example.com/image1.jpg"
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: 'products/1'),
      ),
    );
  });

  group('ProductProvider Tests', () {
    test('getProducts returns a list of products', () async {
      // Act
      final products = await productProvider.getProducts();

      // Assert
      expect(products, isA<List<ProductModel>>());
      expect(products.length, 2);
      expect(products[0].title, "Test Product 1");
    });

    test('getProductDetail returns a product detail', () async {
      // Act
      final product = await productProvider.getProductDetail(1);

      // Assert
      expect(product, isA<ProductModel>());
      expect(product.title, "Test Product 1");
    });
  });
}
