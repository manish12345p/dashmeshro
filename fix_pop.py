# -*- coding: utf-8 -*-
import io, re

with io.open(r'packages/calendar/lib/src/presentation/view/calendar_view.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("onPressed: () => context.pop(),", "onPressed: () { if (context.canPop()) { context.pop(); } else { context.go('/'); } },")

with io.open(r'packages/calendar/lib/src/presentation/view/calendar_view.dart', 'w', encoding='utf-8') as f:
    f.write(content)
