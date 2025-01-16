import 'package:economic_fe/data/models/article.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/chatbot_fab.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view_model/article/article_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailPage extends StatefulWidget {
  const ArticleDetailPage({super.key});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  late WebViewController webViewController;
  final ArticleDetailController controller = Get.put(ArticleDetailController());
  // 전달받은 기사 데이터
  final Article article = Get.arguments as Article;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(article.url ?? 'https://flutter.dev'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        icon: Icons.arrow_back_ios_new,
        title: article.headline,
        onPress: () {
          controller.goBack();
        },
      ),
      body: WebViewWidget(controller: webViewController),
      floatingActionButton: ChatbotFAB(
        onTap: () {
          controller.toChatbot();
        },
      ),
      bottomNavigationBar: Container(
        color: Palette.background,
        height: 34,
      ),
    );
  }
}
