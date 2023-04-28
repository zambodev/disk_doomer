# Disk Doomer
Bare metal disk wiper, overwrite every bit with 0s

## Under develptment: It's not currently usable

# How to compile
```bash
nasm -fbin main.asm -o diskdoomer.bin
```

# Testing with Qemu
```bash
 qemu-system-x86_64 diskdoomer.bin
```

