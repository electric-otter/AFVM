# Check if lsusb detects any USB device
USB_PRESENT := $(shell if command -v lsusb >/dev/null 2>&1; then lsusb | grep -q "Bus" && echo yes || echo no; else echo no; fi)

all:
ifeq ($(USB_PRESENT), yes)
	@echo "USB device detected, building specific target..."
	# Compile code that requires a USB device
else
	@echo "No USB device found, building basic target..."
	# Compile basic code without USB functionality
endif
