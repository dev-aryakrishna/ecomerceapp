import 'package:ecomerceapp/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecomerceapp/dependency_injection/injection.dart';
import 'package:ecomerceapp/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:ecomerceapp/features/products/presentation/bloc/products/products_event.dart';
import 'package:ecomerceapp/features/products/presentation/bloc/products/products_state.dart';
import 'package:go_router/go_router.dart';

class StoreListingScreen extends StatelessWidget {
  const StoreListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductsBloc>()..add(FetchProductsRequested()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Store Listing')),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsLoaded) {
              return RefreshIndicator(onRefresh:() async {
                context.read<ProductsBloc>().add(RefreshProductsRequested());
              },
                child: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return ListTile(
                      onTap:(){
                        context.go(RouteNames.productDetail, extra: product.id);
                      },
                      leading : Image.network(
                        product.thumbnail , 
                        width : 50 , 
                        height : 50 , 
                        fit : BoxFit.cover),
                      title: Text(product.title),
                      subtitle: Text('\$${product.price}'),
                      trailing: Text('Rating : ${product.rating}')
                    );
                  },
                ),
              );
            } else if (state is ProductsError) {
              return Center(child: Text(state.message));
            }
            else if (state is ProductsEmpty) {

            return Center(child: Text('no products found'));

            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
