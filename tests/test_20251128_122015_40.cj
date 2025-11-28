/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            01_03_01_a07_15

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

  @Description:     Check positive cases for `DecimalLiteral '_'* IntegerLiteralSuffix?` with the 'u16' suffix.

  @Mode:            run
  @Negative:        no
  @Structure:       single
*/

import utils.assert.Assert

main() {
    var a = 1u16
    a = 2u16
    a = 3u16
    a = 4u16
    a = 5u16
    a = 6u16
    a = 8u16
    a = 9u16
    a = 10u16
    a = 11u16
    a = 12u16
    a = 13u16
    a = 19u16
    a = 1_u16
    a = 100u16
    a = 101u16
    a = 102u16
    a = 109u16
    a = 10_u16
    a = 110u16
    a = 111u16
    a = 119u16
    a = 11_u16
    a = 190u16
    a = 199u16
    a = 19_u16
    a = 1_0u16
    a = 1_1u16
    a = 1_2u16
    a = 1_3u16
    a = 1_4u16
    a = 1_5u16
    a = 1_6u16
    a = 1_7u16
    a = 1_8u16
    a = 1_9u16
    a = 1__u16
    a = 0u16

    a = 2_u16
    a = 3_u16
    a = 4_u16
    a = 5_u16
    a = 6_u16
    a = 8_u16
    a = 9_u16
    a = 12_u16
    a = 13_u16
    a = 100_u16
    a = 101_u16
    a = 102_u16
    a = 109_u16
    a = 10__u16
    a = 110_u16
    a = 111_u16
    a = 119_u16
    a = 11__u16
    a = 190_u16
    a = 199_u16
    a = 19__u16
    a = 1_0_u16
    a = 1_1_u16
    a = 1_2_u16
    a = 1_3_u16
    a = 1_4_u16
    a = 1_5_u16
    a = 1_6_u16
    a = 1_7_u16
    a = 1_8_u16
    a = 1_9_u16
    a = 1___u16
    a = 0_u16

    Assert.equals(9, 9u16)
    Assert.equals(1, 1_u16)
    Assert.equals(10, 1_0u16)
    Assert.equals(1, 1__u16)
    Assert.equals(2, 2_u16)
    Assert.equals(101, 101_u16)
    Assert.equals(10, 1_0_u16)
    Assert.equals(0, 0_u16)
}
