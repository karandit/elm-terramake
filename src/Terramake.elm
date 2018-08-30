module Terramake exposing (Flags, exportAsTfvars, exportAsTfvarsWithArgs, withTerragrunt)

{-| Generate typesafe Terraform code.

@docs Flags, exportAsTfvars, exportAsTfvarsWithArgs, withTerragrunt
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

{-| Represents the incoming system args (e.g.: filePath)
-}
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
exportAsTfvars : Tfvars -> Program (Flags, {}) () ()
exportAsTfvars vars =
    Platform.programWithFlags
        { init = \(flags, _) -> ((), writeTfvars flags vars)
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
      lines = encodeTfVars "  " "" <| List.concatMap getEncoder vars
  in
      Task.attempt (\_ -> ()) (File.write (flags.filePath ++ ".tfvars") lines)

getEncoder : Tfvar -> List TfVarLine
getEncoder var =
  case var of
    TfvarNone -> []
    TfvarObject fieldName objVar -> [TfVarLineJson fieldName <| getEncoder objVar]
    TfvarString fieldName value -> [TfVarLineString fieldName value]
    TfvarInt fieldName value -> [TfVarLineInt fieldName value]
    TfvarRegion fieldName value -> [TfVarLineString fieldName <| AWS.regionToString value]
    TfvarInstanceType fieldName value -> [TfVarLineString fieldName <|EC2.instanceTypeToString value]
    TfvarDbInstanceType fieldName value -> [TfVarLineString fieldName <| RDS.dbInstanceTypeToString value]
    TfvarStorageType fieldName value -> [TfVarLineString fieldName <| RDS.storageTypeToString value]


addTerragruntTfvar : String -> Tfvars -> Tfvars
addTerragruntTfvar source =
  (::) (TfvarObject "terragrunt" ( TfvarObject "terraform"(TfvarString "source" source)))


-- TFvars Encode -------------------------------------------------------------------------------------------------------
type TfVarLine =
    TfVarLineString String String
    | TfVarLineInt String Int
    | TfVarLineJson String (List TfVarLine)

encodeTfVars : String -> String -> List TfVarLine -> String
encodeTfVars indent actIndent lines =
    String.join "\n" <| List.map (encodeTfVar indent actIndent) lines

encodeTfVar : String -> String ->  TfVarLine -> String
encodeTfVar indent actIndent line =
  case line of
    TfVarLineString key value -> actIndent ++ key ++ " = \"" ++ value ++ "\""
    TfVarLineInt key value    -> actIndent ++ key ++ " = " ++ (toString value)
    TfVarLineJson key lines   -> actIndent ++ key ++ " = {\n"
                                  ++ (encodeTfVars indent (indent ++ actIndent) lines) ++ "\n"
                                  ++ actIndent ++ "}"
