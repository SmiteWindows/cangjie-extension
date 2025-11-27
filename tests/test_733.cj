/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a09_053

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
                 (varOrfuncDeclaration) which contains calls of functions of different types: Int64 and Float64.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  
*/

main(){
    let stringValue:String = 
"""
${
func getFloat64(float64Param:Float64):Float64{return float64Param;}; 
func getInt64(int64Param:Int64):Int64{return int64Param;}; 
var int64Var:Int64 = 333222; let float64Var:Float64 = 5.5; 
getInt64(int64Var) + getFloat64(float64Var);
}
""";

    return 0;
}

