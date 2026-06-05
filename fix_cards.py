# -*- coding: utf-8 -*-
import io, re

# Update VisitScheduleCard
with io.open(r'packages/home_page/lib/src/presentation/widgets/visit_schedule_card.dart', 'r', encoding='utf-8') as f:
    home_card = f.read()

home_init_state = """
  @override
  void initState() {
    super.initState();
    isDismissed = widget.item.isDismissed;
  }
"""

if "void initState()" not in home_card:
    home_card = home_card.replace("bool isDismissed = false;", "bool isDismissed = false;\n" + home_init_state)

home_on_changed = """onChanged: (val) {
                  setState(() {
                    isDismissed = val ?? false;
                  });
                  // Update Firestore
                  try {
                    import_firebase_firestore().collection('Customer').doc(widget.item.customerId).collection('services').doc(widget.item.serviceId).update({'isDismissed': val ?? false});
                  } catch (_) {}
                },"""

home_card = re.sub(r'onChanged: \(val\) \{[\s\S]*?\},', home_on_changed, home_card)
home_card = home_card.replace("import_firebase_firestore()", "FirebaseFirestore.instance")

if "import 'package:cloud_firestore/cloud_firestore.dart';" not in home_card:
    home_card = "import 'package:cloud_firestore/cloud_firestore.dart';\n" + home_card

with io.open(r'packages/home_page/lib/src/presentation/widgets/visit_schedule_card.dart', 'w', encoding='utf-8') as f:
    f.write(home_card)


# Update CalendarVisitCard
with io.open(r'packages/calendar/lib/src/presentation/widgets/calendar_visit_card.dart', 'r', encoding='utf-8') as f:
    cal_card = f.read()

cal_init_state = """
  @override
  void initState() {
    super.initState();
    isDismissed = widget.item.isDismissed;
  }
"""

if "void initState()" not in cal_card:
    cal_card = cal_card.replace("bool isDismissed = false;", "bool isDismissed = false;\n" + cal_init_state)

cal_on_changed = """onChanged: (val) {
                  setState(() {
                    isDismissed = val ?? false;
                  });
                  // Update Firestore
                  try {
                    final serviceId = widget.item.id.replaceFirst('notif_', '');
                    import_firebase_firestore().collection('Customer').doc(widget.item.customerId).collection('services').doc(serviceId).update({'isDismissed': val ?? false});
                  } catch (_) {}
                },"""

cal_card = re.sub(r'onChanged: \(val\) \{[\s\S]*?\},', cal_on_changed, cal_card)
cal_card = cal_card.replace("import_firebase_firestore()", "FirebaseFirestore.instance")

if "import 'package:cloud_firestore/cloud_firestore.dart';" not in cal_card:
    cal_card = "import 'package:cloud_firestore/cloud_firestore.dart';\n" + cal_card

with io.open(r'packages/calendar/lib/src/presentation/widgets/calendar_visit_card.dart', 'w', encoding='utf-8') as f:
    f.write(cal_card)

