variable "tags_tag_values" {
  description = <<EOT
Map of tags_tag_values, attributes below
Required:
    - parent
    - short_name
Optional:
    - deletion_policy
    - description
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    parent          = string
    short_name      = string
    deletion_policy = optional(string)
    description     = optional(string)
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.tags_tag_values : (
        length(v.short_name) >= 1 && length(v.short_name) <= 256
      )
    ])
    error_message = "must be between 1 and 256 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.tags_tag_values : (
        v.description == null || (length(v.description) >= 0 && length(v.description) <= 256)
      )
    ])
    error_message = "must be between 0 and 256 characters"
  }
}

