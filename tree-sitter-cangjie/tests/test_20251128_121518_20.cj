/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a09_010

  @Level:         1

  @Assertion:   1.3.6(9) The syntax of the multi-line string literal is:
                   multiLineStringLiteral
                       : '"""' NL (multiLineStringExpression | multiLineStringContent)* '"""'
                       ;
                   multiLineStringExpression
                       : '${' end* (expressionOrDeclaration (end+ expressionOrDeclaration?)*) end* '}'
                       ;
                   multiLineStringContent
                       : MultiLineStrText
                       ;
                   MultiLineStrText
                       : ~('\\')
                       | EscapeSeq ;

  @Description:  Checks that multi-line string literal can be represented with correct UniCharacterLiteral;

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  
*/

import utils.assert.*

main(){
    let stringValue_01:String = """
UniCharacterLiteral with 5 HexadecimalDigits: |\u{00061}|
""";
    let checkingString_01:String = "UniCharacterLiteral with 5 HexadecimalDigits: |\u{00061}|\n";
    Assert.equals(checkingString_01, stringValue_01, 
        reason:"The multi-line string literal with UniCharacterLiteral has incorrect value (" + stringValue_01 +")");

    let stringValue_02:String = """
UniCharacterLiteral with 6 HexadecimalDigits: |\u{00004D}|
""";
    let checkingString_02:String = "UniCharacterLiteral with 6 HexadecimalDigits: |\u{00004D}|\n";
    Assert.equals(checkingString_02, stringValue_02, 
        reason:"The multi-line string literal with UniCharacterLiteral has incorrect value (" + stringValue_02 +")");

    let stringValue_03:String = """
UniCharacterLiteral with 7 HexadecimalDigits: |\u{000005A}|
""";
    let checkingString_03:String = "UniCharacterLiteral with 7 HexadecimalDigits: |\u{000005a}|\n";
    Assert.equals(checkingString_03, stringValue_03, 
        reason:"The multi-line string literal with UniCharacterLiteral has incorrect value (" + stringValue_03 +")");

    let stringValue_04:String = """
UniCharacterLiteral with 8 HexadecimalDigits: |\u{0000005a}|
""";
    let checkingString_04:String = "UniCharacterLiteral with 8 HexadecimalDigits: |\u{5A}|\n";
    Assert.equals(checkingString_04, stringValue_04, 
        reason:"The multi-line string literal with UniCharacterLiteral has incorrect value (" + stringValue_04 +")");

    return 0;
}

