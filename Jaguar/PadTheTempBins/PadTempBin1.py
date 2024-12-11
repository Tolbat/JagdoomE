import os

def pad_file_temp1():
    file_path = "C:\\Jaguar\\Temp\\TEMP1.BIN"
    target_size = 262144  # 256KB

    try:
        with open(file_path, 'rb') as file:
            data = file.read()
        current_size = len(data)
        
        if current_size < target_size:
            padding_size = target_size - current_size
            with open(file_path, 'ab') as file:
                file.write(b'\xFF' * padding_size)
            print(f"File '{file_path}' was padded to {target_size} bytes (256KB).")
        else:
            print(f"File '{file_path}' is already {current_size} bytes or larger. No padding applied.")
    except FileNotFoundError:
        print(f"Error: File '{file_path}' not found.")

if __name__ == "__main__":
    print("Padding TEMP1.BIN to 256KB...")
    pad_file_temp1()
