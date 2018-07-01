module Terraform.AWS.EC2 exposing (..)

{-| AWS EC2 specific Terraform wrappers.

@docs InstanceType, instanceTypeToString
-}

{-| Represents the available types of AWS EC2 instances.

see https://aws.amazon.com/ec2/instance-types/
-}
type InstanceType
  =
  -- General purpose, burstable
   T2_nano
  | T2_micro
  | T2_small
  | T2_medium
  | T2_large
  | T2_xlarge
  | T2_2xlarge
  -- General purpose
  | M5_large
  | M5_xlarge
  | M5_2xlarge
  | M5_4xlarge
  | M5_12xlarge
  | M5_24xlarge
  | M5d_large
  | M5d_xlarge
  | M5d_2xlarge
  | M5d_4xlarge
  | M5d_12xlarge
  | M5d_24xlarge
  -- General purpose, older generation
  | M4_large
  | M4_xlarge
  | M4_2xlarge
  | M4_4xlarge
  | M4_10xlarge
  | M4_16xlarge
  -- Compute optimized
  | C5_large
  | C5_xlarge
  | C5_2xlarge
  | C5_4xlarge
  | C5_9xlarge
  | C5_18xlarge
  | C5d_large
  | C5d_xlarge
  | C5d_2xlarge
  | C5d_4xlarge
  | C5d_9xlarge
  | C5d_18xlarge
  -- Compute optimized, lower price
  | C4_large
  | C4_xlarge
  | C4_2xlarge
  | C4_4xlarge
  | C4_8xlarge
  -- Memory optimized
  | X1e_xlarge
  | X1e_2xlarge
  | X1e_4xlarge
  | X1e_8xlarge
  | X1e_16xlarge
  | X1e_32xlarge
  -- Memory optimized, lower price
  | X1_16xlarge
  | X1_32xlarge
  -- Memory optimized, extra 5%
  | R5_large
  | R5_xlarge
  | R5_2xlarge
  | R5_4xlarge
  | R5_12xlarge
  | R5_24xlarge
  | R5d_large
  | R5d_xlarge
  | R5d_2xlarge
  | R5d_4xlarge
  | R5d_12xlarge
  | R5d_24xlarge
  -- Memory optimized, better price than R3
  | R4_large
  | R4_xlarge
  | R4_2xlarge
  | R4_4xlarge
  | R4_8xlarge
  | R4_16xlarge
  -- Memory optimized, the fastest
  | Z1d_large
  | Z1d_xlarge
  | Z1d_2xlarge
  | Z1d_3xlarge
  | Z1d_6xlarge
  | Z1d_12xlarge
  -- Accelerated Computing
  | P3_2xlarge
  | P3_8xlarge
  | P3_16xlarge
  -- Accelerated Computing, older generation
  | P2_xlarge
  | P2_8xlarge
  | P2_16xlarge
  -- Accelerated Computing, graphics optimized
  | G3_4xlarge
  | G3_8xlarge
  | G3_16xlarge
  -- Accelerated Computing, hardware acceleration with FPGAs
  | F1_2xlarge
  | F1_16xlarge
  -- Storage optimized, HDD-based
  | H1_2xlarge
  | H1_4xlarge
  | H1_8xlarge
  | H1_16xlarge
  -- Storage optimized, SSD-based
  | I3_large
  | I3_2xlarge
  | I3_4xlarge
  | I3_8xlarge
  | I3_16xlarge
  | I3_metal
  -- Storage optimized, HDD-based, for MapReduce, Hadoop, Date warehouses
  | D2_xlarge
  | D2_2xlarge
  | D2_4xlarge
  | D2_8xlarge
  -- Deprecated Ones
  -- Deprecated ones
  | T1_micro
  | C1_medium
  | C1_xlarge
  | C3_2xlarge
  | C3_4xlarge
  | C3_8xlarge
  | C3_large
  | C3_xlarge
  | Cc2_8xlarge
  | Cr1_8xlarge
  | G2_2xlarge
  | G2_8xlarge
  | Hs1_8xlarge
  | I2_2xlarge
  | I2_4xlarge
  | I2_8xlarge
  | I2_xlarge
  | I3_xlarge
  | M1_large
  | M1_medium
  | M1_small
  | M1_xlarge
  | M2_2xlarge
  | M2_4xlarge
  | M2_xlarge
  | M3_2xlarge
  | M3_large
  | M3_medium
  | M3_xlarge
  | R3_2xlarge
  | R3_4xlarge
  | R3_8xlarge
  | R3_large
  | R3_xlarge


