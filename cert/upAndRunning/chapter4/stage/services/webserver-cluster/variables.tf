variable "number_example" {
  description = "An example of a number"
  type        = number
  default     = 42
}

variable "list_example" {
  description = "example of list in terra"
  type        = list
  default     = ["a", "b", "c"]
}

variable "list_numeric_example" {
  description = "list of numbers"
  type        = list(number)
  default     = [1, 2, 3]
}

variable "map_example" {
  description = "an example of map in terra"
  type        = map(string)
  default = {
    key1 = "value 1"
    key2 = "value 2"
    key3 = "value 3"
  }

}

variable "object_example" {
  description = "Example of structural type in terra"
  type = object({
    name   = string
    age    = number
    tags   = list(string)
    enable = bool
  })

  default = {
    name   = "value 1"
    age    = 34
    tags   = ["a", "b", "c"]
    enable = true
  }
}

variable "server_port" {
  description = "port to get all  http request"
  type        = number
  default     = 99
}