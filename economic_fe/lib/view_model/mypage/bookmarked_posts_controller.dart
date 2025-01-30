import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkedPostsController extends GetxController {
  final String argument = Get.arguments ?? '스크랩 한 글';

  RxList<dynamic> posts = <dynamic>[].obs;
  RxInt totalPage = 0.obs;
  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  /// Get.arguments 값에 따라 다른 API 호출
  Future<void> fetchData() async {
    try {
      dynamic response;

      if (argument == '스크랩 한 글') {
        response = await RemoteDataSource.fetchScrapedPosts();
      } else if (argument == '좋아요 한 글') {
        response = await RemoteDataSource.fetchLikedPosts();
      } else if (argument == '좋아요 한 댓글') {
        response = await RemoteDataSource.fetchLikedComments();
      } else {
        debugPrint("fetchData Error: 잘못된 argument 값입니다.");
        return;
      }

      if (response != null) {
        final List<dynamic> rawPosts;

        if (argument == '좋아요 한 댓글') {
          // 좋아요 한 댓글 API의 경우
          rawPosts = response['likeCommentResponses'] ?? [];
        } else {
          // 다른 API들의 경우
          rawPosts = response['postList'] ?? [];
        }

        // type 변환 로직 적용
        final List<Map<String, dynamic>> processedPosts = rawPosts.map((post) {
          final postMap = Map<String, dynamic>.from(post);
          final type = postMap['type'] ?? '';
          final transformedType = (type == 'ECONOMY_TALK') ? '경제 톡톡' : '일반 게시판';

          return {
            ...postMap, // 기존 데이터
            'type': transformedType, // 변환된 type 값
            if (argument == '좋아요 한 댓글') 'postTitle': postMap['postName'] ?? ''
          };
        }).toList();

        posts.value = processedPosts;
        totalPage.value = response['results']['totalPage'] ?? 0;
        currentPage.value = response['results']['currentPage'] ?? 0;
      } else {
        debugPrint("fetchData Error: 응답이 null이거나 성공하지 않았습니다.");
      }
    } catch (e) {
      debugPrint("fetchData Error: $e");
    }
  }
}
