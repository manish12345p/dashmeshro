# -*- coding: utf-8 -*-
import io, re

with io.open(r'packages/home_page/lib/src/presentation/view/home_page_view.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Add import
import_stmt = "import '../widgets/visit_search_delegate.dart';\n"
if import_stmt not in content:
    content = content.replace("import '../widgets/visit_schedule_card.dart';", "import '../widgets/visit_schedule_card.dart';\n" + import_stmt)

# Update the onPressed for the search button
old_search_btn = """IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {},
                          ),"""

new_search_btn = """IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              showSearch(
                                context: context,
                                delegate: VisitSearchDelegate(data.todayNotifications),
                              );
                            },
                          ),"""

content = content.replace(old_search_btn, new_search_btn)

with io.open(r'packages/home_page/lib/src/presentation/view/home_page_view.dart', 'w', encoding='utf-8') as f:
    f.write(content)
