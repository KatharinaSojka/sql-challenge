import chardet

with open('employees.csv', 'rb') as f:
    result = chardet.detect(f.read())

print("Detected Encoding:", result['encoding'])