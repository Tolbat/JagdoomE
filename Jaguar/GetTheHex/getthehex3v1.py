import os
import re
import shutil

# Paths to important files - update these paths if your files are located elsewhere
DOOM_BIN_PATH = r"C:\Jaguar\GetTheHex\Tolbat.J64"   # Path to the binary file to search for the IWAD marker
JAGONLY_C_PATH = r"C:\Jaguar\GetTheHex\jagonly.c"    # Path to the source code file (jagonly.c) to update
BOOT_S_PATH = r"C:\Jaguar\GetTheHex\boot.s"          # Path to the boot.s assembly file to update

# Function to find the offset of IWAD occurrences in the binary file
def find_iwad_offsets(binary_path):
    """
    Reads a binary file and locates all occurrences of the "IWAD" marker.

    Args:
        binary_path (str): The path to the binary file to search.

    Returns:
        list: A list of offsets where "IWAD" is found.
    """
    try:
        with open(binary_path, "rb") as file:
            content = file.read()  # Read the entire binary content

            # Locate all occurrences of "IWAD" using a regular expression
            matches = [m.start() for m in re.finditer(b"IWAD", content)]
            
            # Print details about the found occurrences
            for idx, match in enumerate(matches):
                print(f"IWAD occurrence {idx + 1}: Offset {hex(match)}")

            return matches
    except Exception as e:
        print(f"An error occurred while finding IWAD: {e}")
        return []

# Function to update jagonly.c with a backup
def backup_and_update_jagonly(iwad_offset, jagonly_path):
    """
    Creates a backup of jagonly.c and updates it with the correct IWAD memory address.
    
    Args:
        iwad_offset (int): The offset of the IWAD in the binary file.
        jagonly_path (str): The path to the jagonly.c file.

    Returns:
        None
    """
    try:
        # The ROM load address in memory where the binary is loaded
        rom_load_address = 0x800000  # Base address in memory for the ROM
        iwad_address = rom_load_address + iwad_offset  # Calculate the absolute memory address
        new_offset = f"0x{iwad_address:06X}"  # Format the address as a hex string (uppercase)

        # Create a backup of jagonly.c
        backup_path = jagonly_path + ".bak"
        shutil.copy(jagonly_path, backup_path)
        print(f"Backup created: {backup_path}")

        # Read the content of jagonly.c
        with open(jagonly_path, "r") as file:
            content = file.read()

        # Update the memory address in jagonly.c
        updated_content = re.sub(
            r"return \(byte \*\)0x[0-9A-Fa-f]+;", 
            f"return (byte *){new_offset};", 
            content
        )

        # Write the updated content back to jagonly.c
        with open(jagonly_path, "w") as file:
            file.write(updated_content)

        print(f"Updated jagonly.c with IWAD offset: {new_offset}")
    except Exception as e:
        print(f"An error occurred while updating jagonly.c: {e}")

# Function to update boot.s with a backup
def update_boot_s(iwad_offset, boot_s_path):
    """
    Updates boot.s with the correct memory address of the IWAD based on its offset.
    
    Args:
        iwad_offset (int): The offset of the IWAD in the binary file.
        boot_s_path (str): The path to the boot.s file.

    Returns:
        None
    """
    try:
        # Convert the IWAD offset to the hexadecimal address format used in boot.s
        new_address = f"${iwad_offset:X}"  # Ensure proper capitalization and format

        # Create a backup of boot.s
        backup_path = boot_s_path + ".bak"
        shutil.copy(boot_s_path, backup_path)
        print(f"Backup created: {backup_path}")

        # Read the content of boot.s
        with open(boot_s_path, "r") as file:
            content = file.read()

        # Update the memory address in the specific line containing "lea $"
        updated_content = re.sub(
            r"(lea\s+\$[0-9A-Fa-f]+,a2)", 
            f"lea     {new_address},a2", 
            content
        )

        # Write the updated content back to boot.s
        with open(boot_s_path, "w") as file:
            file.write(updated_content)

        print(f"Updated boot.s with IWAD offset: {new_address}")
    except Exception as e:
        print(f"An error occurred while updating boot.s: {e}")

# Main program entry point
if __name__ == "__main__":
    # Step 1: Find the IWAD offsets in the binary file
    iwad_offsets = find_iwad_offsets(DOOM_BIN_PATH)
    if len(iwad_offsets) >= 3:
        print(f"Third IWAD offset: {hex(iwad_offsets[2])}")

        # Step 2: Update jagonly.c with the calculated IWAD address
        backup_and_update_jagonly(iwad_offsets[2], JAGONLY_C_PATH)

        # Step 3: Update boot.s with the calculated IWAD address
        update_boot_s(iwad_offsets[2], BOOT_S_PATH)
    else:
        print("Error: Could not find the third IWAD reference.")
