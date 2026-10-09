void main() {
  final now = DateTime.now();
  final today = now.toIso8601String().split('T')[0];

  void testScenario(String name, Map<String, dynamic> s, {bool verbose = false}) {
    print('--- $name ---');
    final rawStatus = s['status'] as String?;
    final status = (rawStatus == null || rawStatus.isEmpty) ? 'pending' : rawStatus;
    final date = s['service_date'] as String? ?? '';
    
    final completedAtStr = s['completed_at'] as String? ?? s['completedAt'] as String? ?? '';
    bool isRecentlyCompleted = false;
    if (status == 'completed') {
      if (completedAtStr.isNotEmpty) {
        try {
          final compDate = DateTime.parse(completedAtStr);
          if (now.difference(compDate).inHours < 24) isRecentlyCompleted = true;
        } catch (_) {}
      }
      if (!isRecentlyCompleted && date.startsWith(today)) {
        isRecentlyCompleted = true;
      }
    }

    final passesPendingFilter = status == 'pending' || isRecentlyCompleted;
    
    if (verbose) {
      print('Status: $status');
      print('Completed At: $completedAtStr');
      print('Is Recently Completed: $isRecentlyCompleted');
    }
    print('Passes filter: $passesPendingFilter');
  }

  // a) Tick checkbox (status = complete, recently completed)
  testScenario('a) Tick checkbox (recent complete)', {
    'status': 'completed',
    'completed_at': now.subtract(const Duration(hours: 1)).toIso8601String(),
    'service_date': '2023-01-01',
  }, verbose: true);

  // b) Untick within 24h (status returns to pending, timestamp NOT cleared in DB but ignored in code)
  testScenario('b) Untick within 24h (status pending, old timestamp)', {
    'status': 'pending',
    'completed_at': now.subtract(const Duration(hours: 1)).toIso8601String(),
    'service_date': '2023-01-01',
  }, verbose: true);

  // c) Expiry (status complete, timestamp > 24h)
  testScenario('c) Expiry (>24h completed)', {
    'status': 'completed',
    'completed_at': now.subtract(const Duration(hours: 25)).toIso8601String(),
    'service_date': '2023-01-01', // old date
  }, verbose: true);

  // d) Timestamp is null/missing for a pending visit
  testScenario('d) Null/missing timestamp on pending', {
    'status': 'pending',
    // no completed_at
    'service_date': '2023-01-01',
  }, verbose: true);

  // d.2) Timestamp is null/missing for a completed visit created TODAY
  testScenario('d.2) Null timestamp on completed (created today)', {
    'status': 'completed',
    // no completed_at
    'service_date': today,
  }, verbose: true);
}
