#!/bin/bash

echo "[i] Mounting VM_SHARE   (/mnt/hgfs/VM_SHARE)"
mkdir -p "/mnt/hgfs/VM_SHARE"
umount -f "/mnt/hgfs/VM_SHARE" 2>/dev/null
vmhgfs-fuse -o allow_other -o auto_unmount ".host:/VM_SHARE" "/mnt/hgfs/VM_SHARE"

