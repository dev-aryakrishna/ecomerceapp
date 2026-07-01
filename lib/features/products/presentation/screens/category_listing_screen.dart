import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecomerceapp/dependency_injection/injection.dart';
import 'package:ecomerceapp/features/products/presentation/bloc/categories/categories_bloc.dart';
import 'package:ecomerceapp/features/products/presentation/bloc/categories/categories_event.dart';
import 'package:ecomerceapp/features/products/presentation/bloc/categories/categories_state.dart';
import 'package:go_router/go_router.dart';


class CategoryListingScreen extends StatelessWidget {
  const CategoryListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CategoriesBloc>()..add(FetchCategoriesRequested()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Category Listing')),
        body: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoriesLoaded) {
              return ListView.builder(
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return ListTile(
                    title: Text(category),
                    onTap: () {
                      // Handle category selection
                    },
                  );
                },
              );
            } else if (state is CategoriesError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

