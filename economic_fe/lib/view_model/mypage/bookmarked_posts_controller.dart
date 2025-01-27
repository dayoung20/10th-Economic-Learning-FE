import 'package:get/get.dart';

class BookmarkedPostsController extends GetxController {
  final String argument = Get.arguments ?? '스크랩 한 글';

  // 게시글 데이터 리스트
  final RxList<Map<String, String>> posts = <Map<String, String>>[].obs;

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
}
