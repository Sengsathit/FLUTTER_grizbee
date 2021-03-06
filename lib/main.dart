import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:grizbee/app.dart';
import 'package:grizbee/data/abstraction/balance_local_datasource.dart';
import 'package:grizbee/data/abstraction/balance_remote_datasource.dart';
import 'package:grizbee/data/abstraction/contact_local_datasource.dart';
import 'package:grizbee/data/abstraction/contact_remote_datasource.dart';
import 'package:grizbee/data/abstraction/transaction_local_datasource.dart';
import 'package:grizbee/data/abstraction/transaction_remote_datasource.dart';
import 'package:grizbee/data/datasources/balance/local/balance_local_datasource_impl.dart';
import 'package:grizbee/data/datasources/balance/remote/balance_remote_datasource_impl.dart';
import 'package:grizbee/data/datasources/contact/contact_local_datasource_impl.dart';
import 'package:grizbee/data/datasources/contact/contact_remote_datasource_impl.dart';
import 'package:grizbee/data/datasources/transaction/local/transaction_local_datasource_impl.dart';
import 'package:grizbee/data/datasources/transaction/remote/transaction_remote_datasource_impl.dart';
import 'package:grizbee/data/repositories/balance_repository_impl.dart';
import 'package:grizbee/data/repositories/contact_repository_impl.dart';
import 'package:grizbee/data/repositories/transaction_repository_impl.dart';
import 'package:grizbee/domain/abstraction/balance_repository.dart';
import 'package:grizbee/domain/abstraction/contact_repository.dart';
import 'package:grizbee/domain/abstraction/transaction_repository.dart';
import 'package:grizbee/domain/blocs/blocs_observer.dart';

// This main file aims to  :
// - initiate the service locator, required for making clean the app architecture which is based on repository pattern
// - setting up observation of the blocs for debug mode
// - instantiate the app
void main() {
  setServiceLocator();

  if (!kReleaseMode) Bloc.observer = GrizBeeBlocObserver();

  runApp(App());
}

void setServiceLocator() {
  GetIt.instance.registerSingleton<TransactionRemoteDatasource>(TransactionRemoteDatasourceImpl());
  GetIt.instance.registerSingleton<TransactionLocalDatasource>(TransactionLocalDatasourceImpl());
  GetIt.instance.registerSingleton<BalanceRemoteDatasource>(BalanceRemoteDatasourceImpl());
  GetIt.instance.registerSingleton<BalanceLocalDatasource>(BalanceLocalDatasourceImpl());
  GetIt.instance.registerSingleton<ContactRemoteDatasource>(ContactRemoteDatasourceImpl());
  GetIt.instance.registerSingleton<ContactLocalDatasource>(ContactLocalDatasourceImpl());
  GetIt.instance.registerSingleton<BalanceRepository>(BalanceRepositoryImpl());
  GetIt.instance.registerSingleton<TransactionRepository>(TransactionRepositoryImpl());
  GetIt.instance.registerSingleton<ContactRepository>(ContactRepositoryImpl());
}
