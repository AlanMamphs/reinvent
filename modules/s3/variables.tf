variable "name" {
  type        = string
  description = "S3 bucket name"
}


variable "enable_cors" {
  type        = bool
  description = "Enable CORS"
  default     = false
}


variable "cors_configuration" {
  type = object({
    allowed_origins = list(string)
    allowed_methods = list(string)
    allowed_headers = list(string)
    expose_headers  = list(string)
    max_age_seconds = number
  })

  default = {
    allowed_headers = ["*"]
    allowed_origins = ["*"]
    allowed_methods = ["GET", "HEAD"]
    expose_headers  = []
    max_age_seconds = 3600
  }
}


variable "enable_versioning" {
  type        = bool
  description = "Enable versioning"
  default     = false
}
