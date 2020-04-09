resource "aws_dynamodb_table" "addresses-table" {
  name = "Addresses"
  billing_mode = "PROVISIONED"
  read_capacity = 5
  write_capacity = 5
  hash_key = "StateOrProvince"
  range_key = "City"

  attribute {
    name = "StreetAddress"
    type = "S"
  }

  attribute {
    name = "City"
    type = "S"
  }

  attribute {
    name = "StateOrProvince"
    type = "S"
  }

  global_secondary_index {
    name = "StreetAddressIndex"
    hash_key = "StreetAddress"
    read_capacity = 5
    write_capacity = 5
    projection_type = "INCLUDE"
    non_key_attributes = ["City", "StateOrProvince"]
  }
}