{-| Converts InstanceTypes to String, it is used for JSON encoding.
-}
instanceTypeToString : InstanceType -> String
instanceTypeToString instanceType =
    case instanceType of
    C1_medium -> "c1.medium"
    C1_xlarge -> "c1.xlarge"
    C3_2xlarge -> "c3.2xlarge"
    C3_4xlarge -> "c3.4xlarge"
    C3_8xlarge -> "c3.8xlarge"
    C3_large -> "c3.large"
    C3_xlarge -> "c3.xlarge"
    C4_2xlarge -> "c4.2xlarge"
    C4_4xlarge -> "c4.4xlarge"
    C4_8xlarge -> "c4.8xlarge"
    C4_large -> "c4.large"
    C4_xlarge -> "c4.xlarge"
    C5_18xlarge -> "c5.18xlarge"
    C5_2xlarge -> "c5.2xlarge"
    C5_4xlarge -> "c5.4xlarge"
    C5_9xlarge -> "c5.9xlarge"
    C5_large -> "c5.large"
    C5_xlarge -> "c5.xlarge"
    C5d_18xlarge -> "c5d.18xlarge"
    C5d_2xlarge -> "c5d.2xlarge"
    C5d_4xlarge -> "c5d.4xlarge"
    C5d_9xlarge -> "c5d.9xlarge"
    C5d_large -> "c5d.large"
    C5d_xlarge -> "c5d.xlarge"
    Cc2_8xlarge -> "cc2.8xlarge"
    Cr1_8xlarge -> "cr1.8xlarge"
    D2_2xlarge -> "d2.2xlarge"
    D2_4xlarge -> "d2.4xlarge"
    D2_8xlarge -> "d2.8xlarge"
    D2_xlarge -> "d2.xlarge"
    F1_16xlarge -> "f1.16xlarge"
    F1_2xlarge -> "f1.2xlarge"
    G2_2xlarge -> "g2.2xlarge"
    G2_8xlarge -> "g2.8xlarge"
    G3_16xlarge -> "g3.16xlarge"
    G3_4xlarge -> "g3.4xlarge"
    G3_8xlarge -> "g3.8xlarge"
    H1_16xlarge -> "h1.16xlarge"
    H1_2xlarge -> "h1.2xlarge"
    H1_4xlarge -> "h1.4xlarge"
    H1_8xlarge -> "h1.8xlarge"
    Hs1_8xlarge -> "hs1.8xlarge"
    I2_2xlarge -> "i2.2xlarge"
    I2_4xlarge -> "i2.4xlarge"
    I2_8xlarge -> "i2.8xlarge"
    I2_xlarge -> "i2.xlarge"
    I3_16xlarge -> "i3.16xlarge"
    I3_2xlarge -> "i3.2xlarge"
    I3_4xlarge -> "i3.4xlarge"
    I3_8xlarge -> "i3.8xlarge"
    I3_large -> "i3.large"
    I3_metal -> "i3.metal"
    I3_xlarge -> "i3.xlarge"
    M1_large -> "m1.large"
    M1_medium -> "m1.medium"
    M1_small -> "m1.small"
    M1_xlarge -> "m1.xlarge"
    M2_2xlarge -> "m2.2xlarge"
    M2_4xlarge -> "m2.4xlarge"
    M2_xlarge -> "m2.xlarge"
    M3_2xlarge -> "m3.2xlarge"
    M3_large -> "m3.large"
    M3_medium -> "m3.medium"
    M3_xlarge -> "m3.xlarge"
    M4_10xlarge -> "m4.10xlarge"
    M4_16xlarge -> "m4.16xlarge"
    M4_2xlarge -> "m4.2xlarge"
    M4_4xlarge -> "m4.4xlarge"
    M4_large -> "m4.large"
    M4_xlarge -> "m4.xlarge"
    M5_12xlarge -> "m5.12xlarge"
    M5_24xlarge -> "m5.24xlarge"
    M5_2xlarge -> "m5.2xlarge"
    M5_4xlarge -> "m5.4xlarge"
    M5_large -> "m5.large"
    M5_xlarge -> "m5.xlarge"
    M5d_12xlarge -> "m5d.12xlarge"
    M5d_24xlarge -> "m5d.24xlarge"
    M5d_2xlarge -> "m5d.2xlarge"
    M5d_4xlarge -> "m5d.4xlarge"
    M5d_large -> "m5d.large"
    M5d_xlarge -> "m5d.xlarge"
    P2_16xlarge -> "p2.16xlarge"
    P2_8xlarge -> "p2.8xlarge"
    P2_xlarge -> "p2.xlarge"
    P3_16xlarge -> "p3.16xlarge"
    P3_2xlarge -> "p3.2xlarge"
    P3_8xlarge -> "p3.8xlarge"
    R3_2xlarge -> "r3.2xlarge"
    R3_4xlarge -> "r3.4xlarge"
    R3_8xlarge -> "r3.8xlarge"
    R3_large -> "r3.large"
    R3_xlarge -> "r3.xlarge"
    R4_16xlarge -> "r4.16xlarge"
    R4_2xlarge -> "r4.2xlarge"
    R4_4xlarge -> "r4.4xlarge"
    R4_8xlarge -> "r4.8xlarge"
    R4_large -> "r4.large"
    R4_xlarge -> "r4.xlarge"
    R5_12xlarge -> "r5.12xlarge"
    R5_24xlarge -> "r5.24xlarge"
    R5_2xlarge -> "r5.2xlarge"
    R5_4xlarge -> "r5.4xlarge"
    R5_large -> "r5.large"
    R5_xlarge -> "r5.xlarge"
    R5d_12xlarge -> "r5d.12xlarge"
    R5d_24xlarge -> "r5d.24xlarge"
    R5d_2xlarge -> "r5d.2xlarge"
    R5d_4xlarge -> "r5d.4xlarge"
    R5d_large -> "r5d.large"
    R5d_xlarge -> "r5d.xlarge"
    T1_micro -> "t1.micro"
    T2_2xlarge -> "t2.2xlarge"
    T2_large -> "t2.large"
    T2_medium -> "t2.medium"
    T2_micro -> "t2.micro"
    T2_nano -> "t2.nano"
    T2_small -> "t2.small"
    T2_xlarge -> "t2.xlarge"
    X1_16xlarge -> "x1.16xlarge"
    X1_32xlarge -> "x1.32xlarge"
    X1e_16xlarge -> "x1e.16xlarge"
    X1e_2xlarge -> "x1e.2xlarge"
    X1e_32xlarge -> "x1e.32xlarge"
    X1e_4xlarge -> "x1e.4xlarge"
    X1e_8xlarge -> "x1e.8xlarge"
    X1e_xlarge -> "x1e.xlarge"
    Z1d_12xlarge -> "z1d.12xlarge"
    Z1d_2xlarge -> "z1d.2xlarge"
    Z1d_3xlarge -> "z1d.3xlarge"
    Z1d_6xlarge -> "z1d.6xlarge"
    Z1d_large -> "z1d.large"
    Z1d_xlarge -> "z1d.xlarge"
