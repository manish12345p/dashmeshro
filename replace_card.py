# -*- coding: utf-8 -*-
import io, re

with io.open(r'packages/calendar/lib/src/presentation/view/calendar_view.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Add import
if "calendar_visit_card.dart" not in content:
    content = content.replace("import '../widgets/weekday_header_cell.dart';", "import '../widgets/weekday_header_cell.dart';\nimport '../widgets/calendar_visit_card.dart';")

# Remove floating action button
fab_pattern = r"floatingActionButton:\s*FloatingActionButton\([\s\S]*?child:\s*const\s*Icon\(Icons\.add,\s*color:\s*Colors\.white,\s*size:\s*28\),\s*\),"
content = re.sub(fab_pattern, "", content)

# Replace ScheduleItemCard with CalendarVisitCard
old_card = """ScheduleItemCard(
                              title: item.name,
                              subtitle: '${item.category} - ${item.machineId}\\n${item.phone}',
                              time: DateFormat('hh:mm a').format(item.date),
                              accentColor: item.statusColor,
                              hasWhatsApp: true,
                              hasView: true,
                              onViewPressed: () {},
                              onWhatsAppPressed: () {},
                            )"""

new_card = "CalendarVisitCard(item: item)"

content = content.replace(old_card, new_card)

with io.open(r'packages/calendar/lib/src/presentation/view/calendar_view.dart', 'w', encoding='utf-8') as f:
    f.write(content)
