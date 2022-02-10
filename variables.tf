##
## These variables need to be provided by tfvars or by variables in Terraform Cloud.
##

variable "intersight-keyid" {
  description = "This value is used to connect the Intersight provider"
  type        = string
}

variable "intersight-secretkey" {
  description = "This value is used to connect the Intersight provider"
  type        = string
}

variable "imc_local_admin_password" {
  description = "This value is used in policy_local_user.tf to set the password for the IMC local user named admin."
  type        = string
}
