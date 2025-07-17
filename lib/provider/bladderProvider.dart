import 'dart:async';
import 'package:flutter/material.dart';
import 'package:urinary_bladder_level/core/services/apiService.dart';
import 'package:urinary_bladder_level/models/timeValueSpot.dart';

class BladderProvider with ChangeNotifier {
  String _userValue = '0';
  List<Map<String, dynamic>> _history = [];
  List<TimeValueSpot> _graphData = [];

  Timer? _timer;

  // Pagination
  final int _itemsPerPage = 5;
  int _currentPage = 1;

  // Getters
  String get userValue => _userValue;
  List<Map<String, dynamic>> get history =>
      _history.sublist(0, (_currentPage * _itemsPerPage).clamp(0, _history.length));
  List<TimeValueSpot> get graphData => _graphData;
  bool get hasMoreHistory => _currentPage * _itemsPerPage < _history.length;
  bool get hasLessHistory => _currentPage == 5;

  void loadMoreHistory() {
    _currentPage++;
    notifyListeners();
  }
  void loadLessHistory() {
    _currentPage = 1;
    notifyListeners();
  }

  void startTimer() {
    if (_timer?.isActive ?? false) return;
      fetchFullData();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _fetchBladderData();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  Future<void> _fetchBladderData() async {
    try {
      final jsonData = await ApiService.fetchBladderData();

      _userValue = jsonData['userValue'] ?? '0';

      _history = List<Map<String, dynamic>>.from(jsonData['history'] ?? []);

      late List<TimeValueSpot> newgraphData = (jsonData['ChartData'] as List)
          .map((entry) => TimeValueSpot(
                time: DateTime.parse(entry['time']),
                value: (entry['value'] as num).toDouble(),
              ))
          .toList();
      _graphData.addAll(newgraphData);
  
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
        print('Graph data: ${_graphData.map((e) => '${e.time}:${e.value}').toList()}');
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching full data: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
