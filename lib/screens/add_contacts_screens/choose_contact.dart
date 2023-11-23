import 'package:flutter/material.dart';
import 'package:zoom_clone/custom_widgets/button.dart';
import 'package:zoom_clone/pallate.dart';

import '../../custom_widgets/user_card.dart';
import '../../resources/Api.dart';
import '../../resources/models/user.dart';
import '../splash_screen.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  List<MeetUser> list = [];
  Map<String, bool> userCheckStates = {};
  List<MeetUser> result = [] ;

  bool isSearching = false ;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          actions: [
            buildActions(),
          ],
          title: Text(
            "Add Contacts",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left_outlined,
              size: 32,
              color: Colors.white,
            ),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    isSearching = !isSearching ;
                  });
                },
                child: Container(
                  height: 50,
                  child: Row(
                    children: [
                      SizedBox(width:mq.width*0.065,),
                      Icon(Icons.search),
                      SizedBox(width:mq.width*0.065,),
                      Container(
                        width: 220,
                        child: TextFormField(
                          onChanged: (val){
                            result.clear();
                            for (var i in list){
                              if(i.name.toLowerCase().contains(val.toLowerCase())||i.email.toLowerCase().contains(val.toLowerCase())){
                                result.add(i) ;
                              }
                              setState(() {
                                ;
                              });
                            }


                          },
                          enabled: isSearching ? true :false,
                          decoration: InputDecoration(
                            hintText: "Search Contacts",
                            enabledBorder:InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          autofocus: true,
                          autocorrect: true,
                        ),
                      ),
                      if(isSearching)
                        IconButton(onPressed: (){
                          setState(() {
                            isSearching  =!isSearching ;
                          });
                        }, icon: Icon(Icons.cancel_outlined))

                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200,
                  ),
                ),
              ),
            ),


            StreamBuilder(
              stream: Api.getAllUsers(),
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
                          padding:  EdgeInsets.symmetric(vertical: mq.height*0.34),
                          child: Text(
                            "No Contacts",
                            style: TextStyle(fontSize: 25, color: Colors.blueGrey),
                          ),
                        ),
                      )
                          : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: isSearching ? result.length : list.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final user = isSearching ? result[index] : list[index];
                          final isChecked = userCheckStates['isChecked_$index'] ?? false;

                          return UserCard(
                            user: user,
                            isChecked: isChecked,
                            onChanged: (bool value) {
                              setState(() {
                                userCheckStates['isChecked_$index'] = value;

                              });
                            },
                          );
                        },
                      ),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActions() {
    List<MeetUser> selectedUsers = userCheckStates.entries
        .where((entry) => entry.value)
        .map((entry) => list[int.parse(entry.key.split('_').last)])
        .toList();

    if (selectedUsers.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(right: 18.0),
        child: IconButton(
          icon: Icon(Icons.done,color: Colors.white,),
          onPressed: () async {

            List<MeetUser> selectedUsers = userCheckStates.entries
                .where((entry) => entry.value)
                .map((entry) => list[int.parse(entry.key.split('_').last)])
                .toList();
            await Api.addContacts(selectedUsers).then((value)async{
                Navigator.pop(context);
            });

          },
        ),
      );
    } else {
      return Container();
    }
  }
}
