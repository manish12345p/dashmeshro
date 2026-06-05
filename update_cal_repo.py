# -*- coding: utf-8 -*-
import io, re

with io.open(r'packages/calendar/lib/src/data/repositories/calendar_repository.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# For service date item
content = content.replace(
    "customerId: customerDoc.id,",
    "customerId: customerDoc.id,\n                isDismissed: data['isDismissed'] as bool? ?? false,"
)

with io.open(r'packages/calendar/lib/src/data/repositories/calendar_repository.dart', 'w', encoding='utf-8') as f:
    f.write(content)
