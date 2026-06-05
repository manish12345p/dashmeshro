# -*- coding: utf-8 -*-
import io, re

# Update VisitScheduleCard
with io.open(r'packages/home_page/lib/src/presentation/widgets/visit_schedule_card.dart', 'r', encoding='utf-8') as f:
    home_card = f.read()

home_did_update = """
  @override
  void didUpdateWidget(covariant VisitScheduleCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.item.isDismissed != oldWidget.item.isDismissed) {
      isDismissed = widget.item.isDismissed;
    }
  }
"""

if "void didUpdateWidget" not in home_card:
    home_card = home_card.replace("void initState() {", home_did_update + "\n  @override\n  void initState() {")

with io.open(r'packages/home_page/lib/src/presentation/widgets/visit_schedule_card.dart', 'w', encoding='utf-8') as f:
    f.write(home_card)


# Update CalendarVisitCard
with io.open(r'packages/calendar/lib/src/presentation/widgets/calendar_visit_card.dart', 'r', encoding='utf-8') as f:
    cal_card = f.read()

cal_did_update = """
  @override
  void didUpdateWidget(covariant CalendarVisitCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.item.isDismissed != oldWidget.item.isDismissed) {
      isDismissed = widget.item.isDismissed;
    }
  }
"""

if "void didUpdateWidget" not in cal_card:
    cal_card = cal_card.replace("void initState() {", cal_did_update + "\n  @override\n  void initState() {")

with io.open(r'packages/calendar/lib/src/presentation/widgets/calendar_visit_card.dart', 'w', encoding='utf-8') as f:
    f.write(cal_card)

