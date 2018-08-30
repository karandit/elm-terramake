module Terraform exposing (..)

{-| Terraform entities.

@docs Tfvars, Tfvar, fromMaybe
-}
import Terraform.AWS as AWS
import Terraform.AWS.EC2 as EC2
import Terraform.AWS.RDS as RDS


{-| Represents a list of tf variables.
-}
type alias Tfvars =
    List Tfvar

{-| Converts a Maybe into a Tfvar.
-}
fromMaybe : (a -> Tfvar) -> Maybe a -> Tfvar
fromMaybe wrapper val =
  val |> Maybe.map wrapper |> Maybe.withDefault TfvarNone


{-| Represents a tf variable. This is exported to JSON.
-}
type Tfvar
    = TfvarNone
    | TfvarObject String Tfvar
    | TfvarString String String
    | TfvarInt String Int
    | TfvarRegion String AWS.Region
    | TfvarInstanceType String EC2.InstanceType
    | TfvarDbInstanceType String RDS.DbInstanceType
    | TfvarStorageType String RDS.StorageType
