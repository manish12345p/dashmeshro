# -*- coding: utf-8 -*-
import io, re

with io.open(r'packages/router/lib/src/app_router.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Add imports
if "package:flutter_bloc/flutter_bloc.dart" not in content:
    content = "import 'package:flutter_bloc/flutter_bloc.dart';\n" + content
if "package:core/core.dart" not in content:
    content = "import 'package:core/core.dart';\n" + content

# Replace GoRoute builder for calendar
old_route = """        GoRoute(
          path: '/calendar',
          builder: (context, state) => const CalendarView(),
        ),"""

new_route = """        GoRoute(
          path: '/calendar',
          builder: (context, state) => BlocProvider(
            create: (_) => sl<CalendarBloc>()..add(LoadMonth(year: DateTime.now().year, month: DateTime.now().month)),
            child: const CalendarView(),
          ),
        ),"""

content = content.replace(old_route, new_route)

with io.open(r'packages/router/lib/src/app_router.dart', 'w', encoding='utf-8') as f:
    f.write(content)
