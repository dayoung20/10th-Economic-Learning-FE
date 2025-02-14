class UserProfile {
  int? userId;
  String? profileImageURL;
  String nickname;
  String birthDate;
  String gender;
  String profileIntro;
  String businessType;
  String job;
  int? currentStreak;
  String? level;
  int? quizCorrectRate;
  bool? isLearningAlarmAllowed;
  bool? isCommunityAlarmAllowed;
  int? imageId;
  bool? isLevelTestCompleted;

  UserProfile({
    this.userId,
    this.profileImageURL,
    required this.nickname,
    required this.birthDate,
    this.gender = 'MALE',
    required this.profileIntro,
    required this.businessType,
    required this.job,
    this.currentStreak,
    this.level,
    this.quizCorrectRate,
    this.isLearningAlarmAllowed = true, // 기본값
    this.isCommunityAlarmAllowed = true, // 기본값
    this.imageId,
    this.isLevelTestCompleted,
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
      isLevelTestCompleted: json['isLevelTestCompleted'],
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
      "isLevelTestCompleted": isLevelTestCompleted,
    };
  }

  // JSON 변환 (마이페이지)
  factory UserProfile.fromJsonMypage(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'],
      profileImageURL: json['profileImageURL'],
      nickname: json['nickname'] ?? '',
      birthDate: json['birthDate'] ?? '',
      profileIntro: json['profileIntro'] ?? '',
      businessType: json['businessType'] ?? '',
      job: json['job'] ?? '',
      currentStreak: json['currentStreak'],
      level: json['level'],
      quizCorrectRate: json['quizCorrectRate'],
    );
  }
}
