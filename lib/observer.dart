import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

class MyObserverLogger extends ProviderObserver {
  MyObserverLogger({required this.talker}) : super();
  final Talker talker;

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (newValue is StateController) {
      final newv = newValue.state;
      final perviousv = (previousValue as StateController?)?.state;
      talker.log('Provider is: '
          '${provider.name ?? provider.runtimeType} \n'
          'previous value: $perviousv \n'
          'new value: $newv');
    } else if ((newValue is AsyncValue?) && (previousValue is AsyncValue?)) {
      final previousAsyncValue = previousValue;
      if (previousAsyncValue != null) {
        final newv = newValue?.value;
        final previousv = previousAsyncValue.value;
        talker.log('Provider is: '
            '${provider.name ?? provider.runtimeType} \n'
            'previous value: $previousv \n'
            'new value: $newv');
      } else {
        talker.log('Provider is: '
            '${provider.name ?? provider.runtimeType} \n'
            'previous value: null \n'
            'new value: ${newValue?.value}');
      }
    } else {
      talker.log('Provider is: '
          '${provider.name ?? provider.runtimeType} \n'
          'previous value: ${previousValue.toString()}\n'
          'new value: ${newValue.toString()}');
    }
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }
}
