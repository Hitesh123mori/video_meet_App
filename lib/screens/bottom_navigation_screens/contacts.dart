import 'package:flutter/material.dart';
import 'package:zoom_clone/effects/Transition1.dart';

import '../../Pallate.dart';
import '../../custom_widgets/contact_card.dart';
import '../../resources/Api.dart';
import '../../resources/models/user.dart';
import '../add_contacts_screens/choose_contact.dart';
import '../splash_screen.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {

  List<MeetUser> list = [] ;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor:Colors.grey.shade100,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.theme['primaryColor'],
          child: Icon(Icons.person_add_alt_1_rounded,color: Colors.white,),
          onPressed: (){
            Navigator.push(context, SizeTransition1(AllUsers())) ;
          },
        ),
        body:SafeArea(
          child: StreamBuilder(
                stream: Api.getYourContact(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                    // return const Center(
                    //   child: CircularProgressIndicator(),
                    // );
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                      list = data?.map((e) => MeetUser.fromJson(e.data())).toList() ??
                          [];
                
                      print("#length :  ${list.length}");
                
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                        child: list.isEmpty
                            ? Center(
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: mq.height*0.35),
                            child: Text(
                              "No Contacts",
                              style: TextStyle(fontSize: 25, color: Colors.blueGrey),
                            ),
                          ),
                        )
                            : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: list.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                
                            return ContactCard(user: list[index],) ;
                
                          },
                        ),
                      );
                  }
                },
              ),
        ),
      
      ),
    );
  }
}
