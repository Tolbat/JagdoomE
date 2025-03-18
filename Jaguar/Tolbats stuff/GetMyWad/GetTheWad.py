import os

def create_doom_wad():
    rom_file = "C:\\jaguar\\GetMyWad\\Doom.j64"
    output_file = "C:\\jaguar\\src\\doom.wad"
    block_size = 256 * 1024  # 256KB

    # Check if the ROM file exists
    if not os.path.isfile(rom_file):
        print(f"Error: ROM file '{rom_file}' not found.")
        return

    try:
        # Open the input and output files
        with open(rom_file, "rb") as infile, open(output_file, "wb") as outfile:
            # Skip the first block
            infile.seek(block_size)
            # Copy the rest of the file
            while chunk := infile.read(block_size):
                outfile.write(chunk)

        print(f"'{output_file}' has been created successfully.")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    create_doom_wad()
