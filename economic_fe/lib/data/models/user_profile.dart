class UserProfile {
  String nickname;
  String businessType;
  String job;
  String ageRange;
  String gender;
  String? profileIntro;
  bool isLearningAlarmAllowed;
  bool isCommunityAlarmAllowed;

  UserProfile({
    required this.nickname,
    required this.businessType,
    required this.job,
    required this.ageRange,
    required this.gender,
    this.profileIntro,
    this.isLearningAlarmAllowed = false,
    this.isCommunityAlarmAllowed = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'businessType': businessType,
      'job': job,
      'ageRange': ageRange,
      'gender': gender,
      'profileIntro': profileIntro,
      'isLearningAlarmAllowed': isLearningAlarmAllowed,
      'isCommunityAlarmAllowed': isCommunityAlarmAllowed,
    };
  }
}
