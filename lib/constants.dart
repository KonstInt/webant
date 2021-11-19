import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'models/user/client/client_get.dart';
import 'models/user/user_get.dart';


import 'package:flutter/services.dart';

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
  static String myassetCameraName = 'assets/images/camera_icon.svg';
  static String myassetIconAddPhotoName = 'assets/images/photo_add_icon.svg';
  static String myassetIconAddName = 'assets/images/add_icon.svg';

static final customCacherManager = CacheManager(Config('cacheKey', stalePeriod: Duration(days: 2)));
  
 
static final Widget svgAddPhotoIcon =
      SvgPicture.asset(myassetIconAddPhotoName, width: 200,);

  static final Widget svgAddIcon =
      SvgPicture.asset(myassetIconAddName, color: Colors.grey[600]);

  static final Widget svgCameraIcon =
      SvgPicture.asset(myassetCameraName, color: Colors.grey[600]);

  
  static final Widget svgCameraIconActive =
      SvgPicture.asset(myassetCameraName, color: Colors.pink);

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

  static String formatStr(String str){
    return DateFormat('dd.MM.yyyy').format(DateTime.parse(str));
  }
  

}
