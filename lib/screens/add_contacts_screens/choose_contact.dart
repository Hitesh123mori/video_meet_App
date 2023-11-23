import 'package:flutter/material.dart';
import 'package:zoom_clone/custom_widgets/button.dart';
import 'package:zoom_clone/pallate.dart';

import '../../custom_widgets/user_card.dart';
import '../../resources/Api.dart';
import '../../resources/models/user.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  List<MeetUser> list = [];
  Map<String, bool> userCheckStates = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
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
        body: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(
              child: StreamBuilder(
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
                          child: Text(
                            "No Users",
                            style: TextStyle(fontSize: 25, color: Colors.grey),
                          ),
                        )
                            : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: list.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final user = list[index];
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
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 36),
              child: customButton(
                onPressed: () async {
                  List<MeetUser> selectedUsers = userCheckStates.entries
                      .where((entry) => entry.value)
                      .map((entry) => list[int.parse(entry.key.split('_').last)])
                      .toList();
                  await Api.addContacts(selectedUsers).then((value)async{
                    await Api.fetchSelectionContactsByAttribute(selectedUsers).then((value) {
                      Navigator.pop(context);
                    });
                  });
                }, text: 'Add Contacts', textColor: AppColors.theme['primaryTextColor'], buttonColor: AppColors.theme['primaryColor'],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
