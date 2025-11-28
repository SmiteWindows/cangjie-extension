/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            01_03_01_a07_14

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

  @Description:     Check positive cases for `DecimalLiteral '_'* IntegerLiteralSuffix?` with the 'u8' suffix.

  @Mode:            run
  @Negative:        no
  @Structure:       single
*/

import utils.assert.Assert

main() {
    var a = 1u8
    a = 2u8
    a = 3u8
    a = 4u8
    a = 5u8
    a = 6u8
    a = 8u8
    a = 9u8
    a = 10u8
    a = 11u8
    a = 12u8
    a = 13u8
    a = 19u8
    a = 1_u8
    a = 100u8
    a = 101u8
    a = 102u8
    a = 109u8
    a = 10_u8
    a = 110u8
    a = 111u8
    a = 119u8
    a = 11_u8
    a = 190u8
    a = 199u8
    a = 19_u8
    a = 1_0u8
    a = 1_1u8
    a = 1_2u8
    a = 1_3u8
    a = 1_4u8
    a = 1_5u8
    a = 1_6u8
    a = 1_7u8
    a = 1_8u8
    a = 1_9u8
    a = 1__u8
    a = 0u8

    a = 2_u8
    a = 3_u8
    a = 4_u8
    a = 5_u8
    a = 6_u8
    a = 8_u8
    a = 9_u8
    a = 12_u8
    a = 13_u8
    a = 100_u8
    a = 101_u8
    a = 102_u8
    a = 109_u8
    a = 10__u8
    a = 110_u8
    a = 111_u8
    a = 119_u8
    a = 11__u8
    a = 190_u8
    a = 199_u8
    a = 19__u8
    a = 1_0_u8
    a = 1_1_u8
    a = 1_2_u8
    a = 1_3_u8
    a = 1_4_u8
    a = 1_5_u8
    a = 1_6_u8
    a = 1_7_u8
    a = 1_8_u8
    a = 1_9_u8
    a = 1___u8
    a = 0_u8

    Assert.equals(9, 9u8)
    Assert.equals(1, 1_u8)
    Assert.equals(10, 1_0u8)
    Assert.equals(1, 1__u8)
    Assert.equals(2, 2_u8)
    Assert.equals(101, 101_u8)
    Assert.equals(10, 1_0_u8)
    Assert.equals(0, 0_u8)
}
