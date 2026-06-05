import sys

file_path = "packages/customer_directory/lib/src/presentation/widgets/profile_header_card.dart"

with open(file_path, "r", encoding="utf-8") as f:
    content = f.read()

target = """                    final rawNumber = customer.number.split(',').first.trim();
                    final cleanNum = rawNumber.replaceAll(
                      RegExp(r'[^0-9]'),
                      '',
                    );
                    final finalNum = cleanNum.length == 10
                        ? '91$cleanNum'
                        : cleanNum;
                    final url = Uri.parse('https://wa.me/$finalNum');"""

replacement = """                    final url = PhoneUtils.getWhatsAppUri(customer.number);
                    if (url == null) return;"""

if target in content:
    content = content.replace(target, replacement)
    content = content.replace("import 'package:core_ui/core_ui.dart';", "import 'package:core_ui/core_ui.dart';\nimport 'package:core/core.dart';")
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(content)
    print("Replaced successfully")
else:
    print("Target not found")
