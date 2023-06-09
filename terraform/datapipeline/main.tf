module "network" {
    source = "../modules/vpc/vpc"
    cidr   = "${var.vpc_cidr}"
}

module "security_groups" {
    source                = "../modules/vpc/security_groups"
    inbound               = [ "SSH", "Airbyte", "Redash", "Postgres"]
    vpc_id                = module.network.vpc.id
    vpc_cidr              = module.network.vpc.cidr_block
    depends_on = [
      module.network
    ]
}

module "database" {
    source = "../modules/rds"
    subnet_ids      = [module.network.subnet_1.id, module.network.subnet_2.id]
    security_groups = [
        "${module.security_groups.groups_all_to_intranet[index(module.security_groups.groups_all_to_intranet.*.name, "allow_postgres_from_intranet")].id}"
    ]
    depends_on      = [
      module.network
    ]
}

module "airbyte" {
    source          = "../modules/ec2/auto_scaling_group"
    application     = "airbyte"
    subnet_id       = module.network.subnet_1.id
    user_data       = "scripts/airbyte.sh"
    security_groups = [
        "${module.security_groups.groups_all_to_intranet[index(module.security_groups.groups_all_to_intranet.*.name, "allow_airbyte_from_intranet")].id}",
        "${module.security_groups.groups_all_to_intranet[index(module.security_groups.groups_all_to_intranet.*.name, "allow_ssh_from_intranet")].id}",
        "${module.security_groups.groups_all_to_everywhere.id}"
    ]
    depends_on      = [
      module.database,
      module.security_groups,
      local_file.airbyte
    ]
}

module "redash" {
    source          = "../modules/ec2/auto_scaling_group"
    application     = "redash"
    subnet_id       = module.network.subnet_1.id
    user_data       = "scripts/redash.sh"
    ami             = "ami-060741a96307668be"
    security_groups = [
        "${module.security_groups.groups_all_to_intranet[index(module.security_groups.groups_all_to_intranet.*.name, "allow_redash_from_intranet")].id}",
        "${module.security_groups.groups_all_to_intranet[index(module.security_groups.groups_all_to_intranet.*.name, "allow_ssh_from_intranet")].id}",
        "${module.security_groups.groups_all_to_everywhere.id}"
    ]
    depends_on      = [
      module.database,
      module.security_groups,
      local_file.airbyte
    ]
}