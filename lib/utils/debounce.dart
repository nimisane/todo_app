import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  final int milliseconds;
  Debounce({
    this.milliseconds = 500,
  });

  Timer? timer;

  void run(VoidCallback action) {
    if (timer != null) {
      timer!.cancel();
    }

    timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
