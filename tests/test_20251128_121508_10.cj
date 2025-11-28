/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            01_03_01_a07_09

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

  @Description:     Check positive cases for `DecimalLiteral '_'* IntegerLiteralSuffix?` without suffixes.

  @Mode:            run
  @Negative:        no
  @Structure:       single
*/

import utils.assert.Assert

main() {
    var a = 1
    a = 2
    a = 3
    a = 4
    a = 5
    a = 6
    a = 8
    a = 9
    a = 10
    a = 11
    a = 12
    a = 13
    a = 19
    a = 1_
    a = 100
    a = 101
    a = 102
    a = 109
    a = 10_
    a = 110
    a = 111
    a = 119
    a = 11_
    a = 190
    a = 199
    a = 19_
    a = 1_0
    a = 1_1
    a = 1_2
    a = 1_3
    a = 1_4
    a = 1_5
    a = 1_6
    a = 1_7
    a = 1_8
    a = 1_9
    a = 1__
    a = 0

    a = 2_
    a = 3_
    a = 4_
    a = 5_
    a = 6_
    a = 8_
    a = 9_
    a = 12_
    a = 13_
    a = 100_
    a = 101_
    a = 102_
    a = 109_
    a = 10__
    a = 110_
    a = 111_
    a = 119_
    a = 11__
    a = 190_
    a = 199_
    a = 19__
    a = 1_0_
    a = 1_1_
    a = 1_2_
    a = 1_3_
    a = 1_4_
    a = 1_5_
    a = 1_6_
    a = 1_7_
    a = 1_8_
    a = 1_9_
    a = 1___
    a = 0_

    Assert.equals(1, 1_)
    Assert.equals(10, 1_0)
    Assert.equals(1, 1__)
    Assert.equals(2, 2_)
    Assert.equals(101, 101_)
    Assert.equals(10, 1_0_)
    Assert.equals(0, 0_)
}
