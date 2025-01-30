build:
   @echo "Building..."
   arm-none-eabi-gcc \
      -mcpu=cortex-a9 \
      -mfpu=neon \
      -mfloat-abi=hard \
      -mthumb \
      -nostdlib \
      -Wl,-Llink,-Tv5.ld,-lgcc \
      -o out/output.elf \
      src/*.S
   @echo "Stripping..."
   arm-none-eabi-objcopy out/output.elf --gap-fill 0x00 -O binary out/output.bin
clean:
   @echo "Cleaning..."
   rm -rf out
   mkdir out


upload slot='1' action='none':
   @just build
   @echo "Uploading..."
   cargo-v5 v5 upload --file out/output.bin --upload-strategy monolith --description "Hello, assembly!" --icon code-file --slot {{slot}} --after {{action}}
run slot='1':
   @just upload {{slot}} 'run'