module Terraform.AWS exposing (..)

{-| General AWS specific Terraform wrappers.

@docs Region, regionToString
-}

{-| Represents the available regions in AWS.

see https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions
-}
type Region
  =
  US_East_1         -- N virginia
  | US_East_2       -- Ohio
  | US_West_1       -- California
  | US_West_2       -- Oregon
  | CA_Central_1    -- Canada
  | EU_Central_1    -- Frankfurt
  | EU_West_1       -- Ireland
  | EU_West_2       -- London
  | EU_West_3       -- Paris
  | AP_Northeast_1  -- Tokyo
  | AP_Northeast_2  -- Seoul
  | AP_Northeast_3  -- Osaka-Local
  | AP_Southeast_1  -- Singapore
  | AP_Southeast_2  -- Sydney
  | AP_South_1      -- Mumbai
  | SA_East_1       -- Sao Paulo

{-| Converts Region to String, it is used for JSON encoding.
-}
regionToString : Region -> String
regionToString region =
    case region of
  US_East_1 -> "us-east-1"
  US_East_2 -> "us-east-2"
  US_West_1 -> "us-west-1"
  US_West_2 -> "us-west-2"
  CA_Central_1 -> "ca-central-1"
  EU_Central_1 -> "eu-central-1"
  EU_West_1 -> "eu-west-1"
  EU_West_2 -> "eu-west-2"
  EU_West_3 -> "eu-west-3"
  AP_Northeast_1 -> "ap-northeast-1"
  AP_Northeast_2 -> "ap-northeast-2"
  AP_Northeast_3 -> "ap-northeast-3"
  AP_Southeast_1 -> "ap-southeast-1"
  AP_Southeast_2 -> "ap-southeast-2"
  AP_South_1 -> "ap-south-1"
  SA_East_1 -> "sa-east-1"
