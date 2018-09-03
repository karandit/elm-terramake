module Terramake exposing (Flags, Tfvars, Tfvar
    , tfvar, fromString, fromInt, fromMaybe, fromList
    , exportAsTfvars, exportAsTfvarsWithArgs
    , withTerragrunt)

{-| Generate typesafe Terraform code.

@docs exportAsTfvars, exportAsTfvarsWithArgs
@docs withTerragrunt
@docs Flags, Tfvars, Tfvar
@docs tfvar, fromString, fromInt, fromMaybe, fromList
-}
import Platform
import Platform.Cmd as Cmd
import Platform.Sub as Sub
import Task
import Json.Decode
import Json.Encode as JE
import File

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

{-| Alias for a list of Tfvar
-}
type alias Tfvars = List Tfvar

{-| Represents a tf variable. This is exported to JSON.
-}
type Tfvar = Tfvar String Tfval

type Tfval
    = TfvalNone
    | TfvalString String
    | TfvalInt Int
    | TfvalList (List Tfval)
    | TfvalRecord Tfvars

{-| Creates Tfval from String
-}
fromString : String -> Tfval
fromString s =
  TfvalString s

{-| Creates Tfval from Int
-}
fromInt : Int -> Tfval
fromInt i =
  TfvalInt i

{-| Creates Tfval from Maybe
-}
fromMaybe : (a -> Tfval) -> Maybe a -> Tfval
fromMaybe wrapper val =
  val |> Maybe.map wrapper |> Maybe.withDefault TfvalNone

{-| Creates Tfval from List
-}
fromList : (a -> Tfval) -> List a -> Tfval
fromList wrapper vals =
  vals |> List.map wrapper |> TfvalList

fromRecord : (List Tfvar) -> Tfval
fromRecord fields =
  TfvalRecord fields

{-| Creates a Tfvar from the given fieldName and Tfval
-}
tfvar : String -> Tfval -> Tfvar
tfvar key value =
  Tfvar key value

{-| Append to the given Tfvars a Terragrunt specific Tfvar.
-}
withTerragrunt : TerragruntConfig x -> Tfvars -> Tfvars
withTerragrunt config vars =
  (::) (Tfvar "terragrunt" <| fromRecord [
          Tfvar "terraform" <| fromRecord [
            Tfvar "source" <| fromString config.source
            ]
          ]
        ) vars

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
      lines = encodeTfvars "  " "" vars
  in
      Task.attempt (\_ -> ()) (File.write (flags.filePath ++ ".tfvars") lines)

isNone : Tfvar -> Bool
isNone (Tfvar fieldName value) =
  case value of
    TfvalNone -> True
    _ -> False

encodeTfvars : String -> String -> Tfvars -> String
encodeTfvars indent actIndent vars =
    String.join "\n" <| List.map (encodeTfvar indent actIndent) <| List.filter (not << isNone) vars
--
encodeTfvar : String -> String -> Tfvar -> String
encodeTfvar indent actIndent (Tfvar fieldName value) =
    actIndent ++ fieldName ++ " = "  ++ (encodeTfval indent actIndent value)

encodeTfval : String -> String -> Tfval -> String
encodeTfval indent actIndent value =
  case value of
    TfvalNone               -> "" -- this shouldn't be reached as it is filtered out in encodeTfvars
    TfvalString stringValue -> "\"" ++ stringValue ++ "\""
    TfvalInt intValue       -> toString intValue
    TfvalList values        ->
        let
          newIndent = actIndent ++ indent
        in
          "[\n"
          ++ (String.join ",\n" <| List.map (\v -> newIndent ++ (encodeTfval indent newIndent v)) values)
          ++ "]\n"
    TfvalRecord vars   -> "{\n"
                          ++ (encodeTfvars indent (indent ++ actIndent) vars) ++ "\n"
                          ++ actIndent ++ "}"
