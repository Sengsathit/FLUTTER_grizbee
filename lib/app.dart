import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:grizbee/domain/blocs/balance/balance_bloc.dart';
import 'package:grizbee/domain/blocs/contact/contact_bloc.dart';
import 'package:grizbee/domain/blocs/scanner/scanner_bloc.dart';
import 'package:grizbee/domain/blocs/transaction/transaction_bloc.dart';
import 'package:grizbee/presentation/internationalization/translation_delegate.dart';
import 'package:grizbee/presentation/pages/app_content.dart';

// This widget instantiate the app by :
// - setting up the theme
// - providing all required blocs (MultiBlocProvider)
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Color(0xFFff5252),
        splashColor: Colors.transparent, // Disable default widget splash effect
        highlightColor: Colors.transparent, // Disable default widget splash effect
      ),
      localizationsDelegates: [
        TranslationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('fr', ''),
      ],
      // Provide all the blocs needed in the children widget
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ScannerBloc>(
            create: (BuildContext context) => ScannerBloc(),
          ),
          BlocProvider<TransactionBloc>(
            create: (BuildContext context) => TransactionBloc(),
          ),
          BlocProvider<TransactionContactBloc>(
            create: (BuildContext context) => TransactionContactBloc(),
          ),
          BlocProvider<TransactionPaymentBloc>(
            create: (BuildContext context) => TransactionPaymentBloc(),
          ),
          BlocProvider<BalanceBloc>(
            create: (BuildContext context) => BalanceBloc(),
          ),
          BlocProvider<ContactBloc>(
            create: (BuildContext context) => ContactBloc(),
          ),
        ],
        child: AppContent(),
      ),
    );
  }
}
