/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            01_03_01_a07_16

  @Level:         1

  @Assertion:       1.3.1(7) The syntax of integer literals is:
                       IntegerLiteralSuffix
                          : 'i8' |'i16' |'i32' |'i64' |'u8' |'u16' |'u32' | 'u64'
                          ;
                       IntegerLiteral
                          : BinaryLiteral IntegerLiteralSuffix?
                          | OctalLiteral IntegerLiteralSuffix?
                          | DecimalLiteral '_'* IntegerLiteralSuffix?
                          | HexadecimalLiteral IntegerLiteralSuffix?
                          ;
                       BinaryLiteral
                           : '0' [bB] BinDigit (BinDigit | '_')*
                           ;
                       BinDigit
                           : [01]
                           ;
                       OctalLiteral
                           : '0' [oO] OctalDigit (OctalDigit | '_')*
                           ;
                       OctalDigit
                           : [0-7]
                           ;
                       DecimalLiteral
                           ([1-9] (DecimalDigit | '_')*) | DecimalDigit
                           ;
                       DecimalDigit
                           : [0-9]
                           ;
                       HexadecimalLiteral
                           : '0' [xX] HexadecimalDigits
                           ;
                       HexadecimalDigits
                           : HexadecimalDigit (HexadecimalDigit | '_')*
                           ;
                       HexadecimalDigit
                           : [0-9a-fA-F]
                           ;

  @Description:     Check positive cases for `DecimalLiteral '_'* IntegerLiteralSuffix?` with the 'u32' suffix.

  @Mode:            run
  @Negative:        no
  @Structure:       single
*/

import utils.assert.Assert

main() {
    var a = 1u32
    a = 2u32
    a = 3u32
    a = 4u32
    a = 5u32
    a = 6u32
    a = 8u32
    a = 9u32
    a = 10u32
    a = 11u32
    a = 12u32
    a = 13u32
    a = 19u32
    a = 1_u32
    a = 100u32
    a = 101u32
    a = 102u32
    a = 109u32
    a = 10_u32
    a = 110u32
    a = 111u32
    a = 119u32
    a = 11_u32
    a = 190u32
    a = 199u32
    a = 19_u32
    a = 1_0u32
    a = 1_1u32
    a = 1_2u32
    a = 1_3u32
    a = 1_4u32
    a = 1_5u32
    a = 1_6u32
    a = 1_7u32
    a = 1_8u32
    a = 1_9u32
    a = 1__u32
    a = 0u32

    a = 2_u32
    a = 3_u32
    a = 4_u32
    a = 5_u32
    a = 6_u32
    a = 8_u32
    a = 9_u32
    a = 12_u32
    a = 13_u32
    a = 100_u32
    a = 101_u32
    a = 102_u32
    a = 109_u32
    a = 10__u32
    a = 110_u32
    a = 111_u32
    a = 119_u32
    a = 11__u32
    a = 190_u32
    a = 199_u32
    a = 19__u32
    a = 1_0_u32
    a = 1_1_u32
    a = 1_2_u32
    a = 1_3_u32
    a = 1_4_u32
    a = 1_5_u32
    a = 1_6_u32
    a = 1_7_u32
    a = 1_8_u32
    a = 1_9_u32
    a = 1___u32
    a = 0_u32

    Assert.equals(9, 9u32)
    Assert.equals(1, 1_u32)
    Assert.equals(10, 1_0u32)
    Assert.equals(1, 1__u32)
    Assert.equals(2, 2_u32)
    Assert.equals(101, 101_u32)
    Assert.equals(10, 1_0_u32)
    Assert.equals(0, 0_u32)
}
