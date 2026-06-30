import 'package:ecomerceapp/features/products/domain/entities/product_entity.dart';
import 'package:ecomerceapp/features/products/domain/repositories/product_repository.dart';

class GetCategoriesUsecase {

  final ProductRepository repository;

  GetCategoriesUsecase(this.repository);

  Future<List<String>> call(){
    return repository.getCategories();
  }

}

