import 'package:cubit_products/cubit_productdetail/productdetail_cubit.dart';
import 'package:cubit_products/data/provider/product_provider.dart';
import 'package:cubit_products/data/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatelessWidget {
  final int productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailCubit(ProductRepository(ProductProvider()))
            ..getProductDetail(productId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Product Details"),
        ),
        body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case ProductDetailInitialState:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ProductDetailSuccessState:
                (state as ProductDetailSuccessState);
                final product = state.productModel;
                // ignore: unnecessary_null_comparison
                return product != null
                    ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Image.network(
                            product.image,
                            width: 200,
                            height: 200,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Price: ${product.price}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text('Category: ${product.category}'),
                          const SizedBox(height: 8),
                          Text('Description: ${product.description}'),
                        ],
                      ),
                    )
                    : const Center(
                        child: Text("No Data found"),
                      );
              default:
                return const Center(child: Text("Error!"));
            }
          },
        ),
      ),
    );
  }
}
