import 'package:cubit_products/cubit_product/product_cubit.dart';
import 'package:cubit_products/data/model/product_model.dart';
import 'package:cubit_products/data/provider/product_provider.dart';
import 'package:cubit_products/data/repository/product_repository.dart';
import 'package:cubit_products/image_view.dart';
import 'package:cubit_products/productdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Demo",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) =>
            ProductCubit(ProductRepository(ProductProvider()))..getProducts(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
        ),
        body: _homeBuildBody());
  }

  BlocBuilder<ProductCubit, ProductState> _homeBuildBody() {
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      switch (state.runtimeType) {
        case (ProductInitialState):
          return const Center(
            child: CircularProgressIndicator(),
          );
        case (ProductSuccessState):
          (state as ProductSuccessState);
          List<ProductModel> productModel = state.productModel;
          // ignore: unnecessary_null_comparison
          return productModel.isNotEmpty
              ? ListView.builder(
                  itemCount: productModel.length,
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.2),
                                offset: const Offset(0, 4),
                                blurRadius: 20),
                          ]),
                      duration: const Duration(milliseconds: 600),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailPage(
                                  productId: productModel[index].id),
                            ),
                          );
                        },
                        trailing: Text('${productModel[index].price} ₺',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        title: Text(productModel[index].title),
                        subtitle:
                            Text('Category: ${productModel[index].category}'),
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => MyWidget(
                                      image: productModel[index].image)),
                            );
                          },
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  productModel[index].image.toString())),
                        ),
                      ),
                    );
                  })
              : const Center(
                  child: Text("No Data found"),
                );
        default:
          return const Center(
            child: Text("Error!"),
          );
      }
    });
  }
}
