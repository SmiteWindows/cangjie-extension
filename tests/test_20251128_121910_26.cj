/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a04_103

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
                 which contains calls of functions of different types: String and Int64.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  
*/

func getString(stringParam:String):String
{
    return stringParam;
};

func getInt64(int64Param:Int64):Int64
{
    return int64Param;
};

main(){
    let stringVar:String = "string";
    let uint64Var:UInt64 = 10; 
    let stringValue:String = "${getString(stringVar) + getUIint64(uint64Var);}";
    return 0;
}

