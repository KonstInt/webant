import 'package:flutter_webant/models/photo.dart';

class User {
  String phone;
  String fullName;
  String oldPassword;
  String newPassword;
  String birthday;
  List<Photo> photos;
  String code;
  bool user;
  List<String> rolesRaw;
  String username;
  List<String> roles;
  int id;
  String usernameCanonical;
  String salt;
  String email;
  String emailCanonical;
  String password;
  String plainPassword;
  String lastLogin;
  String confirmationToken;
  List<String> role;
  bool accountNonExpired;
  bool accountNonLocked;
  bool credentialsNonExpired;
  bool enabled;
  bool superAdmin;
  String passwordRequiredAt;
  List<String> groups;
  List<String> groupNames;
  List<String> group;
  User({
    required this.phone,
    required this.fullName,
    required this.oldPassword,
    required this.newPassword,
    required this.birthday,
    required this.photos,
    required this.code,
    required this.user,
    required this.rolesRaw,
    required this.username,
    required this.roles,
    required this.id,
    required this.usernameCanonical,
    required this.salt,
    required this.email,
    required this.emailCanonical,
    required this.password,
    required this.plainPassword,
    required this.lastLogin,
    required this.confirmationToken,
    required this.role,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
    required this.enabled,
    required this.superAdmin,
    required this.passwordRequiredAt,
    required this.groups,
    required this.groupNames,
    required this.group,
  });
  


}
