import 'package:demoui/model/image_row.dart';
import 'package:demoui/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<ImageRow> eventImageList = [
    ImageRow(
      imageName: "assets/images/img4.jpg",
      title: "CHILD CARE",
      description: "A complete guide for your new born baby",
      tag: true,
      tagName: "event",
      lessons: 0,
    ),
    ImageRow(
      imageName: "assets/images/img5.jpg",
      title: "CHILD CARE",
      description: "Understanding child behaviour",
      tag: true,
      tagName: "event",
      lessons: 0,
    ),
    ImageRow(
      imageName: "assets/images/img4.jpg",
      title: "CHILD CARE",
      description: "Managing life better in a productive way",
      tag: true,
      tagName: "event",
      lessons: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    getLessons();
    getPrograms();
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar(),
          bottomNavigationBar: BottomNavigationBar(
            //elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: (value) => setState(() {
              _selectedIndex = value;
            }),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.book_outlined,
                  ),
                  label: 'Learn'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.hub_outlined,
                  ),
                  label: 'Hub'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_bubble_outline,
                  ),
                  label: 'Chat'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle_outlined,
                  ),
                  label: 'Profile'),
            ],
          ),
          body: Container(
            width: 350.w,
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello Priya!",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 25.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "What do you want to learn today?",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.h, bottom: 10.h),
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    width: 350.w,
                    child: Column(
                      children: [
                        buildMenuRow(const [
                          Icon(
                            Icons.book_rounded,
                            color: Colors.blue,
                          ),
                          Icon(
                            Icons.help,
                            color: Colors.blue,
                          )
                        ], [
                          "Programs",
                          "Get Help"
                        ]),
                        buildMenuRow(const [
                          Icon(
                            Icons.my_library_books,
                            color: Colors.blue,
                          ),
                          Icon(
                            Icons.stacked_bar_chart_outlined,
                            color: Colors.blue,
                          )
                        ], [
                          "Learn",
                          "DD Tracker"
                        ]),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    width: 350.w,
                    height: 900.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildRowTitle("Programs for you"),
                        buildProgramsCardTile(),
                        buildRowTitle("Events and experiences"),
                        buildCardTile(eventImageList),
                        buildRowTitle("Lessons for you"),
                        buildLessonsCardTile(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
