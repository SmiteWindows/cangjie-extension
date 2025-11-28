/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a09_033

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
                 (varOrfuncDeclaration) which contains items of different types: Int64 and UInt64.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  
*/

main(){
    let stringValue:String = """
${let int64Var:Int64 = 222; let uint64Var:UInt64 = 5; int64Var + uint64Var}""";
    return 0;
}

