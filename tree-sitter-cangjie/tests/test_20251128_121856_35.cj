/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
   @Name:        02_01_07_01_a01_04

  @Level:         1
   @Assertion:   2.1.7.1(1) The Tuple literal has the format (expr1, expr2, ..., exprN), 
                 in which multiple expressions are separated by commas and each expression 
                 can have a different types. The syntax of Tuple literal is defined as:
                 tupleLiteral
                    : '(' expression (',' expression)+ ')'

   @Description: A tuple without a right parenthese ')' should produce a compiler error.
   @Mode:        compileOnly
   @Negative:    yes
   @Structure:   single
 */

main() {
    (123, true
    return 0
}
