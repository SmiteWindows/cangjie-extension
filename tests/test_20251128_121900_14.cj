/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_04_a03_neg_1

  @Level:         1

  @Assertion:      1.3.4(3) The syntax is:
                   CharacterByteLiteral
                     : 'b' '\'' (SingleCharByte | ByteEscapeSeq) '\''
                     ;
                   ByteEscapeSeq
                     : HexCharByte
                     | ByteEscapedIdentifier
                     ;
                   fragment SingleCharByte
                     : [\u0000-\u0009\u000B\u000C\u000E-\u0021\u0023-\u0026\u0028-\u005B\u005D-\u007F] ;
                   fragment ByteEscapedIdentifier
                     : '\\' ('t' | 'b' | 'r' | 'n' | '\'' | '"' | '\\' | 'f' | 'v' | '0')
                     ;
                   fragment HexCharByte
                     : '\\' 'u' '{' HexadecimalDigit '}'
                     | '\\' 'u' '{' HexadecimalDigit HexadecimalDigit '}'
                     ;

  @Description:  Too long byte literal

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/

main() {
    b'\u{fff0ffff}' 
    return 0
}

