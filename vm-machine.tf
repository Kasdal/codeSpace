resource "proxmox_vm_qemu" "node" {
    count = 5

    target_node = "proxmox"
    name = "node-${count.index}"
    desc = "Vme"
    full_clone = true
    onboot = true 

    clone = "ubuntu-jammy"

    cores = 1
    sockets = 2
    cpu = "host"    

    memory = 2048

    disk {
        type = "scsi"
        storage = "local-lvm"
        size = "40G" 
    }

    network {
        bridge = "vmbr0"
        model  = "virtio"
    }

    os_type = "cloud-init"

    ipconfig0 = "ip=192.168.1.${100 + count.index}/24,gw=192.168.1.254"
    nameserver = "192.168.1.254"
}
