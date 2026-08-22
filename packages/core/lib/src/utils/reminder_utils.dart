class ReminderUtils {
  /// Calculates the exact next 3-month reminder for the Home page (upcoming or overdue).
  /// This finds the smallest n >= 1 such that (baseDate + 3*n months) >= today.
  /// If it's overdue (i.e., we are currently between an anniversary and the next), 
  /// it returns the most recent anniversary that hasn't been met yet.
  static DateTime getNextOrOverdueReminder(DateTime baseDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    DateTime cycleDate = DateTime(baseDate.year, baseDate.month + 3, baseDate.day);
    
    while (cycleDate.isBefore(today)) {
      DateTime nextCycle = DateTime(cycleDate.year, cycleDate.month + 3, cycleDate.day);
      if (nextCycle.isAfter(today)) {
        // cycleDate is the most recent overdue reminder
        return cycleDate;
      }
      cycleDate = nextCycle;
    }
    
    return cycleDate; // Either exactly today, or in the future
  }

  /// Generates the recurring 3-month dates that fall into the specified month and year.
  /// Returns a list (usually empty or 1 element) of DateTimes.
  static List<DateTime> getRemindersForMonth(DateTime baseDate, int targetYear, int targetMonth) {
    List<DateTime> reminders = [];
    
    // We only generate reminders in the FUTURE of the baseDate (i.e. baseDate itself isn't a reminder).
    DateTime cycleDate = DateTime(baseDate.year, baseDate.month + 3, baseDate.day);
    
    // Fast forward to the target year/month (or slightly before it)
    while (cycleDate.year < targetYear || (cycleDate.year == targetYear && cycleDate.month < targetMonth)) {
      cycleDate = DateTime(cycleDate.year, cycleDate.month + 3, cycleDate.day);
    }
    
    // Now cycleDate is either IN the target month, or PAST the target month.
    if (cycleDate.year == targetYear && cycleDate.month == targetMonth) {
      reminders.add(cycleDate);
    }
    
    return reminders;
  }
}
