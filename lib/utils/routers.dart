import 'package:flutter/material.dart';

void nextPage({Widget? page, BuildContext? context}) {
  Navigator.push(context!, MaterialPageRoute(builder: (_) => page!));
}

void nextPageOnly({Widget? page, BuildContext? context}) {
  Navigator.pushAndRemoveUntil(
      context!, MaterialPageRoute(builder: (_) => page!), (route) => false);
}
