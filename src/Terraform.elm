module Terraform exposing (..)

{-| Terraform entities.

@docs Tfvars, Tfvar
-}
import Terraform.AWS as AWS
import Terraform.AWS.EC2 as EC2
import Terraform.AWS.RDS as RDS


{-| Represents a list of tf variables.
-}
type alias Tfvars =
    List Tfvar


{-| Represents a tf variable. This is exported to JSON.
-}
type Tfvar
    = TfvarObject String Tfvar
    | TfvarString String String
    | TfvarInt String Int
    | TfvarRegion String AWS.Region
    | TfvarInstanceType String EC2.InstanceType
    | TfvarDbInstanceType String RDS.DbInstanceType
    | TfvarStorageType String RDS.StorageType
