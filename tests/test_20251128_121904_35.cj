/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a09_046

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

  @Description:  Checks that multi-line string literal cannot be represented as multiLineStringExpression
                 (varOrfuncDeclaration) which contains calls of functions of different types: Rune and UInt32.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  
*/


main(){
    let stringValue:String = 
"""
${
func getChar(charParam:Rune):Rune{return charParam;}; 
func getUInt32(uint32Param:UInt32):UInt32{return uint32Param;}; 
var charVar:Rune = '2'; 
let uint32Var:UInt32 = 3; 
getChar(charVar) + getUInt32(uint32Var)}
""";

    return 0;
}

