import 'package:flutter/material.dart';

myScrollController(Function dispatch) {
  final ScrollController controller = ScrollController();
  controller.addListener(() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      dispatch();
    }
  });

  return controller;
}
