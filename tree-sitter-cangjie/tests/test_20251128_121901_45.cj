/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            01_03_01_a07_12

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

  @Description:     Check positive cases for `DecimalLiteral '_'* IntegerLiteralSuffix?` with the 'i32' suffix.

  @Mode:            run
  @Negative:        no
  @Structure:       single
*/

import utils.assert.Assert

main() {
    var a = 1i32
    a = 2i32
    a = 3i32
    a = 4i32
    a = 5i32
    a = 6i32
    a = 8i32
    a = 9i32
    a = 10i32
    a = 11i32
    a = 12i32
    a = 13i32
    a = 19i32
    a = 1_i32
    a = 100i32
    a = 101i32
    a = 102i32
    a = 109i32
    a = 10_i32
    a = 110i32
    a = 111i32
    a = 119i32
    a = 11_i32
    a = 190i32
    a = 199i32
    a = 19_i32
    a = 1_0i32
    a = 1_1i32
    a = 1_2i32
    a = 1_3i32
    a = 1_4i32
    a = 1_5i32
    a = 1_6i32
    a = 1_7i32
    a = 1_8i32
    a = 1_9i32
    a = 1__i32
    a = 0i32

    a = 2_i32
    a = 3_i32
    a = 4_i32
    a = 5_i32
    a = 6_i32
    a = 8_i32
    a = 9_i32
    a = 12_i32
    a = 13_i32
    a = 100_i32
    a = 101_i32
    a = 102_i32
    a = 109_i32
    a = 10__i32
    a = 110_i32
    a = 111_i32
    a = 119_i32
    a = 11__i32
    a = 190_i32
    a = 199_i32
    a = 19__i32
    a = 1_0_i32
    a = 1_1_i32
    a = 1_2_i32
    a = 1_3_i32
    a = 1_4_i32
    a = 1_5_i32
    a = 1_6_i32
    a = 1_7_i32
    a = 1_8_i32
    a = 1_9_i32
    a = 1___i32
    a = 0_i32

    Assert.equals(9, 9i32)
    Assert.equals(1, 1_i32)
    Assert.equals(10, 1_0i32)
    Assert.equals(1, 1__i32)
    Assert.equals(2, 2_i32)
    Assert.equals(101, 101_i32)
    Assert.equals(10, 1_0_i32)
    Assert.equals(0, 0_i32)
}
