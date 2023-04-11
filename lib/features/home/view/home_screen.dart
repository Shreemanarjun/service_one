import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_one/features/home/controller/vendor_service_pod.dart';
import 'package:service_one/features/home/view/ui_state/home_loaded_view.dart';
import 'package:service_one/features/home/view/ui_state/home_loading_view.dart';
import 'package:service_one/features/home/view/widgets/home_app_bar.dart';
import 'package:service_one/shared/riverpod_ext/async_value_easy_when.dart';

@RoutePage(deferredLoading: true)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: HomeAppBar(),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final vendormodelAsync = ref.watch(vendorServicePod);
            return vendormodelAsync.easyWhen(
              data: (vendormodel) => HomeLoaded(
                vendorModel: vendormodel,
              ),
              loadingWidget: () => HomeLoadingView(),
              skipLoadingOnRefresh: false,
            );
          },
        ),
      ),
    );
  }
}
