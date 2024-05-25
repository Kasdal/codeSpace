resource "proxmox_vm_qemu" "node" {
    count = 1

    target_node = "proxmox"
    agent = 1
    name = "node-0${count.index}"
    desc = "Vme"
    full_clone = true
    onboot = true 
    os_type = "cloud-init"
    clone = "RHEL9"
    bootdisk = "scsi0"
    cores = 2
    sockets = 2
    cpu = "host" 
    scsihw = "virtio-scsi-pci"   

    memory = 2048

    # Setup the disk
    disks {
        ide {
            ide3 {
                cloudinit {
                    storage = "local-lvm"
                }
            }
        }
        virtio {
            virtio0 {
                disk {
                    size            = 32
                    cache           = "writeback"
                    storage         = "local-lvm"
                    iothread        = true
                    discard         = true
                }
            }
        }
    }

    # Setup the network interface and assign a vlan tag: 256
    network {
        model = "virtio"
        bridge = "vmbr0"
        tag = 256
    }

    # Setup the ip address using cloud-init.
    boot = "order=virtio0"

    ipconfig0 = "ip=192.168.1.${100 + count.index}/24,gw=192.168.1.254"
    nameserver = "192.168.1.254"
}
