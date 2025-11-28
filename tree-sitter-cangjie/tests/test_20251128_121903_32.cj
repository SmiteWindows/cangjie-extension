/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            01_03_01_a07_49

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

  @Description:     Check positive cases for `HexadecimalLiteral IntegerLiteralSuffix?` with the 'u64' suffix.

  @Mode:            run
  @Negative:        no
  @Structure:       single
*/

import utils.assert.Assert

main() {
    var a = 0x0u64
    a = 0x1u64
    a = 0x2u64
    a = 0x3u64
    a = 0x4u64
    a = 0x5u64
    a = 0x6u64
    a = 0x7u64
    a = 0x8u64
    a = 0x9u64
    a = 0xau64
    a = 0xbu64
    a = 0xcu64
    a = 0xdu64
    a = 0xeu64
    a = 0xfu64
    a = 0xAu64
    a = 0xBu64
    a = 0xCu64
    a = 0xDu64
    a = 0xEu64
    a = 0xFu64
    a = 0X0u64
    a = 0X1u64
    a = 0X2u64
    a = 0X3u64
    a = 0X4u64
    a = 0X5u64
    a = 0X6u64
    a = 0X7u64
    a = 0X8u64
    a = 0X9u64
    a = 0Xau64
    a = 0Xbu64
    a = 0Xcu64
    a = 0Xdu64
    a = 0Xeu64
    a = 0Xfu64
    a = 0XAu64
    a = 0XBu64
    a = 0XCu64
    a = 0XDu64
    a = 0XEu64
    a = 0XFu64

    a = 0x00u64
    a = 0xa0u64
    a = 0xA0u64
    a = 0X00u64
    a = 0Xa0u64
    a = 0XF0u64
    a = 0x09u64
    a = 0xa9u64
    a = 0xA9u64
    a = 0X09u64
    a = 0Xa9u64
    a = 0XF9u64
    a = 0x0au64
    a = 0xaau64
    a = 0xAau64
    a = 0X0au64
    a = 0Xaau64
    a = 0XFau64
    a = 0x0fu64
    a = 0xafu64
    a = 0xAfu64
    a = 0X0fu64
    a = 0Xafu64
    a = 0XFfu64
    a = 0x0Au64
    a = 0xaAu64
    a = 0xAAu64
    a = 0X0Au64
    a = 0XaAu64
    a = 0XFAu64
    a = 0x0Fu64
    a = 0xaFu64
    a = 0xAFu64
    a = 0X0Fu64
    a = 0XaFu64
    a = 0XFFu64
    a = 0x0_u64
    a = 0xa_u64
    a = 0xA_u64
    a = 0X0_u64
    a = 0Xa_u64
    a = 0XF_u64

    a = 0x000u64
    a = 0x0009u64
    a = 0x000au64
    a = 0x000fu64
    a = 0x000Au64
    a = 0x000Fu64
    a = 0x000_u64
    a = 0xaA0u64
    a = 0xaA9u64
    a = 0xaAau64
    a = 0xaAfu64
    a = 0xaAAu64
    a = 0xaAFu64
    a = 0xaA_u64
    a = 0XF_0u64
    a = 0XF_9u64
    a = 0Xa_au64
    a = 0xF_fu64
    a = 0xF_Au64
    a = 0Xf_Fu64
    a = 0Xf__u64
    a = 0Xf_F_u64
    a = 0Xf_F_1u64

    Assert.equals(170, 0xaA_u64)
    Assert.equals(0, 0x000_u64)
    Assert.equals(0, 0x000u64)
    Assert.equals(2735, 0xaAFu64)
    Assert.equals(2735, 0XaAFu64)
    Assert.equals(2735, 0Xaafu64)
    Assert.equals(2735, 0xAAFu64)
    Assert.equals(240, 0XF_0u64)
    Assert.equals(250, 0XF_au64)
    Assert.equals(15, 0Xf__u64)
    Assert.equals(255, 0Xf_F_u64)
    Assert.equals(4081, 0Xf_F_1u64)
}
