import 'package:flutter/material.dart';
import 'package:sip_app/modules/expert/models/expert_register_model.dart';
import 'package:sip_app/modules/expert/screens/expert_register_done_screen.dart';
import 'package:sip_app/utils/assete_icon_paths.dart';
import 'package:sip_app/config/colors.dart';
import 'package:sip_app/utils/common_appbar.dart';
import 'package:sip_app/utils/common_button.dart';
import 'package:sip_app/config/font_family.dart';
import 'package:sip_app/config/size_config.dart';
import 'package:sip_app/config/string_config.dart';

class ExpertRegisterScreen extends StatefulWidget {
  ExpertRegisterScreen({Key? key, this.isAppbarName = false}) : super(key: key);
  bool isAppbarName;

  @override
  State<ExpertRegisterScreen> createState() => _ExpertRegisterScreenState();
}

class _ExpertRegisterScreenState extends State<ExpertRegisterScreen> {
  int selectedTimeIndex = 0;
  int selectedPackageIndex = 0;
  String selectedTime = '30 minutes';

  void changeTime(String language) {
    selectedTime = language;
  }

  final List<String> timeList = [
    '10 minutes',
    '25 minutes',
    '20 minutes',
    '25 minutes',
    '30 minutes',
    '60 minutes',
  ];

  List<ExpertRegisterModel> selectedPackageList = [
    ExpertRegisterModel(
      id: 0,
      thumbnail: AssetIconPaths.messagingDarkIcon,
      introduceExpert: StringConfig.messagingPackage,
      introduceContent: StringConfig.chatMessagesWithDoctor,
    ),
    ExpertRegisterModel(
      id: 1,
      thumbnail: AssetIconPaths.messagingDarkIcon,
      introduceExpert: StringConfig.messagingPackage,
      introduceContent: StringConfig.chatMessagesWithDoctor,
    ),
    ExpertRegisterModel(
      id: 2,
      thumbnail: AssetIconPaths.messagingDarkIcon,
      introduceExpert: StringConfig.messagingPackage,
      introduceContent: StringConfig.chatMessagesWithDoctor,
    ),
  ];
  DateTime selectedDate = DateTime.now();
  DateTime currentDate = DateTime.now();

