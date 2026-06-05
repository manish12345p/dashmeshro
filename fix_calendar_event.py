# -*- coding: utf-8 -*-
import io, re

# fix app_router.dart
with io.open(r'packages/router/lib/src/app_router.dart', 'r', encoding='utf-8') as f:
    router = f.read()
router = router.replace("LoadMonth(", "CalendarEvent.loadMonth(")
with io.open(r'packages/router/lib/src/app_router.dart', 'w', encoding='utf-8') as f:
    f.write(router)

# fix calendar_view.dart
with io.open(r'packages/calendar/lib/src/presentation/view/calendar_view.dart', 'r', encoding='utf-8') as f:
    cal = f.read()
cal = cal.replace("LoadMonth(", "CalendarEvent.loadMonth(")
with io.open(r'packages/calendar/lib/src/presentation/view/calendar_view.dart', 'w', encoding='utf-8') as f:
    f.write(cal)
