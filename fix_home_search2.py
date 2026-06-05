# -*- coding: utf-8 -*-
import io, re

with io.open(r'packages/home_page/lib/src/presentation/view/home_page_view.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace(
    "delegate: VisitSearchDelegate(data.todayNotifications)",
    "delegate: VisitSearchDelegate()"
)
# Just in case there's another occurrence:
content = content.replace(
    "delegate: VisitSearchDelegate(state.todayNotifications)",
    "delegate: VisitSearchDelegate()"
)

with io.open(r'packages/home_page/lib/src/presentation/view/home_page_view.dart', 'w', encoding='utf-8') as f:
    f.write(content)

