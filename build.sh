#!/bin/sh
make clean
make all
./scripts/iso.sh
./scripts/qemu.sh
