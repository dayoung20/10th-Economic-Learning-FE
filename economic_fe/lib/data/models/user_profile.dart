class UserProfile {
  String nickname;
  String birthDate;
  String gender;
  String profileIntro;
  String businessType;
  String job;
  bool isLearningAlarmAllowed;
  bool isCommunityAlarmAllowed;
  int? imageId;

  UserProfile({
    required this.nickname,
    required this.birthDate,
    required this.gender,
    required this.profileIntro,
    required this.businessType,
    required this.job,
    this.isLearningAlarmAllowed = true, // 기본값
    this.isCommunityAlarmAllowed = true, // 기본값
    this.imageId,
  });

  // JSON 변환
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      nickname: json['nickname'] ?? '',
      birthDate: json['birthDate'] ?? '',
      gender: json['gender'] ?? '',
      profileIntro: json['profileIntro'] ?? '',
      businessType: json['businessType'] ?? '',
      job: json['job'] ?? '',
      isLearningAlarmAllowed: json['isLearningAlarmAllowed'] ?? true,
      isCommunityAlarmAllowed: json['isCommunityAlarmAllowed'] ?? true,
      imageId: json['imageId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nickname": nickname,
      "birthDate": birthDate,
      "gender": gender,
      "profileIntro": profileIntro,
      "businessType": businessType,
      "job": job,
      "isLearningAlarmAllowed": isLearningAlarmAllowed,
      "isCommunityAlarmAllowed": isCommunityAlarmAllowed,
      "imageId": imageId,
    };
  }
}
