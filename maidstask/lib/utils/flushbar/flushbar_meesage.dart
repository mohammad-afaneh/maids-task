// ignore_for_file: non_constant_identifier_names

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class MyFlushbar {
  FlushbarMess(meesage, context) {
    return Flushbar(
            backgroundColor: Colors.grey.shade400,
            messageColor: Colors.black,
            animationDuration: const Duration(seconds: 1),
            messageText: Text(meesage ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700)),
            duration: const Duration(seconds: 2),
            margin: const EdgeInsets.only(bottom: 50, left: 15, right: 15),
            borderRadius: BorderRadius.circular(20))
        .show(context);
  }
}
