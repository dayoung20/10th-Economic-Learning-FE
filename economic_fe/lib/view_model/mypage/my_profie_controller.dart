import 'package:economic_fe/data/models/community/post_model.dart';
import 'package:economic_fe/data/models/community/tok_model.dart';
import 'package:economic_fe/data/models/user_profile.dart';
import 'package:economic_fe/data/services/image_picker_service.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();
  final ImagePickerService _imagePickerService = ImagePickerService();

  late TabController tabController;
  RxInt? userId = RxInt(-1); // RxInt로 변경하여 값이 변경될 때 UI 반영

  var isLoading = true.obs; // 로딩 상태
  var userInfo = Rx<UserProfile?>(null); // 사용자 프로필
  var selectedProfileImage = Rx<String?>(null);
  var myPosts = <PostModel>[].obs;
  var economyTalkPosts = <TokModel>[].obs; // 경제 톡톡 게시글
  var otherCommentPosts = <Map<String, dynamic>>[].obs; // 그 외 댓글 단 게시글

  // 게시글 세부 화면으로 이동
  void toDetailPage(int id) {
    Get.toNamed('/community/detail', arguments: id);
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   updateUserProfile();
  // }

  // /// `userId` 값이 변경될 때마다 프로필을 다시 조회
  // void updateUserProfile() {
  //   int? newUserId = Get.arguments as int?; // 새로운 userId 가져오기
  //   debugPrint('프로필 업데이트 요청: userId = $newUserId');

  //   if (newUserId != null) {
  //     userId!.value = newUserId;
  //   } else {
  //     userId!.value = -1; // 내 프로필 (userId가 null이면 -1로 설정)
  //   }

  //   if (userId!.value != -1) {
  //     fetchUserInfo(userId!.value);
  //     fetchMyPosts(userId!.value);
  //     fetchCommentPosts(userId!.value);
  //     fetchTokTok(userId!.value);
  //   } else {
  //     fetchUserInfo(null);
  //     fetchMyPosts(null);
  //     fetchCommentPosts(null);
  //     fetchTokTok(null);
  //   }
  // }

  // 사용자 정보 조회
  Future<void> fetchUserInfo(int? userId) async {
    try {
      var response = await _remoteDataSource.fetchUserInfo(userId);
      if (response.isNotEmpty) {
        userInfo.value = UserProfile.fromJsonMypage(response);
      }
    } catch (e) {
      debugPrint("fetchUserInfo() 오류 발생: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // 생년월일 형식 변환 (yyyy-mm-dd → yyyy.mm.dd)
  String formatBirthDate(String date) {
    return date.replaceAll("-", ".");
  }

  // 한 줄 소개 최대 길이 제한 (최대 20자)
  String truncateIntro(String intro, {int maxLength = 20}) {
    return intro.length > maxLength
        ? "${intro.substring(0, maxLength)}..."
        : intro;
  }

  // 레벨 변환 (영어 → 한글)
  String convertLevel(String level) {
    switch (level) {
      case "BEGINNER":
        return "초급";
      case "INTERMEDIATE":
        return "중급";
      case "ADVANCED":
        return "고급";
      default:
        return "알 수 없음";
    }
  }

  // 프로필 사진 선택 함수
  Future<void> selectProfileImage(BuildContext context) async {
    final image = await _imagePickerService.showImagePickerDialog(context);
    if (image != null) {
      selectedProfileImage.value = image.path; // 이미지 경로 저장
      print('Selected image path: ${image.path}');
    }
  }

  // 내가 작성한 게시글 목록 불러오기
  Future<void> fetchMyPosts(int? userId) async {
    debugPrint("fetchMyPosts() 실행됨");
    try {
      var posts = await _remoteDataSource.fetchMyPostDetail(userId);
      myPosts.assignAll(posts.map((json) => PostModel.fromJson(json)).toList());
      debugPrint("fetchMyPosts() 완료, 데이터 개수: ${myPosts.length}");
    } catch (e) {
      debugPrint("Error fetching my posts: $e");
    }
  }

  // 내가 댓글 단 게시글 목록 불러오기
  // Future<void> fetchCommentPosts() async {
  //   debugPrint("fetchCommentPosts() 실행됨");
  //   try {
  //     var posts = await _remoteDataSource.fetchCommentPosts();
  //     commentPosts
  //         .assignAll(posts.map((json) => PostModel.fromJson(json)).toList());
  //     debugPrint("fetchCommentPosts() 완료, 데이터 개수: ${commentPosts.length}");
  //   } catch (e) {
  //     debugPrint("Error fetching comment posts: $e");
  //   }
  // }
  Future<void> fetchCommentPosts(int? userId) async {
    debugPrint("fetchCommentPosts() 실행됨");
    try {
      var posts = await _remoteDataSource.fetchCommentPosts(userId);

      var otherCommentList = <Map<String, dynamic>>[]; // 일반 게시글은 Map 형태로 저장

      for (var json in posts) {
        otherCommentList.add(json); // 변환 없이 원본 데이터 유지
      }

      // 리스트에 저장
      otherCommentPosts.assignAll(otherCommentList);

      debugPrint(
          "fetchCommentPosts() 완료, 기타 댓글 단 글: ${otherCommentPosts.length}");
    } catch (e) {
      debugPrint("Error fetching comment posts: $e");
    }
  }

  // 참여한 경제톡톡
  Future<void> fetchTokTok(int? userId) async {
    debugPrint("fetchTokTok() 실행됨");
    try {
      var posts = await _remoteDataSource.fetchTokTok(userId);

      var economyTalkList = <TokModel>[]; // TokModel 저장 리스트

      for (var json in posts) {
        economyTalkList.add(TokModel.fromJson(json));
      }

      // 리스트에 저장
      economyTalkPosts.assignAll(economyTalkList);

      debugPrint("fetchTokTok() 완료, 경제 톡톡: ${economyTalkPosts.length}");
    } catch (e) {
      debugPrint("Error fetching TokTok: $e");
    }
  }

  // 한국어 변환된 카테고리를 반환하는 함수
  String translatedType(String type) {
    switch (type) {
      case 'ECONOMY_TALK':
        return '경제 톡톡';
      case 'FREE':
        return '자유';
      case 'QUESTION':
        return '질문';
      case 'INFORMATION':
        return '정보 공유';
      case 'BOOK_RECOMMENDATION':
        return '책추천';
      default:
        return '기타'; // 기본값
    }
  }
}
