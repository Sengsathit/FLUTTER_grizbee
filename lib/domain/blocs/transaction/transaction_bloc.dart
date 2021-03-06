import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:grizbee/domain/abstraction/transaction_repository.dart';
import 'package:grizbee/domain/entities/contact.dart';
import 'package:grizbee/domain/entities/transaction.dart';
import 'package:grizbee/domain/exceptions/transaction_exception.dart';
import 'package:meta/meta.dart';

part 'transaction_event.dart';

part 'transaction_state.dart';

// Bloc for global transactions
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final transactionRepository = GetIt.instance.get<TransactionRepository>();

  TransactionBloc() : super(TransactionInitial());

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    try {
      switch (event.runtimeType) {
        case GetTransactionsEvent:
          yield TransactionsLoading();
          final transactions = await transactionRepository.getTransactions();
          transactions.sort((a, b) => b.date.compareTo(a.date));
          yield TransactionsLoaded(transactions);
          break;
      }
    } catch (error) {
      switch (error.runtimeType) {
        case TransactionsException:
          yield TransactionsFailure((error as TransactionsException).message);
          break;
      }
    }
  }
}

// Bloc for contact transactions
class TransactionContactBloc extends Bloc<TransactionEvent, TransactionState> {
  final transactionRepository = GetIt.instance.get<TransactionRepository>();

  TransactionContactBloc() : super(TransactionInitial());

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    try {
      switch (event.runtimeType) {
        case GetTransactionsForContactEvent:
          yield TransactionsForContactLoading();
          final transaction = (event as GetTransactionsForContactEvent).transaction;
          final transactions = await transactionRepository.getTransactionsForContact(transaction);
          transactions.sort((a, b) => b.date.compareTo(a.date));
          yield TransactionsForContactLoaded(transactions);
          break;

        case PayContactEvent:
          yield ContactPaymentProcessing();
          final contact = (event as PayContactEvent).contact;
          final amount = (event as PayContactEvent).amount;
          final transaction = await transactionRepository.payContact(contact, amount);
          yield ContactPaymentProceeded(transaction);
          break;

        case RequestFundsEvent:
          yield MoneyRequestProcessing();
          final contact = (event as RequestFundsEvent).contact;
          final amount = (event as RequestFundsEvent).amount;
          await transactionRepository.requestFunds(contact, amount);
          yield MoneyRequestProceeded(amount);
          break;
      }
    } catch (error) {
      switch (error.runtimeType) {
        case TransactionsForContactException:
          yield TransactionsForContactFailure((error as TransactionsForContactException).message);
          break;
        case ContactPaymentException:
          yield ContactPaymentFailure((error as ContactPaymentException).message);
          break;
        case MoneyRequestException:
          yield MoneyRequestFailure((error as MoneyRequestException).message);
          break;
      }
    }
  }
}

// Bloc for transaction payment
class TransactionPaymentBloc extends Bloc<TransactionEvent, TransactionState> {
  final transactionRepository = GetIt.instance.get<TransactionRepository>();

  TransactionPaymentBloc() : super(TransactionInitial());

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    try {
      switch (event.runtimeType) {
        case GetTransactionToPayEvent:
          yield TransactionToPayLoading();
          final transaction = await transactionRepository.getTransactionToPay();
          yield TransactionToPayLoaded(transaction);
          break;

        case PayTransactionEvent:
          yield TransactionPaymentProcessing();
          final transaction = (event as PayTransactionEvent).transaction;
          final returnedTransaction = await transactionRepository.payTransaction(transaction);
          yield TransactionPaymentProceeded(returnedTransaction);
          break;
      }
    } catch (error) {
      switch (error.runtimeType) {
        case TransactionToPayException:
          yield TransactionToPayFailure((error as TransactionToPayException).message);
          break;
        case TransactionPaymentException:
          yield TransactionPaymentFailure((error as TransactionPaymentException).message);
          break;
      }
    }
  }
}
