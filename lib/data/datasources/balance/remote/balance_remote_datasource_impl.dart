import 'package:grizbee/data/abstraction/balance_remote_datasource.dart';
import 'package:grizbee/data/datasources/mock_balance.dart';
import 'package:grizbee/data/datasources/mock_constants.dart';
import 'package:grizbee/domain/exceptions/balance_exception.dart';
import 'package:grizbee/domain/exceptions/deposit_exception.dart';

class BalanceRemoteDatasourceImpl implements BalanceRemoteDatasource {
  @override
  Future<double> getBalance() async {
    // Simulation : fetching data from API
    return Future.delayed(Duration(seconds: FetchDataDelay.remote), () async {
      // Get balance from local mock
      try {
        return mockBalance;
      } catch (error) {
        throw (BalanceException());
      }
    });
  }

  @override
  Future<double> updateBalance(double amount) {
    // Simulation : fetching data from API
    return Future.delayed(Duration(seconds: FetchDataDelay.remote), () async {
      // Update local value
      try {
        mockBalance += amount;
        return mockBalance;
      } catch (error) {
        throw (DepositException());
      }
    });
  }
}
