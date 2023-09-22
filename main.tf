resource "proxmox_vm_qemu" "resource-name" {

  count = 10
  ### or for a PXE boot VM operation
  name        = "Terraform-${count.index}"
  desc = "A test for using terraform and cloudinit"

  target_node = "nuc"

  clone = "ubuntu-22.04"

  bios  = "seabios"
  cpu = "host"

  cores = 2
  sockets = 1

  memory = 2048
  qemu_os = "l26"
  onboot = true
  oncreate = true

  boot  = "c"
  bootdisk = "scsi0"
  ciuser = "ubuntu"

  sshkeys = <<-EOT
            ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHdYlEX3E/KDc0V/rehDOaeos258tTm26GsBEVBPOzlR mafonso@gmail.com
        EOT

  agent = 1

  define_connection_info = false
  full_clone = false
  scsihw = "virtio-scsi-pci"


  ipconfig0 = "ip=dhcp,ip6=dhcp"


  network {
    bridge    = "vmbr0"
    firewall  = false
    link_down = false
    model     = "virtio"
  }

  disk {
   iothread=0
   storage = "local-lvm"
   type = "scsi"
   size = "10G"
  }
}
