import 'package:flutter/material.dart';
import 'package:zoom_clone/Pallate.dart';

import '../history/created_history.dart';
import '../history/joined_history.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
             title: TabBar(
               physics: BouncingScrollPhysics(),
                labelColor : AppColors.theme['primaryColor'],
                indicatorColor:AppColors.theme['primaryColor'],
                tabs: [
                Tab(text: 'Created'),
                Tab(text: 'Joined'),
            ],
            ),
          ),
          backgroundColor:Colors.grey.shade100,
          body: TabBarView(
            children: [
              Created(),
              Joined(),
            ],
          ),
        ),
      ),
    );;
  }
}
