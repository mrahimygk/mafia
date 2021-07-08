import 'package:mafia/domain/model/coin/exchange_rate.dart';
import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/repository/coins/exchange_rates_repository.dart';

abstract class GetCoinRatesUseCase extends BaseUseCase<String, List<ExchangeRate>> {
  final ExchangeRatesRepository _repository;

  GetCoinRatesUseCase(this._repository);
}

class GetCoinRatesUseCaseImpl extends GetCoinRatesUseCase {
  GetCoinRatesUseCaseImpl(ExchangeRatesRepository repository) : super(repository);

  @override
  Stream<ApiResource<List<ExchangeRate>>> execute(String request) =>
      _repository.getExchangeRatesForCoin(request);
}
