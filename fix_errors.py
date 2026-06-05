# -*- coding: utf-8 -*-
import io, re

# Fix calendar_view.dart
with io.open(r'packages/calendar/lib/src/presentation/view/calendar_view.dart', 'r', encoding='utf-8') as f:
    cal_content = f.read()

cal_content = cal_content.replace("WeekdayHeaderCell(day: 'M')", "WeekdayHeaderCell(text: 'M')")
cal_content = cal_content.replace("WeekdayHeaderCell(day: 'T')", "WeekdayHeaderCell(text: 'T')")
cal_content = cal_content.replace("WeekdayHeaderCell(day: 'W')", "WeekdayHeaderCell(text: 'W')")
cal_content = cal_content.replace("WeekdayHeaderCell(day: 'F')", "WeekdayHeaderCell(text: 'F')")
cal_content = cal_content.replace("WeekdayHeaderCell(day: 'S')", "WeekdayHeaderCell(text: 'S')")

cal_content = cal_content.replace("LoadMonth(year: _selectedDate.year, month: _selectedDate.month)", "LoadMonth(_selectedDate.year, _selectedDate.month)")

with io.open(r'packages/calendar/lib/src/presentation/view/calendar_view.dart', 'w', encoding='utf-8') as f:
    f.write(cal_content)

# Fix app_router.dart
with io.open(r'packages/router/lib/src/app_router.dart', 'r', encoding='utf-8') as f:
    router_content = f.read()

router_content = router_content.replace("LoadMonth(year: DateTime.now().year, month: DateTime.now().month)", "LoadMonth(DateTime.now().year, DateTime.now().month)")

with io.open(r'packages/router/lib/src/app_router.dart', 'w', encoding='utf-8') as f:
    f.write(router_content)
