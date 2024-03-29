###
# Provider configuration
###
variable "globalaccount" {
  type        = string
  description = "The subdomain of the SAP BTP global account."
}

variable "region" {
  type        = string
  description = "The region where the project account shall be created in."
  default     = "eu10"
}

###
# Subaccount setup
###
variable "project_name" {
  type        = string
  description = "The subaccount name."
  default     = "proj-1234"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_\\-]{1,200}", var.project_name))
    error_message = "Provide a valid project name."
  }
}

variable "stage" {
  type        = string
  description = "The stage/tier the account will be used for."
  default     = "DEV"

  validation {
    condition     = contains(["DEV", "TST", "SBX", "PRD"], var.stage)
    error_message = "Select a valid stage for the project account."
  }
}

variable "costcenter" {
  type        = string
  description = "The cost center the account will be billed to."
  default     = "1234567890"

  validation {
    condition     = can(regex("^[0-9]{10}", var.costcenter))
    error_message = "Provide a valid cost center."
  }
}

variable "org_name" {
  type        = string
  description = "Defines to which organisation the project account shall belong to."
  default     = "B2C"

  validation {
    condition = contains(concat(
      // Cross Development
      ["B2B", "B2C", "ECOMMERCE"],
      // Internal IT
      ["PLATFORMDEV", "INTIT"],
    ), var.org_name)
    error_message = "Please select a valid org name for the project account."
  }
}

###
# Entitlements for Subaccount
###
variable "entitlements" {
  type = list(object({
    name   = string
    plan   = string
    amount = number
  }))
  description = "List of entitlements for the subaccount."
  default = [
    {
      name   = "alert-notification"
      plan   = "standard"
      amount = null
    },
    {
      name   = "SAPLaunchpad"
      plan   = "standard"
      amount = null
    },
    {
      name   = "hana-cloud"
      plan   = "hana"
      amount = null
    },
    {
      name   = "hana"
      plan   = "hdi-shared"
      amount = null
    },
    {
      name   = "sapappstudio"
      plan   = "standard-edition"
      amount = null
    }
  ]
}
