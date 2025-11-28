/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a04_104

  @Level:         1

  @Assertion:   1.3.6(4) The syntax of the single-line string literal is:
                    lineStringLiteral
                        : '"' (lineStringExpression | lineStringContent)* '"'
                        ;
                    lineStringExpression
                        : '${' SEMI* (expressionOrDeclaration (SEMI+ expressionOrDeclaration?)*) SEMI* '}'
                        ;
                    lineStringContent
                        : LineStrText
                        ;
                    LineStrText
                        : ~["\\\r\n]
                        | EscapeSeq ;

  @Description:  Checks that single-line string literal cannot be represented as lineStringExpression
                 (varOrfuncDeclaration) which contains calls of functions of different types: String and UInt64.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  
*/

func getStr(stringParam:String):String
{
    return stringParam;
};

main(){
    let stringValue:String =
        "${func getU64(p:UInt64) {return p;}; getStr("string") + getU64(3);}";
    return 0;
}

