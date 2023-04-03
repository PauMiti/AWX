variable "public_subnet_cidrs" {

 type        = list(string)

 description = "Public Subnet CIDR values"

 default     = ["10.0.1.0/24", "10.0.2.0/24"]

}

 

variable "private_subnet_cidrs" {

 type        = list(string)

 description = "Private Subnet CIDR values"

 default     = ["10.0.11.0/24", "10.0.12.0/24"]

}
variable "azs" {

 type        = list(string)

 description = "Availability Zones"

 default     = ["us-east-1a", "us-east-1b"]

}
variable "key_pair_name" {
  type = string
  default  = "demokeypair"
}
variable "public_key"{
    type = string
    default  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOHJagMVRVoBwVDF+jGwVz/+UXgjKYQYwqlgy7G8R/+pf3flQ4W6BXAlOXO9mn9gBprdNSE63AQbX7kEAHvEX8I3sLEVa5Zwh66egxeVv3KiN2W4M+gfpoBH20nVSgDO1AeauAd0yKvfSKTeCz/Aa52mQlZ53L4Dt+fEAZMG+RB3UZtkbIQgymi1KlpLngXE9ZVijG/bg0XPZKbs3BC7ndRnNFPoEkWXZcWT9YxDgJ6E2KRMMu1pA5bstmmDEScloYbx2ZAo2fMKifI8XQFZ+gyXIOgcUJu2iTnIIIawelREDqni71PniqcJ85/EJOV7Ex+++V4FRxs+TAlR90F1NJo3lOXs9DMceOzqwg40BNMkHP9Gj+Wvr/S2UzeLfnLC663F6qcTTcZzje6RFfPSGS2JzR5rLuVjwHOzFnpkHWdLSUSdiM7BxEwoeaLRa1UBO2TVIEJ++D+HTOmgrRvv5pvGMnbVt7W7OvGnrx19KW4hl3sPg6nGWMX0ak9+NsXN0= cloud_user@551937df9d1c.mylabserver.com"
}