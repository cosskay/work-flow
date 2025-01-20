import base64

def decode_ldif(file_path, output_file):
    with open(file_path, "r", encoding="utf-8") as infile, open(output_file, "w", encoding="utf-8") as outfile:
        for line in infile:
            if ":: " in line:  # Проверяем строки, которые закодированы в Base64
                key, value = line.split(":: ", 1)
                decoded_value = base64.b64decode(value.strip()).decode("utf-8")
                outfile.write(f"{key}: {decoded_value}\n")  
            else:
                outfile.write(line)  # Пишем строки без изменений

# Укажите путь к вашему LDIF-файлу и имя выходного файла
input_file = "_file.ldf"  
output_file = "decoded_file.ldf"

decode_ldif(input_file, output_file)
print(f"Декодированный файл сохранён как {output_file}")
