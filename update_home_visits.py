# -*- coding: utf-8 -*-
import io, re

with io.open(r'packages/home_page/lib/src/presentation/view/home_page_view.dart', 'r', encoding='utf-8') as f:
    content = f.read()

total_visits_card = """// Top Summary Cards
                  SummaryCard(
                    overlineText: 'Total Visits',
                    valueText: '${data.totalServices} Visits',
                    subtitleText: 'Overall visits',
                    trailingIcon: const Icon(Icons.trending_up, color: Colors.green, size: 20),
                    trailingBackgroundColor: Colors.green.withOpacity(0.1),
                  ),
                  const SizedBox(height: AppPadding.p12),"""

content = content.replace("// Top Summary Cards", total_visits_card)

with io.open(r'packages/home_page/lib/src/presentation/view/home_page_view.dart', 'w', encoding='utf-8') as f:
    f.write(content)
