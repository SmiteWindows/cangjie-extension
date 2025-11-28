/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            01_03_01_a07_68

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

  @Description:     Check that a HexadecimalDigit can't contain "-".

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
*/

main() {
    let a: Int8 = 0-x1
}
