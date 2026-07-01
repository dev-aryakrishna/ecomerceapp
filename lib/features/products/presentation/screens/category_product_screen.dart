import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecomerceapp/dependency_injection/injection.dart';
import'package:ecomerceapp/features/products/presentation/bloc/products/products_bloc.dart';
import'package:ecomerceapp/features/products/presentation/bloc/products/products_event.dart';
import'package:ecomerceapp/features/products/presentation/bloc/products/products_state.dart';

class CategoryProductScreen extends StatelessWidget{
  
  final String category;

  const CategoryProductScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductsBloc>()..add(FetchProductsByCategoryRequested(category)),
      child: Scaffold(
        appBar: AppBar(title: Text('Products in $category')),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsLoaded) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ListTile(
                    title: Text(product.title),
                    subtitle: Text('\$${product.price}'),
                    onTap: () {
                      // Handle product selection
                    },
                  );
                },
              );
            } else if (state is ProductsError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}