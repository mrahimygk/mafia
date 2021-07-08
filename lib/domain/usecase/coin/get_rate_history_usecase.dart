import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/coin/rate_history.dart';
import 'package:mafia/domain/model/coin/rate_history_request.dart';
import 'package:mafia/repository/coins/exchange_rates_repository.dart';

abstract class GetRateHistoryUseCase
    extends BaseUseCase<RateHistoryRequest, List<RateHistory>> {
  final ExchangeRatesRepository _repository;

  GetRateHistoryUseCase(this._repository);
}

class GetRateHistoryUseCaseImpl extends GetRateHistoryUseCase {
  GetRateHistoryUseCaseImpl(ExchangeRatesRepository repository)
      : super(repository);

  @override
  Stream<ApiResource<List<RateHistory>>> execute(RateHistoryRequest request) =>
      _repository.getRateHistoryForTwoCoins(request);
}
