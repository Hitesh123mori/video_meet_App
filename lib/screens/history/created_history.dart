import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zoom_clone/resources/models/meeting.dart';

import '../../custom_widgets/displaying_meeting_card.dart';
import '../../resources/Api.dart';

class Created extends StatefulWidget {
  const Created({super.key});

  @override
  State<Created> createState() => _CreatedState();
}

class _CreatedState extends State<Created> {
  List<Meeting> list = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder(
          stream: Api.getCreatedMeetingData(),
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
                list =
                    data?.map((e) => Meeting.fromJson(e.data())).toList() ?? [];

                print("#length :  ${list.length}");

                final groupedMeetings = groupMeetingsByDate(list);

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: groupedMeetings.isEmpty
                      ? Center(
                          // Display a message when there are no meetings
                          child: Text(
                            "No meetings",
                            style: TextStyle(fontSize: 25, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: groupedMeetings.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final sortedDates = groupedMeetings.keys.toList()
                              ..sort((a, b) {
                                if (a == "Today" || a == "Yesterday") {
                                  return -1;
                                } else if (b == "Today" || b == "Yesterday") {
                                  return 1;
                                }
                                return DateTime.parse(b)
                                    .compareTo(DateTime.parse(a));
                              });
                            final date = sortedDates.elementAt(index);
                            final meetingsForDate = groupedMeetings[date]!;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 130,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      date,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                SizedBox(height: 8),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: meetingsForDate.length,
                                  itemBuilder: (context, index) {
                                    return MeetingCard(
                                      meeting: meetingsForDate[index],
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                );
            }
          },
        ),
      ),
    );
  }

  Map<String, List<Meeting>> groupMeetingsByDate(List<Meeting> meetings) {
    Map<String, List<Meeting>> grouped = {};

    for (var meeting in meetings) {
      final date = formatDate(meeting.date);
      if (grouped.containsKey(date)) {
        grouped[date]!.add(meeting);
      } else {
        grouped[date] = [meeting];
      }
    }

    return grouped;
  }

  dynamic formatDate(String millisecondsSinceEpoch) {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(millisecondsSinceEpoch));
    final now = DateTime.now();

    // Create new DateTime objects with the same date but different times
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

    if (dateTime.isAfter(today)) {
      return "Today";
    } else if (dateTime.isAfter(yesterday)) {
      return "Yesterday";
    } else if (dateTime.isAfter(today.subtract(Duration(days: 7)))) {
      return DateFormat('yyyy-MM-dd').format(dateTime); // Day name
    } else if (dateTime.isAfter(today.subtract(Duration(days: 30)))) {
      return DateFormat('yyyy-MM-dd').format(dateTime); // Day name and date
    } else if (dateTime.isAfter(today.subtract(Duration(days: 365)))) {
      return DateFormat('yyyy-MM').format(dateTime); // Month and date
    } else {
      return DateFormat('yyyy-MM-dd').format(dateTime); // Date, month, and year
    }
  }
}
