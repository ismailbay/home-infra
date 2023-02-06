locals {
  k8s_source_template = "ubuntu-cloud"

  k8s_masters = {
    m01 = { vmid = "101", name = "master01.k8s.ismailbay.at", ip = "192.168.1.101" },
    m02 = { vmid = "102", name = "master02.k8s.ismailbay.at", ip = "192.168.1.102" },
    m03 = { vmid = "103", name = "master03.k8s.ismailbay.at", ip = "192.168.1.103" }
  }

  k8s_workers = {
    w01 = { vmid = "104", name = "worker01.k8s.ismailbay.at", ip = "192.168.1.104" },
    w02 = { vmid = "105", name = "worker02.k8s.ismailbay.at", ip = "192.168.1.105" },
    w03 = { vmid = "106", name = "worker03.k8s.ismailbay.at", ip = "192.168.1.106" }
  }

}

resource "proxmox_vm_qemu" "ubuntu-k8s-masters" {
  for_each    = local.k8s_masters
  vmid        = each.value.vmid
  name        = each.value.name
  desc        = each.value.name
  target_node = "pve"
  os_type     = "cloud-init"
  full_clone  = true
  memory      = 8192
  sockets     = "1"
  cores       = 4
  cpu         = "host"
  scsihw      = "virtio-scsi-pci"
  clone       = local.k8s_source_template
  ciuser      = "ismail"
  sshkeys     = var.vm_ssh_keys
  tags        = "k8s"
  disk {
    size    = "30G"
    type    = "scsi"
    storage = "ssd-pool"
  }
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # Cloud-init section
  ipconfig0 = "ip=${each.value.ip}/24,gw=192.168.1.1"

  provisioner "local-exec" {
    # command = "ansible-playbook -i '${each.value.ip}', playbook/*"
    command = "echo '${each.value.ip}'"
  }
}

resource "proxmox_vm_qemu" "ubuntu-k8s-workers" {
  for_each    = local.k8s_workers
  vmid        = each.value.vmid
  name        = each.value.name
  desc        = each.value.name
  target_node = "pve"
  os_type     = "cloud-init"
  full_clone  = true
  memory      = 8192
  sockets     = "1"
  cores       = 4
  cpu         = "host"
  scsihw      = "virtio-scsi-pci"
  clone       = local.k8s_source_template
  ciuser      = "ismail"
  sshkeys     = var.vm_ssh_keys
  tags        = "k8s"
  disk {
    size    = "30G"
    type    = "scsi"
    storage = "ssd-pool"
  }
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # Cloud-init section
  ipconfig0 = "ip=${each.value.ip}/24,gw=192.168.1.1"

  provisioner "local-exec" {
    command = "echo '${each.value.ip}'"
  }
}
