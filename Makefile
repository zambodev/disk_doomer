# Compiler
CC = nasm
CFLAGS = -felf32
LD = ld
LFLAGS = -melf_i386

# Folders
CFG = grub.cfg
ISO_PATH := iso
BOOT_PATH := $(ISO_PATH)/boot
GRUB_PATH := $(BOOT_PATH)/grub

# Files
ISOF = disk_doomer.iso
KF = kernel
ASMF = $(wildcard *.asm)
OBJF = $(ASMF:.asm=.o)
LDF = *.ld

.PHONY: all
all: $(ISOF)
	@echo Make has completed.

%.o: %.asm
	$(CC) $(CFLAGS) $^ -o $@

$(KF): $(OBJF)
	$(LD) $(LFLAGS) -T $(LDF) -o $(KF) $^

$(ISOF): $(KF)
	mkdir -pv $(GRUB_PATH)
	cp $(KF) $(BOOT_PATH)
	cp $(CFG) $(GRUB_PATH)
	grub-file --is-x86-multiboot $(BOOT_PATH)/$(KF)
	grub-mkrescue -o $@ $(ISO_PATH)

.PHONY: clean
clean:
	rm -rf *.o $(KF) *iso

