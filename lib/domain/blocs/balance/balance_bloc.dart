import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:grizbee/domain/abstraction/balance_repository.dart';
import 'package:grizbee/domain/exceptions/balance_exception.dart';
import 'package:grizbee/domain/exceptions/deposit_exception.dart';

part 'balance_event.dart';

part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final balanceRepository = GetIt.instance.get<BalanceRepository>();

  BalanceBloc() : super(BalanceInitial());

  @override
  Stream<BalanceState> mapEventToState(BalanceEvent event) async* {
    try {
      switch (event.runtimeType) {
        case GetBalanceEvent:
          yield BalanceLoading();
          final balance = await balanceRepository.getBalance();
          yield BalanceLoaded(balance);
          break;

        case DepositFundsEvent:
          yield FundsDepositProcessing();
          final amount = (event as DepositFundsEvent).amount;
          final balance = await balanceRepository.updateBalance(amount);
          yield FundsDepositProceeded(balance);
          break;
      }
    } catch (error) {
      switch (error.runtimeType) {
        case BalanceException:
          yield BalanceFailure((error as BalanceException).message);
          break;
        case DepositException:
          yield FundsDepositFailure((error as DepositException).message);
          break;
      }
    }
  }
}
