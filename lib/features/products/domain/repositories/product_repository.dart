import 'package:dartz/dartz.dart';
import 'package:product_cart_app/core/error/failures.dart';
import 'package:product_cart_app/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
}