  String formatNumber(int num) {
    if (num >= 1 && num <= 9) {
      return "0${num.toString()}";
    } else {
      return '$num';
    }
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0).day;
    final dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final today = DateTime.now().toLocal();
    final currentMonth = DateTime(currentDate.year, currentDate.month);
    return Scaffold(
      backgroundColor: ColorFile.whiteColor,
      appBar: commonAppBar(context,
          title: widget.isAppbarName
              ? StringConfig.bookAppointment
              : StringConfig.rescheduleAppointment),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeFile.height10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeFile.height20),
              child: Text(StringConfig.selectDate,
                  style: TextStyle(
                      color: ColorFile.appbarTitleColor,
                      fontFamily: lexendMedium,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeFile.height16)),
            ),
            SizedBox(height: SizeFile.height16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeFile.height20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${_getMonthName(currentDate.month)} ${currentDate.year}",
                    style: TextStyle(
                      fontFamily: lexendRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: SizeFile.height18,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentDate = DateTime(
                                currentDate.year, currentDate.month - 1);
                          });
                        },
                        child: Icon(
                          Icons.arrow_left,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentDate = DateTime(
                                currentDate.year, currentDate.month + 1);
                          });
                        },
                        child: const Icon(
                          Icons.arrow_right,
                          size: 30,
                          color: ColorFile.appColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 85.0,
              padding: const EdgeInsets.only(left: 20),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: daysInMonth,
                itemBuilder: (context, index) {
                  final date =
                  DateTime(currentDate.year, currentDate.month, index + 1);
                  String dayLabel = dayLabels[date.weekday - 1];
                  String formattedDate = date.day.toString().padLeft(2, '0');
                  bool isToday = date.day == today.day &&
                      currentMonth.month == today.month &&
                      date.year == today.year;
                  bool isSelected = date.day == selectedDate.day &&
                      currentMonth.month == selectedDate.month &&
                      date.year == selectedDate.year;
                  Color textColor = isSelected
                      ? Colors.white
                      : isToday
                      ? Colors.black
                      : Colors.white;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    child: Container(
                      width: 60.0,
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(35),
                        color: isSelected
                            ? ColorFile.appColor
                            : ColorFile.dateUnSelectColor,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              formattedDate,
                              style: TextStyle(
                                fontFamily: lexendRegular,
                                fontWeight: FontWeight.w400,
                                fontSize: SizeFile.height17,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              dayLabel,
                              style: TextStyle(
                                fontFamily: lexendRegular,
                                fontWeight: FontWeight.w400,
                                fontSize: SizeFile.height16,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: SizeFile.height32),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeFile.height20),
              child: Text(StringConfig.selectTime,
                  style: TextStyle(
                      color: ColorFile.whiteColor,
                      fontFamily: lexendMedium,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeFile.height16)),
            ),
            SizedBox(height: SizeFile.height16),
            _buildSelectedTimeList(),
            SizedBox(height: SizeFile.height32),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeFile.height20),
              child: Text(StringConfig.selectDuration,
                  style: TextStyle(
                      color: ColorFile.whiteColor,
                      fontFamily: lexendMedium,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeFile.height16)),
            ),
            SizedBox(height: SizeFile.height16),
            buildSelectedDurationList(),
            SizedBox(height: SizeFile.height32),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeFile.height20),
              child: Text(StringConfig.selectPackage,
                  style: TextStyle(
                      color: ColorFile.whiteColor,
                      fontFamily: lexendMedium,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeFile.height16)),
            ),
            SizedBox(height: SizeFile.height16),
            buildSelectPackageList(),
            SizedBox(height: SizeFile.height8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeFile.height20),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return ExpertRegisterDoneScreen(
                  //         expertId: $expertName,
                  //         expertName: expertName,
                  //       );
                  //     },
                  //   ),
                  // );
                },
                child: ButtonCommon(
                  text: widget.isAppbarName
                      ? StringConfig.continues
                      : StringConfig.reschedule,
                ),
              ),
            ),
            SizedBox(height: SizeFile.height10),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  }

  _buildSelectedTimeList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeFile.height20),
      child: GridView.builder(
        itemCount: timeList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: SizeFile.height12,
          mainAxisExtent: SizeFile.height31,
          crossAxisSpacing: SizeFile.height12,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  selectedTimeIndex = index;
                },
                child: Container(
                  width: SizeFile.height92,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedTimeIndex == index
                        ? ColorFile.appColor
                        : ColorFile.darkModeColor,
                    borderRadius: BorderRadius.circular(SizeFile.height28),
                    border: Border.all(
                      color: ColorFile.dividerDarkModeColor.withOpacity(0.5),
                    ),
                  ),
                  child: Text(
                    timeList[index].toString(),
                    style: TextStyle(
                      color: selectedTimeIndex == index
                          ? ColorFile.whiteColor
                          : ColorFile.whiteColor,
                      fontFamily: lexendRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: SizeFile.height12,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  buildSelectedDurationList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeFile.height20),
      child: Container(
        width: SizeFile.width,
        height: SizeFile.height50,
        decoration: BoxDecoration(
          color: ColorFile.rectangleColor,
          borderRadius: BorderRadius.circular(SizeFile.height10),
          boxShadow: [
            BoxShadow(
              color: ColorFile.darkModeColor,
              spreadRadius: 3,
              blurRadius: 3,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: DropdownButton(
          onChanged: (String? language) => changeTime(language!),
          elevation: 1,
          dropdownColor: ColorFile.rectangleColor,
          hint: Padding(
            padding: EdgeInsets.only(left: SizeFile.height16),
            child: Row(
              children: [
                Image.asset(
                  AssetIconPaths.clockCircleIcon,
                  height: SizeFile.height18,
                  width: SizeFile.height18,
                ),
                SizedBox(width: SizeFile.height10),
                Text(
                  selectedTime,
                  style: TextStyle(
                    fontFamily: lexendMedium,
                    color: ColorFile.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          icon: Padding(
            padding: EdgeInsets.only(right: SizeFile.height8),
            child: Icon(
              Icons.arrow_drop_down,
              color: ColorFile.appColor,
              size: SizeFile.height30,
            ),
          ),
          underline: Container(height: 0),
          isExpanded: true,
          items: timeList
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  fontFamily: lexendRegular,
                  color: ColorFile.whiteColor,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeFile.height14,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  buildSelectPackageList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeFile.height20),
      child: ListView.builder(
        itemCount: selectedPackageList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: SizeFile.width,
            padding: EdgeInsets.symmetric(
              vertical: SizeFile.height10,
              horizontal: SizeFile.height12,
            ),
            margin: EdgeInsets.only(bottom: SizeFile.height24),
            decoration: BoxDecoration(
              color: ColorFile.packageColor,
              borderRadius: BorderRadius.circular(SizeFile.height20),
              boxShadow: [
                BoxShadow(
                  color: ColorFile.packageColor,
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  selectedPackageList[index].thumbnail ?? "",
                  height: SizeFile.height44,
                  width: SizeFile.height44,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: SizeFile.height8,
                          right: SizeFile.height31,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedPackageList[index].introduceExpert ?? "",
                              style: TextStyle(
                                color: ColorFile.whiteColor,
                                fontFamily: lexendMedium,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeFile.height14,
                              ),
                            ),
                            Text(
                              selectedPackageList[index].introduceContent ?? "",
                              style: TextStyle(
                                color: ColorFile.appColor,
                                fontFamily: lexendSemiBold,
                                fontWeight: FontWeight.w600,
                                fontSize: SizeFile.height16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeFile.height10),
                      Padding(
                        padding: EdgeInsets.only(
                          left: SizeFile.height8,
                          right: SizeFile.height24,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedPackageList[index].introduceExpert ?? "",
                              style: TextStyle(
                                color: ColorFile.dividerDarkModeColor,
                                fontFamily: lexendLight,
                                fontWeight: FontWeight.w300,
                                fontSize: SizeFile.height12,
                              ),
                            ),
                            Text(
                              selectedPackageList[index].introduceContent ?? "",
                              style: TextStyle(
                                color: ColorFile.dividerDarkModeColor,
                                fontFamily: lexendLight,
                                fontWeight: FontWeight.w300,
                                fontSize: SizeFile.height12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectedPackageIndex = index;
                  },
                  child: Image.asset(
                    selectedPackageIndex == index
                        ? AssetIconPaths.selsectCircleIcon
                        : AssetIconPaths.circleIcon,
                    height: SizeFile.height16,
                    width: SizeFile.height16,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}