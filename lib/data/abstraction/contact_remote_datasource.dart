import 'package:grizbee/domain/entities/contact.dart';

abstract class ContactRemoteDatasource {
  Future<List<Contact>> getContacts();
}
