import 'package:grizbee/domain/entities/contact.dart';

abstract class ContactLocalDatasource {
  Future<List<Contact>> getContacts();
}
