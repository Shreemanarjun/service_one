import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_one/logger.dart';
import 'package:service_one/observer.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // FlutterError.onError = (details) {
  //   log(details.exceptionAsString(), stackTrace: details.stack);
  // };

  await runZonedGuarded(
    () async => runApp(ProviderScope(
      observers: [
        MyObserverLogger(
          talker: talker,
        )
      ],
      child: await builder(),
    )),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
