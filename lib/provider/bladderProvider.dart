import 'dart:async';
import 'package:flutter/material.dart';
import 'package:urinary_bladder_level/core/services/apiService.dart';
import 'package:urinary_bladder_level/core/services/notificationService.dart';
import 'package:urinary_bladder_level/models/timeValueSpot.dart';

class BladderProvider with ChangeNotifier, WidgetsBindingObserver {
  String _userValue = '0';
  List<Map<String, dynamic>> _history = [];
  List<TimeValueSpot> _graphData = [];

  Timer? _timer1;
  Timer? _timer2;

  final int _itemsPerPage = 5;
  int _currentPage = 1;

  String get userValue => _userValue;
  List<Map<String, dynamic>> get history =>
      _history.sublist(0, (_currentPage * _itemsPerPage).clamp(0, _history.length));
  List<TimeValueSpot> get graphData => _graphData;
  bool get hasMoreHistory => _currentPage * _itemsPerPage < _history.length;
  bool get hasLessHistory => _currentPage == 5;

  BladderProvider() {
    WidgetsBinding.instance.addObserver(this);
    startTimer();
  }

  void loadMoreHistory() {
    _currentPage++;
    notifyListeners();
  }

  void loadLessHistory() {
    _currentPage = 1;
    notifyListeners();
  }

  void startTimer() {
    if ((_timer1?.isActive ?? false) || (_timer2?.isActive ?? false)) return;

    fetchFullData();

    _timer1 = Timer.periodic(const Duration(seconds: 1), (_) {
      _fetchBladderData();
    });

    _timer2 = Timer.periodic(const Duration(seconds: 10), (_) {
      _fetchBladderData2();
    });
  }

  void stopTimer() {
    _timer1?.cancel();
    _timer2?.cancel();
  }

  void notification(String value) {
    if (value == "500" || value == "1000" || value == "1500") {
      NotificationService().showNotification(
        title: 'Bladder Warning',
        body: 'Your bladder capacity is full at ${_userValue} ml',
        id: 1,
      );
    } else if (value == "2000") {
      NotificationService().showNotification(
        title: 'Bladder Alert',
        body: 'Your bladder capacity is full at ${_userValue} ml. Please empty your bladder.',
        id: 1,
      );
    }
  }

  Future<void> _fetchBladderData() async {
    try {
      final jsonData = await ApiService.fetchBladderData();
      _userValue = jsonData['userValue'] ?? '0';
      notification(_userValue);
      _history = List<Map<String, dynamic>>.from(jsonData['history'] ?? []);
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching bladder data: $e');
    }
  }

  Future<void> _fetchBladderData2() async {
    try {
      final jsonData = await ApiService.fetchBladderData();
      _history = List<Map<String, dynamic>>.from(jsonData['history'] ?? []);
      _graphData = (jsonData['ChartData'] as List)
          .map((entry) => TimeValueSpot(
                time: DateTime.parse(entry['time']),
                value: (entry['value'] as num).toDouble(),
              ))
          .toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching bladder data: $e');
    }
  }

  Future<void> fetchFullData() async {
    try {
      final jsonData = await ApiService.fetchFullData();
      _userValue = jsonData['userValue'] ?? '0';
      _history = List<Map<String, dynamic>>.from(jsonData['history'] ?? []);
      _graphData = (jsonData['ChartData'] as List)
          .map((entry) => TimeValueSpot(
                time: DateTime.parse(entry['time']),
                value: (entry['value'] as num).toDouble(),
              ))
          .toList();
      debugPrint('Graph data: ${_graphData.map((e) => '${e.time}:${e.value}').toList()}');
      notifyListeners();
      NotificationService().showNotification(
        title: 'Bladder Alert',
        body: 'Your bladder capacity is full at ${_userValue} ml',
        id: 1,
      );
    } catch (e) {
      debugPrint('Error fetching full data: $e');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      stopTimer();
      debugPrint('App paused - Timer stopped');
    } else if (state == AppLifecycleState.resumed) {
      startTimer();
      debugPrint('App resumed - Timer restarted');
    }
  }

  @override
  void dispose() {
    stopTimer();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
