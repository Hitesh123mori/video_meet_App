import 'package:flutter/material.dart' ;
import 'package:zoom_clone/resources/Api.dart';
import 'package:zoom_clone/resources/models/user.dart';

class Setting extends StatefulWidget {


  const Setting({super.key,});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  void initState(){
    super.initState() ;
    Api.getSelfData(Api.user.uid) ;
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor:Colors.grey.shade100,
        body:Column(
          children: [
            InkWell(
              onTap: (){
                Api.signOut(context);
              },
              child: Card(
                elevation: 0.2,
                child: ListTile(
                  title: Text(Api.curUser!.name),
                  subtitle: Text(Api.curUser!.email),
                  leading: CircleAvatar(
                    radius: 40,
                    child: Image.network(Api.curUser!.image),
                ),
              ),
            ),
            )
          ],
        )
      ),
    );;
  }
}
