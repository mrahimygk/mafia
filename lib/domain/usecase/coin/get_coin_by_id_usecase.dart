import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/coin/coin.dart';
import 'package:mafia/repository/coins/coins_repository.dart';

abstract class GetCoinByIdUseCase extends BaseUseCase<String, Coin> {
  final CoinsRepository _repository;

  GetCoinByIdUseCase(this._repository);
}

class GetCoinByIdUseCaseImpl extends GetCoinByIdUseCase {
  GetCoinByIdUseCaseImpl(CoinsRepository repository) : super(repository);

  @override
  Stream<ApiResource<Coin>> execute(String request) =>
      _repository.getCoinById(request);
}
