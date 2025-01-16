import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Article {
  final int id;
  final String category;
  final String headline;
  final String publisher;
  final String uploadTime;
  final String url; // 외부 링크
  final RxBool isBookmarked;

  Article({
    required this.id,
    required this.category,
    required this.headline,
    required this.publisher,
    required this.uploadTime,
    required this.url,
    required this.isBookmarked,
  });
}
