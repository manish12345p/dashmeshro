void main() {
  final now = DateTime.now();
  final today = now.toIso8601String().split('T')[0];
  
  final s = {
    'id': '123',
    'status': 'pending',
    'service_date': DateTime.now().toIso8601String(),
    'service_type': 'AMC',
    'amount_pending': 500,
  };
  
  final rawStatus = s['status'] as String?;
  final status = (rawStatus == null || rawStatus.isEmpty) ? 'pending' : rawStatus;
  final date = s['service_date'] as String? ?? '';
  
  bool isRecentlyCompleted = false;
  
  final passesPendingFilter = status == 'pending' || isRecentlyCompleted;
  
  print('status: "$status"');
  print('date: "$date"');
  print('today: "$today"');
  print('passes: $passesPendingFilter');

  print('---');

  final s2 = {
    'id': '124',
    // Missing status
    'service_date': '2023-01-01T00:00:00', // OLD date
    'service_type': 'AMC',
  };

  final rawStatus2 = s2['status'] as String?;
  final status2 = (rawStatus2 == null || rawStatus2.isEmpty) ? 'pending' : rawStatus2;
  final date2 = s2['service_date'] as String? ?? '';
  final passesPendingFilter2 = status2 == 'pending' || isRecentlyCompleted;

  print('status2: "$status2"');
  print('date2: "$date2"');
  print('passes2 (old record): $passesPendingFilter2');
}
