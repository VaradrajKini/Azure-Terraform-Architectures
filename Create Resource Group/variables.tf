variable "location" {
    type = string
    default = "East US 2"
}

variable "ResourceGroupName" {
    type = string
}

variable "tags" {
    type = map(string)
    default = {
        Project = "My_Project"
        Environment = "DEV"
        Department = "Finance"
        "Application Owner" = "Owner_Name"
    }
}