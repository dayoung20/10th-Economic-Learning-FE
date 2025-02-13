// import 'package:economic_fe/data/models/community/post_model.dart';
// import 'package:economic_fe/data/models/user_profile.dart';
// import 'package:economic_fe/data/services/image_picker_service.dart';
// import 'package:economic_fe/data/services/remote_data_source.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class MyProfieController extends GetxController {
//   final RemoteDataSource _remoteDataSource = RemoteDataSource();

//   final ImagePickerService _imagePickerService = ImagePickerService();
//   late TabController tabController;

//   var userInfo = Rx<UserProfile?>(null); // 사용자 프로필
//   var isLoading = true.obs; // 전체 로딩 상태
//   var selectedProfileImage = Rx<String?>(null);

//   var myPosts = <PostModel>[].obs; // 내가 작성한 게시글 리스트

//   @override
//   void onInit() {
//     super.onInit();
//     tabController = TabController(length: 3, vsync: this);

//     fetchUserInfo();
//     fetchMyPostsData();
//   }

//   // 사용자 정보 조회
//   Future<void> fetchUserInfo() async {
//     try {
//       var response = await _remoteDataSource.fetchUserInfo();
//       if (response.isNotEmpty) {
//         userInfo.value = UserProfile.fromJsonMypage(response);
//       }
//     } catch (e) {
//       debugPrint("fetchUserInfo() 오류 발생: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   /// 내가 작성한 게시글 불러오기
//   Future<void> fetchMyPostsData() async {
//     try {
//       isLoading.value = true;

//       // API 호출하여 게시글 데이터 가져오기
//       List<Map<String, dynamic>> postData =
//           await RemoteDataSource.fetchMyPostDetail();

//       // JSON 데이터를 PostModel 리스트로 변환
//       List<PostModel> posts =
//           postData.map((json) => PostModel.fromJson(json)).toList();

//       // 게시글 리스트 업데이트
//       myPosts.assignAll(posts);
//       debugPrint("내가 작성한 게시글 로드 완료: ${myPosts.length}개");
//     } catch (e) {
//       debugPrint("fetchMyPostsData() 오류 발생: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   /// Get.arguments 값에 따라 다른 API 호출
//   Future<void> fetchData() async {
//     final remoteDataSource = RemoteDataSource();

//     try {
//       dynamic response;

//       if (argument == '스크랩 한 글') {
//         response = await remoteDataSource.fetchScrapedPosts();
//       } else if (argument == '좋아요 한 글') {
//         response = await remoteDataSource.fetchLikedPosts();
//       } else if (argument == '좋아요 한 댓글') {
//         response = await remoteDataSource.fetchLikedComments();
//       } else {
//         debugPrint("fetchData Error: 잘못된 argument 값입니다.");
//         return;
//       }

//       if (response != null) {
//         final List<dynamic> rawPosts;

//         if (argument == '좋아요 한 댓글') {
//           // 좋아요 한 댓글 API의 경우
//           rawPosts = response['likeCommentResponses'] ?? [];
//         } else {
//           // 다른 API들의 경우
//           rawPosts = response['postList'] ?? [];
//         }

//         // type 변환 로직 적용
//         final List<Map<String, dynamic>> processedPosts = rawPosts.map((post) {
//           final postMap = Map<String, dynamic>.from(post);
//           final type = postMap['type'] ?? '';
//           final transformedType = (type == 'ECONOMY_TALK') ? '경제 톡톡' : '일반 게시판';

//           return {
//             ...postMap, // 기존 데이터
//             'type': transformedType, // 변환된 type 값
//             if (argument == '좋아요 한 댓글') 'postTitle': postMap['postName'] ?? ''
//           };
//         }).toList();

//         posts.value = processedPosts;
//         totalPage.value = response['results']['totalPage'] ?? 0;
//         currentPage.value = response['results']['currentPage'] ?? 0;
//       } else {
//         debugPrint("fetchData Error: 응답이 null이거나 성공하지 않았습니다.");
//       }
//     } catch (e) {
//       debugPrint("fetchData Error: $e");
//     }
//   }

//   // 생년월일 형식 변환 (yyyy-mm-dd → yyyy.mm.dd)
//   String formatBirthDate(String date) {
//     return date.replaceAll("-", ".");
//   }

//   // 한 줄 소개 최대 길이 제한 (최대 20자)
//   String truncateIntro(String intro, {int maxLength = 20}) {
//     return intro.length > maxLength
//         ? "${intro.substring(0, maxLength)}..."
//         : intro;
//   }

//   // 레벨 변환 (영어 → 한글)
//   String convertLevel(String level) {
//     switch (level) {
//       case "BEGINNER":
//         return "초급";
//       case "INTERMEDIATE":
//         return "중급";
//       case "ADVANCED":
//         return "고급";
//       default:
//         return "알 수 없음";
//     }
//   }

//   // 프로필 사진 선택 함수
//   Future<void> selectProfileImage(BuildContext context) async {
//     final image = await _imagePickerService.showImagePickerDialog(context);
//     if (image != null) {
//       selectedProfileImage.value = image.path; // 이미지 경로 저장
//       print('Selected image path: ${image.path}');
//     }
//   }

//   void toDetailPage(int postId) {
//     Get.toNamed('/community/detail', arguments: postId);
//   }
// }
