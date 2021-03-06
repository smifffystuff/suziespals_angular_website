data "aws_subnet_ids" "subnets" {
  vpc_id = "vpc-09189870"
}

module "get_pets" {
  source = "./function"

  region        = "${var.region}"
  function_name = "${var.name}_api_getPets"
  file_name     = "${path.module}/zips/getPets.zip"
  iam_role_arn  = "${var.iam_role_arn}"
  subnet_ids    = "${data.aws_subnet_ids.subnets.ids}"
}

output "get_pets_lambda_arn" {
  value = "${module.get_pets.arn}"
}

module "create_pet" {
  source = "./function"

  region        = "${var.region}"
  function_name = "${var.name}_api_createPet"
  file_name     = "${path.module}/zips/createPet.zip"
  iam_role_arn  = "${var.iam_role_arn}"
  subnet_ids    = "${data.aws_subnet_ids.subnets.ids}"
  timeout       = "30"
}

output "create_pet_lambda_arn" {
  value = "${module.create_pet.arn}"
}

module "get_all_posts" {
  source = "./function"

  region        = "${var.region}"
  function_name = "${var.name}_api_getAllPosts"
  file_name     = "${path.module}/zips/getAllPosts.zip"
  iam_role_arn  = "${var.iam_role_arn}"
  subnet_ids    = "${data.aws_subnet_ids.subnets.ids}"
}

output "get_all_posts_lambda_arn" {
  value = "${module.get_all_posts.arn}"
}

# resource "aws_lambda_function" "create_pet" {
#   function_name    = "${var.name}_api_createPetProfile"
#   filename         = "${path.module}/zips/createPetProfile.zip"
#   role             = "${var.iam_role_arn}"
#   handler          = "index.handler"
#   source_code_hash = "${base64sha256(file("${path.module}/zips/createPetProfile.zip"))}"
#   runtime          = "nodejs8.10"


#   vpc_config = {
#     subnet_ids = [
#       "${data.aws_subnet_ids.subnets.ids[0]}",
#       "${data.aws_subnet_ids.subnets.ids[1]}",
#       "${data.aws_subnet_ids.subnets.ids[2]}",
#     ]


#     security_group_ids = [
#       "sg-955cd1e4",
#     ]
#   }
# }


# output "create_pet_lambda_arn" {
#   value = "${aws_lambda_function.create_pet.arn}"
# }

