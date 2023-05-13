import 'dart:convert';
import 'package:demoui/util.dart';
import 'package:flutter/material.dart';
import 'package:demoui/config.dart';
import 'package:demoui/model/image_row.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<String> imagesList = getImagesList();
List<ImageRow> lessonList = [];
List<ImageRow> programsList = [];
Future getLessons() async {
  var response = await http
      .get(Uri.https(Config.lessonsApiUrl, Config.lessonsApiEndpoint));
  var data = jsonDecode(response.body);
  // var item1 = data['items'][0];
  int i = 0;
  for (var item in data['items']) {
    final img = ImageRow(
      imageName: imagesList[i],
      description: item['name'],
      title: item['category'],
      lessons: item['lesson'],
      tag: true,
      tagName: "lesson",
    );
    lessonList.add(img);
    i++;
  }

  print(lessonList.length);
}

Future getPrograms() async {
  var response = await http
      .get(Uri.https(Config.programsApiUrl, Config.programsApiEndpoint));
  var data = jsonDecode(response.body);
  // var item1 = data['items'][0];
  int i = 0;
  for (var item in data['items']) {
    final img = ImageRow(
      imageName: imagesList[i],
      description: item['name'],
      title: item['category'],
      lessons: item['duration'],
    );
    programsList.add(img);
    i++;
  }

  print(programsList.length);
}

AppBar buildAppBar() {
  return AppBar(
    leading: const Icon(
      Icons.menu_outlined,
      color: Colors.grey,
    ),
    actions: [
      Container(
        margin: EdgeInsets.only(right: 15.w),
        child: Row(
          children: [
            const Icon(
              Icons.chat_outlined,
              color: Colors.grey,
            ),
            SizedBox(
              width: 25.w,
            ),
            const Icon(
              Icons.notifications_outlined,
              color: Colors.grey,
            ),
          ],
        ),
      )
    ],
  );
}

Widget buildMenuRow(List<Icon> iconList, List<String> textList) {
  return Container(
    width: 330.w,
    height: 50.h,
    margin: EdgeInsets.only(top: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildRowItem(iconList[0], textList[0]),
        buildRowItem(iconList[1], textList[1]),
      ],
    ),
  );
}

Widget buildRowItem(Icon iconName, String iconText) {
  return Container(
    width: 140.w,
    height: 50.h,
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(
          color: Colors.blue,
        )),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          iconName,
          SizedBox(
            width: 4.w,
          ),
          Text(
            iconText,
            style: const TextStyle(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildRowTitle(String titleName) {
  return SizedBox(
    width: 320.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titleName,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp),
        ),
        Row(
          children: [
            const Text(
              "View all",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              width: 5.w,
            ),
            const Icon(
              Icons.arrow_right_alt_sharp,
              color: Colors.grey,
            ),
          ],
        )
      ],
    ),
  );
}

Widget buildLessonsCardTile() {
  return Container(
    width: 320.w,
    height: 220.h,
    margin: EdgeInsets.only(top: 25.h, right: 10.w, bottom: 25.h),
    child: FutureBuilder(
      future: getLessons(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: lessonList.length,
            itemBuilder: (context, index) {
              return builImageRowItem(lessonList[index]);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ),
  );
}

Widget buildProgramsCardTile() {
  return Container(
    width: 320.w,
    height: 220.h,
    margin: EdgeInsets.only(top: 25.h, right: 10.w, bottom: 25.h),
    child: FutureBuilder(
      future: getPrograms(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: programsList.length,
            itemBuilder: (context, index) {
              return builImageRowItem(programsList[index]);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ),
  );
}

Widget buildCardTile(List<ImageRow>? imageList) {
  return Container(
    width: 320.w,
    height: 220.h,
    margin: EdgeInsets.only(top: 25.h, right: 10.w, bottom: 25.h),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: imageList?.length,
      itemBuilder: (context, index) {
        return builImageRowItem(imageList![index]);
      },
    ),
  );
}

Widget builImageRowItem(ImageRow imageRow) {
  return Container(
    width: 240.w,
    height: 220.h,
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
    margin: EdgeInsets.only(right: 10.w, bottom: 5.h),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.w),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          )
        ]),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
              width: 120.w,
              height: 100.h,
              child: Image.asset(
                imageRow.imageName,
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(
          height: 6.h,
        ),
        Text(
          imageRow.title,
          style:
              const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 6.h,
        ),
        Text(
          imageRow.description,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp),
        ),
        SizedBox(
          height: 10.h,
        ),
        imageRow.tag ? buildEventRow(imageRow) : buildCardRow(imageRow),
      ],
    ),
  );
}

Widget buildEventRow(ImageRow imageRow) {
  return imageRow.tagName == "event"
      ? buildEventWidget()
      : buildLessonsWidget();
}

Widget buildEventWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("13th Feb Sunday",
          style: TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
              fontSize: 12.sp)),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.w),
            border: Border.all(color: Colors.blue)),
        child: Text("Book",
            style: TextStyle(
                color: Colors.blue,
                fontStyle: FontStyle.italic,
                fontSize: 12.sp)),
      )
    ],
  );
}

Widget buildLessonsWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: const [
      Text(
        "3 min",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
      Icon(
        Icons.shopping_bag_outlined,
        color: Colors.grey,
      ),
    ],
  );
}

Widget buildCardRow(ImageRow imageRow) {
  return Row(
    children: [
      Text("${imageRow.lessons.toString()} lessons",
          style: TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
              fontSize: 12.sp)),
    ],
  );
}
