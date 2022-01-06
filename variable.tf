
######################################
# AWS US Regions Variable Declaration #
######################################

#us-east-1	
variable "us-east-region_01" {
  type        = string
  description = "US East (N. Virginia)"
  default     = "us-east-1"
}

#us-east-2	
variable "us-east-region_02" {
  type        = string
  description = "US East (Ohio)"
  default     = "us-east-2"
}

#us-west-1	
variable "us-west-region_01" {
  type        = string
  description = "US West (N. California)"
  default     = "us-west-1"
}

#us-west-2	
variable "us-west-region_02" {
  type        = string
  description = "US West (Oregon)"
  default     = "us-west-2"
}
