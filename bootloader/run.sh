gcc -m32 -ffreestanding -fno-pic -nostdlib -c kernel.c -o kernel.o
nasm -f bin bootloader.asm -o bootloader.bin
ld -m elf_i386 -Ttext 0x1000 kernel.o -o kernel.bin --oformat binary
cat bootloader.bin kernel.bin > os-image.bin
qemu-system-x86_64 -drive format=raw,file=os-image.bin
