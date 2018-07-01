module Terraform.AWS.RDS exposing (..)

{-| AWS RDS specific Terraform wrappers.

@docs DbInstanceType, dbInstanceTypeToString, StorageType, storageTypeToString
-}

{-| Represents the available types of AWS RDS instances.

see https://aws.amazon.com/rds/instance-types/
-}
type DbInstanceType
  =
  -- General purpose, burstable
  Db_T2_micro
  | Db_T2_small
  | Db_T2_medium
  | Db_T2_large
  | Db_T2_xlarge
  | Db_T2_2xlarge
  -- General purpose, latest generation
  | Db_M4_large
  | Db_M4_xlarge
  | Db_M4_2xlarge
  | Db_M4_4xlarge
  | Db_M4_10xlarge
  | Db_M4_16xlarge
  -- General purpose, current generation
  | Db_M3_medium
  | Db_M3_large
  | Db_M3_xlarge
  | Db_M3_2xlarge
  -- Memory optimized, latest generation
  | Db_R4_large
  | Db_R4_xlarge
  | Db_R4_2xlarge
  | Db_R4_4xlarge
  | Db_R4_8xlarge
  | Db_R4_16xlarge
  -- Memory optimized, latest generation
  | Db_X1e_xlarge
  | Db_X1e_2xlarge
  | Db_X1e_4xlarge
  | Db_X1e_8xlarge
  | Db_X1e_16xlarge
  | Db_X1e_32xlarge
  -- Memory optimized, latest generation
  | Db_X1_16xlarge
  | Db_X1_32xlarge
  -- Memory optimized, current generation
  | Db_R3_large
  | Db_R3_xlarge
  | Db_R3_2xlarge
  | Db_R3_4xlarge
  | Db_R3_8xlarge

{-| Converts DbInstanceTypes to String, it is used for JSON encoding.
-}
dbInstanceTypeToString : DbInstanceType -> String
dbInstanceTypeToString instanceType =
    case instanceType of
    Db_T2_micro -> "db.t2.micro"
    Db_T2_small -> "db.t2.small"
    Db_T2_medium -> "db.t2.medium"
    Db_T2_large -> "db.t2.large"
    Db_T2_xlarge -> "db.t2.xlarge"
    Db_T2_2xlarge -> "db.t2.2xlarge"

    Db_M4_large -> "db.m4.large"
    Db_M4_xlarge -> "db.m4.xlarge"
    Db_M4_2xlarge -> "db.m4.2xlarge"
    Db_M4_4xlarge -> "db.m4.4xlarge"
    Db_M4_10xlarge -> "db.m4.10xlarge"
    Db_M4_16xlarge -> "db.m4.16xlarge"

    Db_M3_medium -> "db.m3.medium"
    Db_M3_large -> "db.m3.large"
    Db_M3_xlarge -> "db.m3.xlarge"
    Db_M3_2xlarge -> "db.m3.2xlarge"

    Db_R4_large -> "db.r4.large"
    Db_R4_xlarge -> "db.r4.xlarge"
    Db_R4_2xlarge -> "db.r4.2xlarge"
    Db_R4_4xlarge -> "db.r4.4xlarge"
    Db_R4_8xlarge -> "db.r4.8xlarge"
    Db_R4_16xlarge -> "db.r4.16xlarge"

    Db_X1e_xlarge -> "db.x1e.xlarge"
    Db_X1e_2xlarge -> "db.x1e.2xlarge"
    Db_X1e_4xlarge -> "db.x1e.4xlarge"
    Db_X1e_8xlarge -> "db.x1e.8xlarge"
    Db_X1e_16xlarge -> "db.x1e.16xlarge"
    Db_X1e_32xlarge -> "db.x1e.32xlarge"
    Db_X1_16xlarge -> "db.x1.16xlarge"
    Db_X1_32xlarge -> "db.x1.32xlarge"

    Db_R3_large -> "db.r3.large"
    Db_R3_xlarge -> "db.r3.xlarge"
    Db_R3_2xlarge -> "db.r3.2xlarge"
    Db_R3_4xlarge -> "db.r3.4xlarge"
    Db_R3_8xlarge -> "db.r3.8xlarge"


{-| Represents the available storage types of AWS RDS instances.

see https://www.terraform.io/docs/providers/aws/r/db_instance.html#storage_type
-}
type StorageType =
  Standard
  | GP2
  | IO1


{-| Converts DbInstanceTypes to String, it is used for JSON encoding.
-}
storageTypeToString : StorageType -> String
storageTypeToString storageType =
    case storageType of
    Standard -> "standard"
    GP2 -> "gp2"
    IO1 -> "io1"
