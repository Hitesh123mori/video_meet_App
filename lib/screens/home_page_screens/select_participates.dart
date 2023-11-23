import 'package:flutter/material.dart' ;
import 'package:zoom_clone/screens/home_page_screens/schedule_meeting.dart';

import '../../Pallate.dart';
import '../../custom_widgets/user_card.dart';
import '../../effects/Transition2.dart';
import '../../effects/transition4.dart';
import '../../resources/Api.dart';
import '../../resources/models/user.dart';
import '../home_screen.dart';
import '../splash_screen.dart';


List<MeetUser> selectedFinalUsers = [] ;

class SelectPartcipate extends StatefulWidget {
  const SelectPartcipate({super.key});

  @override
  State<SelectPartcipate> createState() => _SelectPartcipateState();
}

class _SelectPartcipateState extends State<SelectPartcipate> {




  Map<String, bool> userCheckStates = {};

  List<MeetUser> list = [] ;
  bool isSearching = false ;
  List<MeetUser> result = [] ;


  @override
  Widget build(BuildContext context) {
    mq  = MediaQuery.of(context).size ;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            buildActions(),
          ],
          leading: Padding(
            padding: const EdgeInsets.only(left: 13.0),
            child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left_outlined,
                color: AppColors.theme['secondaryTextColor'],
                size: 32,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context, SizeTransition2(ScheduledMeeting()));
              },
            ),
          ),
          elevation: 0.2,
          centerTitle: true,
          title: Text(
            "Select Paricipates",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.theme['secondaryTextColor']),
          ),
        ),
      body:ListView(
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
                        padding:  EdgeInsets.symmetric(vertical: mq.height*0.34),
                        child: Text(
                          "No Contacts",
                          style: TextStyle(fontSize: 25, color: Colors.blueGrey),
                        ),
                      ),
                    )
                        :  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: isSearching ? result.length:list.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return UserCard(
                          user: isSearching ? result[index]: list[index],
                          isChecked: userCheckStates['isChecked_$index'] ?? false,
                          onChanged: (bool value) {
                            setState(() {
                              userCheckStates['isChecked_$index'] = value;
                            });
                          },
                        ) ;

                      },
                    ),
                  );
              }
            },
          ),
        ],
      )
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
          icon: Icon(Icons.done,color: Colors.black,),
          onPressed: () async {

                selectedFinalUsers = userCheckStates.entries
                .where((entry) => entry.value)
                .map((entry) => list[int.parse(entry.key.split('_').last)])
                .toList();

          },
        ),
      );
    } else {
      return Container();
    }
  }
}
