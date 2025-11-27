/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a04_121

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
                 which contains calls of functions of different types: Int8 and UInt8.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  
*/

func getInt8(int8Param:Int8):Int8
{
    return int8Param;
};

func getUInt8(uint8Param:UInt8):UInt8
{
    return uint8Param;
};

main(){
    var int8Var:Int8 = 12;
    let uint8Var:UInt8 = 33; 
    let stringValue:String = "${getInt8(int8Var) - getUInt8(uint8Var)}";
    return 0;
}

