/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            01_03_01_a07_48

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

  @Description:     Check positive cases for `HexadecimalLiteral IntegerLiteralSuffix?` with the 'u32' suffix.

  @Mode:            run
  @Negative:        no
  @Structure:       single
*/

import utils.assert.Assert

main() {
    var a = 0x0u32
    a = 0x1u32
    a = 0x2u32
    a = 0x3u32
    a = 0x4u32
    a = 0x5u32
    a = 0x6u32
    a = 0x7u32
    a = 0x8u32
    a = 0x9u32
    a = 0xau32
    a = 0xbu32
    a = 0xcu32
    a = 0xdu32
    a = 0xeu32
    a = 0xfu32
    a = 0xAu32
    a = 0xBu32
    a = 0xCu32
    a = 0xDu32
    a = 0xEu32
    a = 0xFu32
    a = 0X0u32
    a = 0X1u32
    a = 0X2u32
    a = 0X3u32
    a = 0X4u32
    a = 0X5u32
    a = 0X6u32
    a = 0X7u32
    a = 0X8u32
    a = 0X9u32
    a = 0Xau32
    a = 0Xbu32
    a = 0Xcu32
    a = 0Xdu32
    a = 0Xeu32
    a = 0Xfu32
    a = 0XAu32
    a = 0XBu32
    a = 0XCu32
    a = 0XDu32
    a = 0XEu32
    a = 0XFu32

    a = 0x00u32
    a = 0xa0u32
    a = 0xA0u32
    a = 0X00u32
    a = 0Xa0u32
    a = 0XF0u32
    a = 0x09u32
    a = 0xa9u32
    a = 0xA9u32
    a = 0X09u32
    a = 0Xa9u32
    a = 0XF9u32
    a = 0x0au32
    a = 0xaau32
    a = 0xAau32
    a = 0X0au32
    a = 0Xaau32
    a = 0XFau32
    a = 0x0fu32
    a = 0xafu32
    a = 0xAfu32
    a = 0X0fu32
    a = 0Xafu32
    a = 0XFfu32
    a = 0x0Au32
    a = 0xaAu32
    a = 0xAAu32
    a = 0X0Au32
    a = 0XaAu32
    a = 0XFAu32
    a = 0x0Fu32
    a = 0xaFu32
    a = 0xAFu32
    a = 0X0Fu32
    a = 0XaFu32
    a = 0XFFu32
    a = 0x0_u32
    a = 0xa_u32
    a = 0xA_u32
    a = 0X0_u32
    a = 0Xa_u32
    a = 0XF_u32

    a = 0x000u32
    a = 0x0009u32
    a = 0x000au32
    a = 0x000fu32
    a = 0x000Au32
    a = 0x000Fu32
    a = 0x000_u32
    a = 0xaA0u32
    a = 0xaA9u32
    a = 0xaAau32
    a = 0xaAfu32
    a = 0xaAAu32
    a = 0xaAFu32
    a = 0xaA_u32
    a = 0XF_0u32
    a = 0XF_9u32
    a = 0Xa_au32
    a = 0xF_fu32
    a = 0xF_Au32
    a = 0Xf_Fu32
    a = 0Xf__u32
    a = 0Xf_F_u32
    a = 0Xf_F_1u32

    Assert.equals(170, 0xaA_u32)
    Assert.equals(0, 0x000_u32)
    Assert.equals(0, 0x000u32)
    Assert.equals(2735, 0xaAFu32)
    Assert.equals(2735, 0XaAFu32)
    Assert.equals(2735, 0Xaafu32)
    Assert.equals(2735, 0xAAFu32)
    Assert.equals(240, 0XF_0u32)
    Assert.equals(250, 0XF_au32)
    Assert.equals(15, 0Xf__u32)
    Assert.equals(255, 0Xf_F_u32)
    Assert.equals(4081, 0Xf_F_1u32)
}
