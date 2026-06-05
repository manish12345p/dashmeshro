# -*- coding: utf-8 -*-
import io, re

with io.open(r'packages/home_page/lib/src/data/repositories/home_repository.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace(
    "notificationDate: notifDate,",
    "notificationDate: notifDate,\n                isDismissed: data['isDismissed'] as bool? ?? false,"
)

with io.open(r'packages/home_page/lib/src/data/repositories/home_repository.dart', 'w', encoding='utf-8') as f:
    f.write(content)
