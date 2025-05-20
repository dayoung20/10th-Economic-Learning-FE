class UserProfile {
  int? userId; // 서버에 전송되지 않음, 프론트에서만 사용
  String? profileImageURL; // 서버에 전송되지 않음, 프론트에서만 사용
  String nickname;
  String birthDate;
  String gender;
  String profileIntro;
  String businessType;
  String job;
  int? currentStreak; // 서버에 전송되지 않음, 프론트에서만 사용
  String? level; // 서버에 전송되지 않음, 프론트에서만 사용
  int? quizCorrectRate; // 서버에 전송되지 않음, 프론트에서만 사용
  bool? isLearningAlarmAllowed;
  bool? isCommunityAlarmAllowed;
  int? imageId; // 서버에 전송하지 않음
  bool? isLevelTestCompleted; // 서버에 전송하지 않음

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
    this.isLearningAlarmAllowed = true,
    this.isCommunityAlarmAllowed = true,
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

  /// JSON 변환 (등록/수정 시 서버에 전송되는 데이터)
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
      // "imageId": imageId, // 서버에 전송하지 않음
      // "isLevelTestCompleted": isLevelTestCompleted, // 서버에 전송하지 않음
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
