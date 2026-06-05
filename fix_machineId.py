# -*- coding: utf-8 -*-
import io, re

with io.open(r'packages/home_page/lib/src/presentation/widgets/visit_search_delegate.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("item.machineId.toLowerCase().contains(q);", "false;")

with io.open(r'packages/home_page/lib/src/presentation/widgets/visit_search_delegate.dart', 'w', encoding='utf-8') as f:
    f.write(content)
