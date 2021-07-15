import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'models/user_get.dart';

class Constants {
  static String noInternetPicturePath = 'assets/images/no_internet.png';
  static String webAdressForPicture = "http://gallery.dev.webant.ru/media/";
  static String _myassetMailName = 'assets/images/mail_icon.svg';
  static String _myassetEyeName = 'assets/images/eye_icon.svg';
  static String _myassetUsernameName = 'assets/images/username_icon.svg';
  static String _myassetCalendarName = 'assets/images/calendar_icon.svg';
  static String myassetFeedName = 'assets/images/news_feed.svg';
  static String myassetProfileName = 'assets/images/profile_icon.svg';
  static String myassetHomeName = 'assets/images/home_icon.svg';
  static late UserGet currentUser;
  static String refreshToken = '';
  static String password = '';
  static bool isInSystem = true;




   static final Widget svgProfileIcon =
      SvgPicture.asset(myassetProfileName, color: Colors.grey[600]);

  static final Widget svgProfileIconActive =
      SvgPicture.asset(myassetProfileName, color: Colors.pink);

 static final Widget svgHomeIcon =
      SvgPicture.asset(myassetHomeName, color: Colors.grey[600]);

  static final Widget svgHomeIconActive =
      SvgPicture.asset(myassetHomeName, color: Colors.pink);

  static final Widget svgFeedIcon =
      SvgPicture.asset(myassetFeedName, color: Colors.grey[600]);

  static final Widget svgFeedIconActive =
      SvgPicture.asset(myassetFeedName, color: Colors.pink);

  static final Widget eyeIcon = SvgPicture.asset(_myassetEyeName,
      color: Colors.grey[600], height: 20, width: 2);

  static final Widget usernameIcon = SvgPicture.asset(_myassetUsernameName,
      color: Colors.grey[600], height: 2, width: 2);

  static final Widget calendarIcon = SvgPicture.asset(_myassetCalendarName,
      color: Colors.grey[600], height: 2, width: 2);

  static final Widget mailIcon = SvgPicture.asset(_myassetMailName,
      color: Colors.grey[600], height: 2, width: 2);


}
