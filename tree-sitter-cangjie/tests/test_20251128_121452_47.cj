/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            01_03_01_a07_11

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

  @Description:     Check positive cases for `DecimalLiteral '_'* IntegerLiteralSuffix?` with the 'i16' suffix.

  @Mode:            run
  @Negative:        no
  @Structure:       single
*/

import utils.assert.Assert

main() {
    var a = 1i16
    a = 2i16
    a = 3i16
    a = 4i16
    a = 5i16
    a = 6i16
    a = 8i16
    a = 9i16
    a = 10i16
    a = 11i16
    a = 12i16
    a = 13i16
    a = 19i16
    a = 1_i16
    a = 100i16
    a = 101i16
    a = 102i16
    a = 109i16
    a = 10_i16
    a = 110i16
    a = 111i16
    a = 119i16
    a = 11_i16
    a = 190i16
    a = 199i16
    a = 19_i16
    a = 1_0i16
    a = 1_1i16
    a = 1_2i16
    a = 1_3i16
    a = 1_4i16
    a = 1_5i16
    a = 1_6i16
    a = 1_7i16
    a = 1_8i16
    a = 1_9i16
    a = 1__i16
    a = 0i16

    a = 2_i16
    a = 3_i16
    a = 4_i16
    a = 5_i16
    a = 6_i16
    a = 8_i16
    a = 9_i16
    a = 12_i16
    a = 13_i16
    a = 100_i16
    a = 101_i16
    a = 102_i16
    a = 109_i16
    a = 10__i16
    a = 110_i16
    a = 111_i16
    a = 119_i16
    a = 11__i16
    a = 190_i16
    a = 199_i16
    a = 19__i16
    a = 1_0_i16
    a = 1_1_i16
    a = 1_2_i16
    a = 1_3_i16
    a = 1_4_i16
    a = 1_5_i16
    a = 1_6_i16
    a = 1_7_i16
    a = 1_8_i16
    a = 1_9_i16
    a = 1___i16
    a = 0_i16

    Assert.equals(9, 9i16)
    Assert.equals(1, 1_i16)
    Assert.equals(10, 1_0i16)
    Assert.equals(1, 1__i16)
    Assert.equals(2, 2_i16)
    Assert.equals(101, 101_i16)
    Assert.equals(10, 1_0_i16)
    Assert.equals(0, 0_i16)
}
