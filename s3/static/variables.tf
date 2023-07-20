variable "bucket_name" {
  type = string
  description = "The bucket name"
}

variable "index_file" {
  type = string
  description = "The index file"
  default = "index.html"
}

variable "error_file" {
  type = string
  description = "The error file"
  default = "index.html"
}

variable "tags" {
  type = map(string)
  description = "Bucket tags"
}
