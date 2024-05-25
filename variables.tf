# Variable definitions for Proxmox provider configuration

variable "proxmox_api_url" {
  description = "The URL for the Proxmox API."
  type        = string
}

variable "proxmox_api_token_id" {
  description = "The token ID used for authentication with the Proxmox API."
  type        = string
}

variable "proxmox_api_token_secret" {
  description = "The token secret used for authentication with the Proxmox API."
  type        = string
}
