import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Constants {
  static String noInternetPicturePath = 'assets/images/no_internet.png';
  static String webAdressForPicture = "http://gallery.dev.webant.ru/media/";
  static String _myassetMailName = 'assets/images/mail_icon.svg';
  static String _myassetEyeName = 'assets/images/eye_icon.svg';
  static String _myassetUsernameName = 'assets/images/username_icon.svg';
  static String _myassetCalendarName = 'assets/images/calendar_icon.svg';
  static String myassetName = 'assets/images/news_feed.svg';

  static bool isInSystem = false;

  static final Widget svgIcon =
      SvgPicture.asset(myassetName, color: Colors.grey[600]);
  static final Widget mailIcon = SvgPicture.asset(_myassetMailName,
      color: Colors.grey[600], height: 2, width: 2);

  static final Widget svgIconActive =
      SvgPicture.asset(myassetName, color: Colors.pink);

  static final Widget eyeIcon = SvgPicture.asset(_myassetEyeName,
      color: Colors.grey[600], height: 20, width: 2);

  static final Widget usernameIcon = SvgPicture.asset(_myassetUsernameName,
      color: Colors.grey[600], height: 2, width: 2);

  static final Widget calendarIcon = SvgPicture.asset(_myassetCalendarName,
      color: Colors.grey[600], height: 2, width: 2);


}
