import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkedPostsController extends GetxController {
  final String argument = Get.arguments ?? '스크랩 한 글';

  // // 게시글 데이터 리스트
  // final RxList<Map<String, String>> posts = <Map<String, String>>[].obs;

  // Mock 데이터
  final List<Map<String, String>> bookmarkedPosts = [
    {
      "category": "일반 게시판",
      "title": "스크랩한 게시글 제목 1",
      "uploadTime": "2시간 전",
    },
    {
      "category": "경제 톡톡",
      "title": "스크랩한 게시글 제목 2",
      "uploadTime": "1일 전",
    },
  ];

  final List<Map<String, String>> likedPosts = [
    {
      "category": "일반 게시판",
      "title": "좋아요한 게시글 제목 1",
      "uploadTime": "3시간 전",
    },
    {
      "category": "경제 톡톡",
      "title": "좋아요한 게시글 제목 2",
      "uploadTime": "2일 전",
    },
  ];

  final List<Map<String, String>> likedComments = [
    {
      "category": "일반 게시판",
      "title": "좋아요한 댓글 내용",
      "uploadTime": "4시간 전",
      "postTitle": "원문글 제목",
    },
  ];

  @override
  void onInit() {
    super.onInit();

    // arguments에 따라 posts 초기화
    if (argument == '스크랩 한 글') {
      posts.assignAll(bookmarkedPosts);
    } else if (argument == '좋아요 한 글') {
      posts.assignAll(likedPosts);
    } else if (argument == '좋아요 한 댓글') {
      posts.assignAll(likedComments);
    }
  }

  RxList<dynamic> posts = <dynamic>[].obs;
  RxInt totalPage = 0.obs;
  RxInt currentPage = 0.obs;

  Future<void> fetchScrapedPosts() async {
    try {
      final response = await RemoteDataSource.fetchScrapedPosts();
      if (response != null) {
        final List<dynamic> rawPosts = response['postList'] ?? [];

        // 명시적으로 캐스팅
        final List<Map<String, dynamic>> processedPosts = rawPosts.map((post) {
          final postMap = Map<String, dynamic>.from(
              post); // 명시적으로 Map<String, dynamic>으로 캐스팅
          final type = postMap['type'] ?? '';
          final transformedType = (type == 'ECONOMY_TALK') ? '경제 톡톡' : '일반 게시판';

          return {
            ...postMap, // 기존 데이터
            'type': transformedType, // 변환된 type 값
          };
        }).toList();

        posts.value = processedPosts; // 변환된 데이터를 posts에 저장
        totalPage.value = response['totalPage'] ?? 0;
        currentPage.value = response['currentPage'] ?? 0;
      } else {
        debugPrint("fetchScrapedPosts Error: 응답이 null입니다.");
      }
    } catch (e) {
      debugPrint("fetchScrapedPosts Error: $e");
    }
  }
}
