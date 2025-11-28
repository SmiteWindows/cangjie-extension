/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            01_03_01_a07_10

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

  @Description:     Check positive cases for `DecimalLiteral '_'* IntegerLiteralSuffix?` with the 'i8' suffix.

  @Mode:            run
  @Negative:        no
  @Structure:       single
*/

import utils.assert.Assert

main() {
    var a = 1i8
    a = 2i8
    a = 3i8
    a = 4i8
    a = 5i8
    a = 6i8
    a = 8i8
    a = 9i8
    a = 10i8
    a = 11i8
    a = 12i8
    a = 13i8
    a = 19i8
    a = 1_i8
    a = 100i8
    a = 101i8
    a = 102i8
    a = 109i8
    a = 10_i8
    a = 110i8
    a = 111i8
    a = 119i8
    a = 11_i8
    a = 19_i8
    a = 1_0i8
    a = 1_1i8
    a = 1_2i8
    a = 1_3i8
    a = 1_4i8
    a = 1_5i8
    a = 1_6i8
    a = 1_7i8
    a = 1_8i8
    a = 1_9i8
    a = 1__i8
    a = 0i8

    a = 2_i8
    a = 3_i8
    a = 4_i8
    a = 5_i8
    a = 6_i8
    a = 8_i8
    a = 9_i8
    a = 12_i8
    a = 13_i8
    a = 100_i8
    a = 101_i8
    a = 102_i8
    a = 109_i8
    a = 10__i8
    a = 110_i8
    a = 111_i8
    a = 119_i8
    a = 11__i8
    a = 19__i8
    a = 1_0_i8
    a = 1_1_i8
    a = 1_2_i8
    a = 1_3_i8
    a = 1_4_i8
    a = 1_5_i8
    a = 1_6_i8
    a = 1_7_i8
    a = 1_8_i8
    a = 1_9_i8
    a = 1___i8
    a = 0_i8

    Assert.equals(9, 9i8)
    Assert.equals(1, 1_i8)
    Assert.equals(10, 1_0i8)
    Assert.equals(1, 1__i8)
    Assert.equals(2, 2_i8)
    Assert.equals(101, 101_i8)
    Assert.equals(10, 1_0_i8)
    Assert.equals(0, 0_i8)
}
