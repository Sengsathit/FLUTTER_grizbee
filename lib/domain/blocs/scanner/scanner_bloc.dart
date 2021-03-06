import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'scanner_event.dart';

part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc() : super(ScannerInitial());

  @override
  Stream<ScannerState> mapEventToState(ScannerEvent event) async* {
    switch (event.runtimeType) {
      case ScannerSuccessEvent:
        yield ScannerSuccess((event as ScannerSuccessEvent).scannerResult);
        break;

      case ScannerFailureEvent:
        yield ScannerFailure();
        break;

      case ScannerAbortEvent:
        yield ScannerAbort();
        break;
    }
  }
}
