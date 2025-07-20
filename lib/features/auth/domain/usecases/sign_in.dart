import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:product_cart_app/core/error/failures.dart';
import 'package:product_cart_app/core/usecases/usecase.dart';
import 'package:product_cart_app/features/auth/domain/entities/user.dart';
import 'package:product_cart_app/features/auth/domain/repositories/auth_repository.dart';

class SignIn implements UseCase<User, SignInParams> {
  final AuthRepository repository;

  SignIn(this.repository);

  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
    return await repository.signIn(params.email, params.password);
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
