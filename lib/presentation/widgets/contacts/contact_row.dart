import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grizbee/domain/entities/contact.dart';
import 'package:grizbee/presentation/widgets/avatars/contact_avatar.dart';

// This widget provides row for list of contacts
class ContactRow extends StatelessWidget {
  final Contact contact;

  ContactRow({required this.contact});

  @override
  Widget build(BuildContext context) {
    String contactPicture = contact.picture ?? '';
    return Column(
      children: [
        SizedBox(height: 20),
        ContactAvatar(picture: contactPicture),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(contact.name, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(contact.email, style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
