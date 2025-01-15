import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart'; // GoRouter import

class LearningConceptController extends GetxController {
  List<String> level = ["초급", "중급", "고급"];

  var selectedIndex = (-1).obs;
}
