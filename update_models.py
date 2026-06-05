# -*- coding: utf-8 -*-
import io, re

# Update NotificationItem in home_data.dart
with io.open(r'packages/home_page/lib/src/domain/entities/home_data.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("required String notificationDate,", "required String notificationDate,\n    @Default(false) bool isDismissed,")
content = content.replace("notificationDate: map['notificationDate'] as String? ?? '',", "notificationDate: map['notificationDate'] as String? ?? '',\n      isDismissed: map['isDismissed'] as bool? ?? false,")
content = content.replace("'notificationDate': notificationDate,", "'notificationDate': notificationDate,\n      'isDismissed': isDismissed,")

with io.open(r'packages/home_page/lib/src/domain/entities/home_data.dart', 'w', encoding='utf-8') as f:
    f.write(content)

# Update ScheduleItem in schedule_item.dart
with io.open(r'packages/calendar/lib/src/domain/entities/schedule_item.dart', 'r', encoding='utf-8') as f:
    content2 = f.read()

content2 = content2.replace("required DateTime date,", "required DateTime date,\n    @Default(false) bool isDismissed,")

with io.open(r'packages/calendar/lib/src/domain/entities/schedule_item.dart', 'w', encoding='utf-8') as f:
    f.write(content2)

