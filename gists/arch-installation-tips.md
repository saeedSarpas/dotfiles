# Arch Installation Tips

## Time management

Use `timedatectl` to manage time.

### Examples

- `timedatectl set-ntp trye`
  to enable Network Time Protocol (NTP) enable.

## Partitioning

To look at the current partioning and their UUID (for GPT partitions), run:
- `lsblk -f`

Both `fdisk` and `parted` are great for partitioning.

### `fdisk` examples

- `fdisk -l`
  to see the current partitioning
- `fdisk device[/dev/nvme0n1]`
  to partition a disk

### Notes

- Format the EFI system partition as fat32
  `mkfs.fat -F 32 device[/dev/nvme0n1p1]`

## System encryption

From `archiso`, one should use `cryptsetup` which always make sure the `dm_crypt` kernel is loaded.

- `cryptsetup luksFormat [--sector-size 512] device[/dev/nvme0n1p2]`
  to encrypt a device/partition with LUKS2 mode (providing `cryptsetup` version > 2.4).
- `cryptsetup open device[/dev/nvme0n1p2] dm_name[cryptroot]`
  to open an encrypted device/partition.
- `cryptsetup close device[/dev/nvme0n1p2]`

After opening an encrypted device, you can format it easily by executing:
- `mkfs -t ext4 /dev/mapper/dm_name[cryptroot]`

If encrypting `/root` directory, we need to decrypt at the bootloader stage.

### mkinitcpio

Add the following hooks to the `/etc/mkinitcpio.conf` for `encrypt` (avoid `sd-encrypt` as we do not like `systemd`!):
- HOOKS=(base udev autodetect keyboard modconf block encrypt filesystems fsck)

### grub

We need to set a kernel parameter in `/etc/default/grub`:
- GRUB_CMDLINE_LINUX="cryptdevice=/dev/nvme0n1p3:cryptroot"


