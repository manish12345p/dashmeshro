with open(r'packages/home_page/lib/src/presentation/view/home_page_view.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace('AppStrings.revenueFlow', "'Total Visits'")
content = content.replace('\ New Sells', '\ Visits')
content = content.replace('AppStrings.thisWeekPerformance', "'Overall visits'")

content = content.replace('AppStrings.assetRental', "'Services Required'")
content = content.replace('\ Active', '\ Pending')
content = content.replace('AppStrings.currentRentalPortfolio', "'Action required'")

content = content.replace('AppStrings.serviceContracts', "'Active AMCs'")

content = content.replace('AppStrings.todayServiceSchedule', "'Total Visit Schedule'")

old_btn = '''                    trailing: CustomButton(
                      label: AppStrings.viewCalendar,
                      onPressed: () => context.go('/calendar'),
                    ),'''
new_btn = '''                    trailing: TextButton(
                      onPressed: () => context.go('/calendar'),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      child: const Text('View Calendar', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),'''
content = content.replace(old_btn, new_btn)

with open(r'packages/home_page/lib/src/presentation/view/home_page_view.dart', 'w', encoding='utf-8') as f:
    f.write(content)
