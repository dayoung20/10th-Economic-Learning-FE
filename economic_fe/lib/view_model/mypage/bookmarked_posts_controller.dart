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
    final remoteDataSource = RemoteDataSource();

    try {
      dynamic response;

      if (argument == '스크랩 한 글') {
        response = await remoteDataSource.fetchScrapedPosts();
      } else if (argument == '좋아요 한 글') {
        response = await remoteDataSource.fetchLikedPosts();
      } else if (argument == '좋아요 한 댓글') {
        response = await remoteDataSource.fetchLikedComments();
      } else {
        debugPrint("fetchData Error: 잘못된 argument 값입니다.");
        return;
      }

      if (response != null) {
        List<Map<String, dynamic>> rawPosts;

        if (argument == '좋아요 한 댓글') {
          // 좋아요 한 댓글 API의 경우 (향후 response['likeCommentResponses'] 등으로 바뀔 수 있음)
          rawPosts = List<Map<String, dynamic>>.from(response);
        } else {
          // 스크랩, 좋아요 게시글 API는 리스트 자체가 response로 옴
          rawPosts = List<Map<String, dynamic>>.from(response);
        }

        final List<Map<String, dynamic>> processedPosts =
            rawPosts.map((postMap) {
          final type = postMap['type'] ?? '';
          final transformedType = (type == 'ECONOMY_TALK') ? '경제 톡톡' : '일반 게시판';

          return {
            ...postMap,
            'type': transformedType,
            if (argument == '좋아요 한 댓글') 'postTitle': postMap['postName'] ?? ''
          };
        }).toList();

        posts.value = processedPosts;
        totalPage.value = 1; // 서버에서 totalPage가 따로 없으므로 임시 처리
        currentPage.value = 1;
      } else {
        debugPrint("fetchData Error: 응답이 null이거나 성공하지 않았습니다.");
      }
    } catch (e) {
      debugPrint("fetchData Error: $e");
    }
  }
}
