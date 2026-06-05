# -*- coding: utf-8 -*-
import io, re

with io.open(r'packages/home_page/lib/src/presentation/view/home_page_view.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = re.sub(
    r'delegate:\s*VisitSearchDelegate\(\s*items:\s*state\.todayNotifications,\s*\)',
    r'delegate: VisitSearchDelegate()',
    content
)
# Just in case there was no 'items:' keyword
content = re.sub(
    r'delegate:\s*VisitSearchDelegate\(\s*state\.todayNotifications\s*\)',
    r'delegate: VisitSearchDelegate()',
    content
)

with io.open(r'packages/home_page/lib/src/presentation/view/home_page_view.dart', 'w', encoding='utf-8') as f:
    f.write(content)

