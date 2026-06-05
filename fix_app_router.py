# -*- coding: utf-8 -*-
import io, re

with io.open(r'packages/router/lib/src/app_router.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Replace exactly
content = re.sub(
    r"path: '/calendar',\s*builder: \(context, state\) => const CalendarView\(\),",
    r"path: '/calendar',\n          builder: (context, state) => BlocProvider(\n            create: (_) => sl<CalendarBloc>()..add(LoadMonth(DateTime.now().year, DateTime.now().month)),\n            child: const CalendarView(),\n          ),",
    content
)

with io.open(r'packages/router/lib/src/app_router.dart', 'w', encoding='utf-8') as f:
    f.write(content)
