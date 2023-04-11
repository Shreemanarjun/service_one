import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_one/features/home/model/vendor_model.dart';

class SelectedServiceListNotifier extends AutoDisposeNotifier<List<Service>> {
  @override
  List<Service> build() => [];

  void toggleAdd(Service service) {
    if (!state.contains(service)) {
      addService(service);
    } else {
      removeService(service);
    }
  }

  void addService(Service service) {
    final newState = state.toList();
    newState.add(service);
    state = newState;
  }

  void removeService(Service service) {
    final newState = state.toList();
    newState.remove(service);
    state = newState;
  }
}
