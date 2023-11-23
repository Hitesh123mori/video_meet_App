import 'package:flutter/material.dart';
import 'package:zoom_clone/Pallate.dart';
import 'package:zoom_clone/resources/models/user.dart';


List<MeetUser> meetuser = [] ;


class UserCard extends StatefulWidget {
  final MeetUser user;
    bool  isChecked = false ;
  final ValueChanged<bool> onChanged;


   UserCard({Key? key, required this.user,  required this.isChecked, required this.onChanged}) : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {




  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          activeColor: AppColors.theme['primaryColor'],
          value: widget.isChecked  ,
          // onChanged: (bool? value) {
          //   setState(() {
          //     widget.isChecked = value ?? false;
          //     meetuser.add(widget.user);
          //   });
          // },
             onChanged: (bool? value) {
              widget.onChanged(value ?? false);
            },
        ),
        title: Text(widget.user.name),
        subtitle: Text(widget.user.email),
      ),
    );
  }
}
