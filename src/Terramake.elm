module Terramake exposing (exportAsTfvars, exportAsTfvarsWithArgs, withTerragrunt)

{-| Generate typesafe Terraform code.

@docs exportAsTfvars, exportAsTfvarsWithArgs, withTerragrunt
-}

import Platform
import Platform.Cmd as Cmd
import Platform.Sub as Sub
import Task
import Json.Decode
import Json.Encode as JE
import File
import Terraform exposing (..)
import Terraform.AWS as AWS
import Terraform.AWS.EC2 as EC2
import Terraform.AWS.RDS as RDS


type alias Flags =
    {
      filePath : String
    }

type alias TerragruntConfig x =
    { x
        | source : String
    }

{-| Append to the given Tfvars a Terragrunt specific Tfvar.
-}
withTerragrunt : TerragruntConfig x  -> Tfvars -> Tfvars
withTerragrunt config  vars =
  addTerragruntTfvar config.source vars

{-| Export the Tfvar list as JSON to a `.tfvars` file.
-}
exportAsTfvars : Tfvars -> Program Flags () ()
exportAsTfvars vars =
    Platform.programWithFlags
        { init = \flags -> ((), writeTfvars flags vars)
        , update = \_ _ -> ( (), Cmd.none )
        , subscriptions = \_ -> Sub.none
        }

{-| Export the Tfvar list as JSON to a `.tfvars` file with a callback allowing to get the input arguments.
-}
exportAsTfvarsWithArgs : (a -> Tfvars) -> Program (Flags, a) () ()
exportAsTfvarsWithArgs argsFetcher =
    Platform.programWithFlags
        { init = \(flags, args) -> ((), writeTfvars flags <| argsFetcher args)
        , update = \_ _ -> ( (), Cmd.none )
        , subscriptions = \_ -> Sub.none
        }

-- Local ---------------------------------------------------------------------------------------------------------------
writeTfvars :  Flags -> Tfvars -> Cmd ()
writeTfvars flags vars =
  let
      json = JE.encode 2 <| JE.object <| getEncoders vars
  in
      Task.attempt (\_ -> ()) (File.write (flags.filePath ++ ".tfvars") json)

getEncoders : Tfvars -> List (String, JE.Value)
getEncoders vars =
    List.map getEncoder vars

getEncoder : Tfvar -> (String, JE.Value)
getEncoder var =
  case var of
    TfvarObject fieldName objVar -> (fieldName, JE.object [getEncoder objVar])
    TfvarString fieldName value -> (fieldName, JE.string value)
    TfvarInt fieldName value -> (fieldName, JE.int value)
    TfvarRegion fieldName value -> (fieldName, JE.string <| AWS.regionToString value)
    TfvarInstanceType fieldName value -> (fieldName, JE.string <| EC2.instanceTypeToString value)
    TfvarDbInstanceType fieldName value -> (fieldName, JE.string <| RDS.dbInstanceTypeToString value)
    TfvarStorageType fieldName value -> (fieldName, JE.string <| RDS.storageTypeToString value)


addTerragruntTfvar : String -> Tfvars -> Tfvars
addTerragruntTfvar source =
  (::) (TfvarObject "terragrunt" ( TfvarObject "terraform"(TfvarString "source" source)))
