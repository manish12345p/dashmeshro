# -*- coding: utf-8 -*-
import io, re

with io.open(r'packages/calendar/lib/src/presentation/view/calendar_view.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Remove import ServiceScheduleCard
content = content.replace("import '../widgets/service_schedule_card.dart';", "")

# Replace ServiceScheduleCard usage
card_usage = """return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ScheduleItemCard(
                          title: item.name,
                          subtitle: '${item.category} - ${item.machineId}',
                          time: item.time,
                          accentColor: item.statusColor,
                          hasWhatsApp: true,
                          hasView: true,
                          onViewPressed: () {},
                          onWhatsAppPressed: () {},
                        ),
                      );"""

content = re.sub(r'return ServiceScheduleCard\(item: item\);', card_usage, content)

with io.open(r'packages/calendar/lib/src/presentation/view/calendar_view.dart', 'w', encoding='utf-8') as f:
    f.write(content)
