import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/models/user.dart';

import '../resources/Api.dart';

List<MeetUser> meetuser = [];

class ContactCard extends StatefulWidget {
  final MeetUser user;

  ContactCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:NetworkImage(widget.user.image),
        ),
        title: Text(widget.user.name),
        subtitle: Text(widget.user.email),
        trailing: TextButton(
          onPressed: () async{
                await  Api.fetchContactDetails(widget.user.name).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Contact Delete")));
                });
          },
          child :Text("Delete",style: TextStyle(color: Colors.red),),
        ),
      ),
    );
  }
}
