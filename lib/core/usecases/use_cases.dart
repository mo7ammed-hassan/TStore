// ignore: avoid_types_as_parameter_names
abstract class UseCases<Type, Parmas> {
  Future<Type> call({Parmas params});
}
