build:
   @echo "Building..."
   arm-none-eabi-gcc -mcpu=cortex-a9 -mfpu=neon -mfloat-abi=hard -mthumb -ffreestanding -nostdlib -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -Wl,-Tlink/v5.ld -o out/output.elf src/*.S
   @echo "Stripping..."
   arm-none-eabi-objcopy out/output.elf --gap-fill 0x00 -O binary out/output.bin

upload slot='1' action='none':
   @just build
   @echo "Uploading..."
   cargo-v5 v5 upload --file out/output.bin --upload-strategy monolith --description "Hello, assembly!" --icon code-file --slot {{slot}} --after {{action}}
run slot='1':
   @just upload {{slot}} 'run'