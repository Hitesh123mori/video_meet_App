import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zoom_clone/custom_widgets/button.dart';
import '../../Pallate.dart';
import '../../custom_widgets/CustomUserInfoCard.dart';
import '../../resources/Api.dart';
import '../../resources/my_custom_date.dart';
import '../splash_screen.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String ?  _image ;
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 13.0),
          child: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left_outlined,
              size: 32,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        elevation: 0.2,
        backgroundColor: Colors.grey.shade900,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(color: AppColors.theme['primaryTextColor']),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.logout),
        label: Text("LOGOUT"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: AppColors.theme['primaryColor'],
        onPressed: ()  {
          Api.signOut(context);
        },
      ),
      body: Column(
        children: [
          SizedBox(
            height: mq.height * .05,
            width: mq.width * 1,
          ),
          Stack(children: [
            _image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: Image.file(
                      File(_image!),
                      width: mq.width * 0.4,
                      height: mq.width * 0.4,
                      fit: BoxFit.cover,
                    ),
                  )
                : CircleAvatar(
                     radius: 75,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: NetworkImage( Api.curUser!.image),
                  ),
            Positioned(
              top: mq.height * 0.13,
              left: mq.width * 0.29,
              child: InkWell(
                onTap: () {
                  showBottomSheet();
                },
                child: CircleAvatar(
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.black,
                ),
              ),
            )
          ]),
          SizedBox(
            height: mq.height * .07,
            width: mq.width * 1,
          ),
          CustomUserInfoCard(header: 'Your Name', text: Api.curUser!.name,),
          Divider(height: 0.5,),
          CustomUserInfoCard(header: 'Your Email', text: Api.curUser!.email,),
          Divider(height: 0.5,),
          CustomUserInfoCard(header: 'Sign in via', text: Api.curUser!.method,),
          Divider(height: 0.5,),
          CustomUserInfoCard(header: 'Joined on', text: MyDateUtil.getFormattedTime3(context: context, time: Api.curUser!.createdAt),),
          SizedBox(height: 30,),
          customButton(onPressed: (){}, text: "Update Profile Picture", textColor: AppColors.theme['primaryTextColor'], buttonColor: AppColors.theme['primaryColor']),

        ],
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.theme['backgroundColor'],
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      "Pick Profile picture",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.theme['secondaryTextColor']),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Material(
                            elevation: 2,
                            child: InkWell(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.camera);
                                if (image != null) {
                                  print("path : " +
                                      image.name +
                                      "   Mime type : ${image.mimeType}");
                                  Navigator.pop(context);

                                  setState(() {
                                    _image = image.path;
                                  });
                                }
                              },
                              child: Image.asset(
                                "assets/images/camara.png",
                                width: 70,
                                height: 70,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Camara",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.theme['secodaryTextColor']),
                          )
                        ],
                      ),
                      SizedBox(
                        width: mq.height * 0.07,
                      ),
                      Column(
                        children: [
                          Material(
                            elevation: 2,
                            child: InkWell(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  print("path : " +
                                      image.name +
                                      "   Mime type : ${image.mimeType}");
                                  Navigator.pop(context);

                                  setState(() {
                                    _image = image.path;
                                  });
                                }
                              },
                              child: Image.asset(
                                "assets/images/gallary.png",
                                width: 70,
                                height: 70,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Gallary",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.theme['secodaryTextColor']),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
