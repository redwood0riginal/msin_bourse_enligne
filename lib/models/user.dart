import 'profile.dart';

class User {
  final int? id;
  final String? ucode;
  final String? firstName;
  final String? lastName;
  final String? function;
  final String? email;
  final bool enabled;
  final bool signatory;
  final UserProfile? profileId;
  final int? managerId;
  final String? employeeNumber;
  final String? password;
  final String? phoneNumber;
  final DateTime? passwordDate;
  final DateTime? graceDate;
  final int? failedAttempts;
  final DateTime? lockTime;
  final String? categoryId;

  User({
    this.id,
    this.ucode,
    this.firstName,
    this.lastName,
    this.function,
    this.email,
    this.enabled = false,
    this.signatory = false,
    this.profileId,
    this.managerId,
    this.employeeNumber,
    this.password,
    this.phoneNumber,
    this.passwordDate,
    this.graceDate,
    this.failedAttempts,
    this.lockTime,
    this.categoryId,
  });

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      ucode: json['ucode'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      function: json['function'],
      email: json['email'],
      enabled: json['enabled'] ?? false,
      signatory: json['signatory'] ?? false,
      profileId: json['profileId'] != null
          ? UserProfile.fromJson(json['profileId'])
          : null,
      managerId: json['managerId'],
      employeeNumber: json['employeeNumber'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      passwordDate: json['passwordDate'] != null
          ? DateTime.parse(json['passwordDate'])
          : null,
      graceDate: json['graceDate'] != null
          ? DateTime.parse(json['graceDate'])
          : null,
      failedAttempts: json['failedAttempts'],
      lockTime: json['lockTime'] != null
          ? DateTime.parse(json['lockTime'])
          : null,
      categoryId: json['categoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ucode': ucode,
      'firstName': firstName,
      'lastName': lastName,
      'function': function,
      'email': email,
      'enabled': enabled,
      'signatory': signatory,
      'profileId': profileId?.toJson(),
      'managerId': managerId,
      'employeeNumber': employeeNumber,
      'password': password,
      'phoneNumber': phoneNumber,
      'passwordDate': passwordDate?.toIso8601String(),
      'graceDate': graceDate?.toIso8601String(),
      'failedAttempts': failedAttempts,
      'lockTime': lockTime?.toIso8601String(),
      'categoryId': categoryId,
    };
  }

  User copyWith({
    int? id,
    String? ucode,
    String? firstName,
    String? lastName,
    String? function,
    String? email,
    bool? enabled,
    bool? signatory,
    UserProfile? profileId,
    int? managerId,
    String? employeeNumber,
    String? password,
    String? phoneNumber,
    DateTime? passwordDate,
    DateTime? graceDate,
    int? failedAttempts,
    DateTime? lockTime,
    String? categoryId,
  }) {
    return User(
      id: id ?? this.id,
      ucode: ucode ?? this.ucode,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      function: function ?? this.function,
      email: email ?? this.email,
      enabled: enabled ?? this.enabled,
      signatory: signatory ?? this.signatory,
      profileId: profileId ?? this.profileId,
      managerId: managerId ?? this.managerId,
      employeeNumber: employeeNumber ?? this.employeeNumber,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      passwordDate: passwordDate ?? this.passwordDate,
      graceDate: graceDate ?? this.graceDate,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      lockTime: lockTime ?? this.lockTime,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'User[id=$id, fullName=$fullName]';
}
