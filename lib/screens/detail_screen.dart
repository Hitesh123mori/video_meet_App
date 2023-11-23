import 'dart:io';
import 'package:flutter/material.dart' ;
import 'package:image_picker/image_picker.dart';
import 'package:zoom_clone/custom_widgets/button.dart';
import 'package:zoom_clone/effects/transition4.dart';
import 'package:zoom_clone/screens/greet_screen.dart';
import 'package:zoom_clone/screens/splash_screen.dart';
import '../Pallate.dart';
import '../custom_widgets/cutsom_helpers.dart';
import '../resources/Api.dart';


class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

   String?  _image   ;

   TextEditingController _textEditingController = TextEditingController() ;

   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mq  = MediaQuery.of(context).size ;
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.2,
            backgroundColor: AppColors.theme['secondaryColor'],
            centerTitle: true,
            title: Text(
              "Fill Up Details",
              style: TextStyle(color: AppColors.theme['secondaryTextColor'],fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: mq.height*.05,width: mq.width*1,),
                Stack(
                    children: [
                      _image!=null ?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: Image.file(
                          File(_image!),
                          width: mq.width*0.4,
                          height: mq.width*0.4,
                          fit: BoxFit.cover,
                        ),
                      ):
                      CircleAvatar(
                        radius: 75,
                        backgroundColor: Colors.black12,
                      child: Icon(Icons.person,size: 50,color: Colors.white,),
                      ),
                      Positioned(
                        top: mq.height*0.12,
                        left: mq.width*0.25,
                        child: InkWell(
                          onTap: (){
                            showBottomSheet() ;
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.edit,color: Colors.white,),
                            backgroundColor: AppColors.theme['primaryColor'],
                          ),
                        ),
                      )
                    ]
                ),
                SizedBox(height: mq.height*.07,width: mq.width*1,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: mq.width*0.1),
                  child: TextFormField(
                    controller: _textEditingController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Name is required";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Your Name",
                      prefixIconColor: Colors.black,
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius : BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.black,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius : BorderRadius.circular(20),
                         borderSide: BorderSide(
                           color: Colors.black,
                         )
                      ), focusedBorder: OutlineInputBorder(
                          borderRadius : BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.black,
                          )
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius : BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.red,
                          )
                      ),

                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: customButton(onPressed: ()async{
               if (_formKey.currentState!.validate()) {
                 
                 
                 Dialogs.showProgressBar(context) ;
                   await Api.fillDetailsEmailUser(File(_image!),_textEditingController.text).then((value) {
                     Navigator.pushReplacement(context, SizeTransition4(GreetScreen()));
                   }) ;
               }
                  }, text: "Next", textColor: AppColors.theme['primaryTextColor'], buttonColor:AppColors.theme['primaryColor']),
                )
              ],
            ),
          ),
        ),
    );
  }

  void showBottomSheet(){
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )
        ),
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
                    child: Text("Pick Profile picture",
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: AppColors.theme['secondaryTextColor']),
                    ),
                  ),
                ),
                Padding(
                  padding:EdgeInsets.all(28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Material(
                            elevation: 2,
                            child: InkWell(
                              onTap: ()async{
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(source: ImageSource.camera);
                                if(image!=null){
                                  print("path : " + image.name + "   Mime type : ${image.mimeType}") ;
                                  Navigator.pop(context);

                                  setState(() {
                                    _image = image.path;
                                  });

                                }

                              },
                              child: Image.asset("assets/images/camara.png",width: 70,height: 70,),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("Camara",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.theme['secodaryTextColor']),)
                        ],
                      ),

                      SizedBox(width: mq.height*0.07,),
                      Column(
                        children: [
                          Material(
                            elevation: 2,
                            child: InkWell(
                              onTap: ()async{
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                if(image!=null){
                                  print("path : " + image.name + "   Mime type : ${image.mimeType}") ;
                                  Navigator.pop(context);

                                  setState(() {
                                    _image = image.path;
                                  });

                                }

                              },
                              child: Image.asset("assets/images/gallary.png",width: 70,height: 70,),
                            ),

                          ),
                          SizedBox(height: 10,),
                          Text("Gallary",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.theme['secodaryTextColor']),)
                        ],
                      )
                    ],
                  ),
                )

              ],
            ),
          ) ;
        }

    );
  }
}
