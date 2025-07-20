import 'package:dartz/dartz.dart';
import 'package:product_cart_app/core/imports/app_imports.dart';
import 'package:product_cart_app/features/cart/domain/repositories/cart_repository.dart';

class GetCartItems implements UseCase<List<CartItem>, NoParams> {
  final CartRepository repository;

  GetCartItems(this.repository);

  @override
  Future<Either<Failure, List<CartItem>>> call(NoParams params) async {
    return await repository.getCartItems();
  }
}
