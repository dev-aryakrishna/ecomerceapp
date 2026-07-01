import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecomerceapp/dependency_injection/injection.dart';
import'package:ecomerceapp/features/products/presentation/bloc/product_detail/product_detail_bloc.dart';
import'package:ecomerceapp/features/products/presentation/bloc/product_detail/product_detail_event.dart';
import'package:ecomerceapp/features/products/presentation/bloc/product_detail/product_detail_state.dart';

class ProductDetailScreen extends StatelessWidget{
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductDetailBloc>()..add(FetchProductDetailRequested(productId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Product Detail')),
        body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailLoaded) {
              final product = state.product;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Image.network(
                      product.thumbnail, 
                      width: double.infinity, 
                      height: 200, 
                      fit: BoxFit.cover
                    ),

                    const SizedBox(height: 16),

                    Text(product.title, 
                      style: const TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold
                      )),

                    const SizedBox(height: 8),

                    Text(
                      '\$${product.price}',  
                        style: const TextStyle(fontSize: 20)
                    ),

                    const SizedBox(height: 8),
                    
                    Text('Rating : ${product.rating}'),
                    const SizedBox(height: 16),
                    Text(product.description),
                  ],
                ),
              );
            } else if (state is ProductDetailError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}