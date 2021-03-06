
import 'package:grizbee/domain/entities/contact.dart';

abstract class ContactRepository {
  Future<List<Contact>> getContacts();
}
