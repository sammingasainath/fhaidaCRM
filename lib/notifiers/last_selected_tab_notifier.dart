import 'package:flutter_riverpod/flutter_riverpod.dart';

final lastSelectedTabProvider = StateNotifierProvider<LastSelectedTabNotifier, int>((ref) {
  return LastSelectedTabNotifier();
});

class LastSelectedTabNotifier extends StateNotifier<int> {
  LastSelectedTabNotifier() : super(0);

  void setTabIndex(int index) {
    state = index;
  }
}
