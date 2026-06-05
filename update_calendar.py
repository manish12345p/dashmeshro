import io, re

with io.open(r'packages/calendar/lib/src/presentation/view/calendar_view.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Update initial selected date
content = re.sub(
    r'DateTime _selectedDate = DateTime\(2024, 10, 7\);',
    r'DateTime _selectedDate = DateTime.now();',
    content
)

# 2. Remove filters (SingleChildScrollView containing _buildCategoryChip)
content = re.sub(
    r'// Filters.*?const SizedBox\(height: AppPadding\.p24\),',
    r'',
    content,
    flags=re.DOTALL
)

# 3. Remove legend Row
content = re.sub(
    r'// Legends Row.*?Row\([^)]*children:.*?\[.*?\].*?\),',
    r'',
    content,
    flags=re.DOTALL
)

# 4. Remove "View All" and "Today, Oct X" text in Scheduled Services header
title_area_pattern = r'// Scheduled Services Title Area.*?(?=\s*const SizedBox\(height: AppPadding\.p12\),)'
new_title_area = """// Scheduled Services Title Area
                const Text(
                  'Scheduled Visits',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                  ),
                ),"""
content = re.sub(title_area_pattern, new_title_area, content, flags=re.DOTALL)


# Write back
with io.open(r'packages/calendar/lib/src/presentation/view/calendar_view.dart', 'w', encoding='utf-8') as f:
    f.write(content)
