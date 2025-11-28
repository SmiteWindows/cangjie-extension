/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a09_042

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
                 (varOrfuncDeclaration) which contains calls of functions of different types: String and UInt16.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  
*/

main(){
    let stringValue:String = 
"""
${
let stringVar:String = "string"; 
func getString(stringParam:String):String{return stringParam;}; 
func getUInt16(uint16Param:UInt16):UInt16{return uint16Param;}; 
let uint16Var:UInt16 = 3; 
getString(stringVar) + getUInt16(uint16Var);
}""";

    return 0;
}

