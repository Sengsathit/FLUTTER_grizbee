import 'package:grizbee/data/abstraction/transaction_local_datasource.dart';
import 'package:grizbee/data/datasources/mock_constants.dart';
import 'package:grizbee/data/datasources/mock_transactions.dart';
import 'package:grizbee/domain/entities/transaction.dart';
import 'package:grizbee/domain/exceptions/transaction_exception.dart';

class TransactionLocalDatasourceImpl implements TransactionLocalDatasource {
  @override
  Future<Transaction> getTransactionToPay() {
    // Simulation : fetching data from local data storage
    return Future.delayed(Duration(seconds: FetchDataDelay.local), () async {
      try {
        return generateRandomTransaction(isToPay: true);
      } catch (error) {
        throw (TransactionToPayException());
      }
    });
  }

  @override
  Future<List<Transaction>> getTransactions() {
    // Simulation : fetching data from local data storage
    return Future.delayed(Duration(seconds: FetchDataDelay.local), () async {
      try {
        if (mockTransactions.isEmpty) {
          mockTransactions = generateRandomTransactions(isToPay: false);
        }

        return mockTransactions;
      } catch (error) {
        throw (TransactionsException());
      }
    });
  }
}
