import 'package:cubit_products/cubit_product/product_cubit.dart';
import 'package:cubit_products/data/model/product_model.dart';
import 'package:cubit_products/data/repository/product_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

// Mockito tarafından oluşturulacak Mock sınıfının oluşturulması için
@GenerateMocks([ProductRepository])
import 'product_cubit_test.mocks.dart';

void main() {
  late MockProductRepository mockProductRepository;
  late ProductCubit productCubit;

  setUp(() {
    mockProductRepository = MockProductRepository();
    productCubit = ProductCubit(mockProductRepository);
  });

  tearDown(() {
    productCubit.close();
  });

  group('ProductCubit Tests', () {
    test('Initial state is ProductInitialState', () {
      // Assert
      expect(productCubit.state, isA<ProductInitialState>());
    });

    //blocTest fonksiyonu, BLoC veya Cubit testleri yazarken kullanılır. blocTest, belirli bir eylemi tetiklediğinizde BLoC/Cubit'in hangi durumları yaymasını beklediğinizi belirtmenizi sağlar.

    blocTest<ProductCubit, ProductState>(      // ProductCubit'in ProductState durumları yaymasını beklediğinizi belirtir.
      'emits [ProductSuccessState] when getProducts is successful',
      build: () {   //build: Bu, test sırasında kullanılacak olan Cubit'in veya BLoC'un örneğini döndürür
        when(mockProductRepository.getProducts()).thenAnswer(
          (_) async => [
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
          ],
        );
        return productCubit;
      },
      //act Cubit üzerinde gerçekleştirilecek olan eylemi belirtir. Burada, cubit.getProducts() çağrısı yaparak ürünleri yüklemeyi simüle ediyoruz.
      act: (cubit) => cubit.getProducts(),   
      expect: () => [   //expect belirli bir eylem gerçekleştirildikten sonra Cubit'in hangi durumları yaymasını beklediğimizi belirtir.
        isA<ProductSuccessState>().having(  //isA<ProductSuccessState>() ile ProductSuccessState türünde bir durum yayılmasını bekliyoruz.
          (state) => state.productModel.length,
          'productModel length',
          2,
        ),
      ],
    );
//having((state) => state.productModel.length, 'productModel length', 2): ProductSuccessState durumunda, productModel listesinin uzunluğunun 2
  //olmasını bekliyoruz. Bu, yukarıda belirttiğimiz sahte ürün listesine dayanarak belirlenmiştir.
    blocTest<ProductCubit, ProductState>(
      'emits [ProductErrorState] when getProducts fails',
      build: () {
        when(mockProductRepository.getProducts())
        .thenThrow(Exception('Failed to fetch products'));
        return productCubit;
      },
      act: (cubit) => cubit.getProducts(),
      expect: () => [
        isA<ProductErrorState>().having(
          (state) => state.error,
          'error message',
          'Exception: Failed to fetch products',
        ),
      ],
    );
  });
}
