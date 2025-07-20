import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:product_cart_app/core/error/failures.dart';
import 'package:product_cart_app/core/usecases/usecase.dart';
import 'package:product_cart_app/features/auth/domain/entities/user.dart';
import 'package:product_cart_app/features/auth/domain/repositories/auth_repository.dart';

class SignUp implements UseCase<User, SignUpParams> {
  final AuthRepository repository;

  SignUp(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await repository.signUp(params.email, params.password);
  }
}

class SignUpParams extends Equatable {
  final String email;
  final String password;

  const SignUpParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
