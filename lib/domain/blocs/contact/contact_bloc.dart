import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:grizbee/domain/abstraction/contact_repository.dart';
import 'package:grizbee/domain/entities/contact.dart';
import 'package:grizbee/domain/exceptions/contact_exception.dart';
import 'package:meta/meta.dart';

part 'contact_event.dart';

part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final contactRepository = GetIt.instance.get<ContactRepository>();

  ContactBloc() : super(ContactInitial());

  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    try {
      switch (event.runtimeType) {
        case GetContactsEvent:
          yield ContactsLoading();
          final contacts = await contactRepository.getContacts();
          yield ContactsLoaded(contacts);
          break;
      }
    } catch (error) {
      switch (error.runtimeType) {
        case ContactException:
          yield GetContactsFailure((error as ContactException).message);
          break;
      }
    }
  }
}
