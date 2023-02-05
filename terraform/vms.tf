resource "proxmox_vm_qemu" "ubuntu-k8s-masters" {
  for_each    = var.k8s_masters
  vmid        = "1${each.key}"
  name        = each.value.name
  desc        = each.value.name
  target_node = each.value.target_node
  os_type     = "cloud-init"
  full_clone  = true
  memory      = each.value.memory
  sockets     = "1"
  cores       = each.value.cores
  cpu         = "host"
  scsihw      = "virtio-scsi-pci"
  clone       = var.k8s_source_template
  disk {
    size    = each.value.disk_size
    type    = "scsi"
    storage = "ssd-pool"
  }
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # Cloud-init section
  ipconfig0 = "ip=${each.value.ip}/24,gw=${each.value.gw}"
  
}