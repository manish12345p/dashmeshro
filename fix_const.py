import os
import re

def fix_const_in_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Remove `const ` before widgets commonly affected by this
    # Regex looks for `const ` followed by widget name
    pattern = r'const\s+(Text|TextStyle|Icon|Padding|Column|Row|SizedBox|Center|Card|ListTile|Expanded|Flexible|Align|Container|CircleAvatar|DecoratedBox|BoxDecoration|EdgeInsets|BorderRadius|BorderSide|LinearGradient|BoxShadow|RoundedRectangleBorder|SingleChildScrollView)\b'
    
    new_content = re.sub(pattern, r'\1', content)
    
    if new_content != content:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Fixed {file_path}")

def main():
    root_dir = r"c:\Users\manis\dashmeshro\packages"
    for dirpath, _, filenames in os.walk(root_dir):
        for filename in filenames:
            if filename.endswith(".dart"):
                fix_const_in_file(os.path.join(dirpath, filename))

if __name__ == '__main__':
    main()
