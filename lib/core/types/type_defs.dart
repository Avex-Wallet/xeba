import 'package:avex_mobile/core/types/failure.dart';
import 'package:fpdart/fpdart.dart';

typedef FutureEither<T> = Future<Either<T, Failure>>;
typedef FutureEitherVoid = FutureEither<void>;
typedef EitherError<T> = Either<T, String>;
