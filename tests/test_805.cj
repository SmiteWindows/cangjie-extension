/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a04_099

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
                 which contains calls of functions of different types: String and Bool.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  
*/

func getString(stringParam:String):String
{
    return stringParam;
};

func getBool(boolParam:Bool):Bool
{
    return boolParam;
};

main(){
    let stringVar:String = "string";
    let boolVar:Bool = true;
    let stringValue:String = "${getString(stringVar) + getBool(boolVar);}";
    return 0;
}

