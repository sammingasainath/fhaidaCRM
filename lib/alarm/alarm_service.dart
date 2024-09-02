import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alarm/alarm.dart';
import 'alarm_state.dart';

class AlarmNotifier extends StateNotifier<AlarmState> {
  AlarmNotifier() : super(AlarmState(isRinging: false));

  void startRinging(int alarmId) {
    state = AlarmState(isRinging: true, alarmId: alarmId);
  }

  void stopRinging() {
    state = AlarmState(isRinging: false);
  }
}

final alarmProvider = StateNotifierProvider<AlarmNotifier, AlarmState>((ref) {
  return AlarmNotifier();
});

Future<void> initializeAlarm() async {
  await Alarm.init();
}

Future<void> setAlarm(AlarmSettings settings) async {
  await Alarm.set(alarmSettings: settings);
}

Future<void> stopAlarm(int alarmId) async {
  await Alarm.stop(alarmId);
}