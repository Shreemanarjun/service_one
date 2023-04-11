import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_one/router/router.dart';

final autoRouterPod = Provider.autoDispose<AppRouter>((ref) {
  return AppRouter();
});
