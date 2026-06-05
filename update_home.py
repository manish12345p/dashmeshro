import io, re

with io.open(r'packages/home_page/lib/src/presentation/view/home_page_view.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Replace the 4 SummaryCards with the 3 new ones
summary_cards_pattern = r'// Top Summary Cards.*?(?=// Today\'s Service Schedule|// Total Visit Schedule)'
replacement = """// Top Summary Cards
                  SummaryCard(
                    overlineText: 'New RO',
                    valueText: '${data.newRoServices} Visits',
                    subtitleText: 'Newly installed ROs',
                    trailingIcon: const Icon(Icons.water_drop, color: Colors.blue, size: 20),
                    trailingBackgroundColor: Colors.blue.withOpacity(0.1),
                  ),
                  const SizedBox(height: AppPadding.p12),
                  SummaryCard(
                    overlineText: 'Total AMC',
                    valueText: '${data.amcServices} Visits',
                    subtitleText: 'AMC visits performed',
                    trailingIcon: const Icon(Icons.verified_user, color: Colors.green, size: 20),
                    trailingBackgroundColor: Colors.green.withOpacity(0.1),
                  ),
                  const SizedBox(height: AppPadding.p12),
                  SummaryCard(
                    overlineText: 'Service & Repair',
                    valueText: '${data.repairServices} Visits',
                    subtitleText: 'Combined service and repair',
                    trailingIcon: const Icon(Icons.build, color: Colors.orange, size: 20),
                    trailingBackgroundColor: Colors.orange.withOpacity(0.1),
                  ),
                  const SizedBox(height: AppPadding.p32),

                  """

content = re.sub(summary_cards_pattern, replacement, content, flags=re.DOTALL)

# Add the list of notification cards under "Total Visit Schedule" and remove NewSellsSummaryCard
new_sells_pattern = r'// New Sells Summary.*?const SizedBox\(height: AppPadding\.p32\),'
list_replacement = """// List of today's visit schedules
                  if (data.todayNotifications.isNotEmpty)
                    ...data.todayNotifications.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: VisitScheduleCard(item: item),
                    )),
                  if (data.todayNotifications.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text('No visits scheduled for today', style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  const SizedBox(height: AppPadding.p32),"""

content = re.sub(new_sells_pattern, list_replacement, content, flags=re.DOTALL)

# Add import for the new card
if "import '../widgets/visit_schedule_card.dart';" not in content:
    content = content.replace("import '../widgets/new_sells_summary_card.dart';", "import '../widgets/visit_schedule_card.dart';")

with io.open(r'packages/home_page/lib/src/presentation/view/home_page_view.dart', 'w', encoding='utf-8') as f:
    f.write(content)
