import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  pushTo(Widget widget) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => widget));
  }

  pushReplacment(Widget widget) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => widget),
    );
  }
}
