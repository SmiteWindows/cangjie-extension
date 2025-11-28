/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            01_01_a06_23

  @Level:         1

  @Assertion:       1.1(6) The syntax of Identifier is defined as:
                       identifier
                           : Identifier
                           | PUBLIC
                           | PRIVATE
                           | PROTECTED
                           | OVERRIDE
                           | ABSTRACT
                      | SEALED
                           | OPEN
                           | REDEF
                           | GET
                           | SET
                           ;
                       Identifier
                           : '_'* Letter (Letter | '_' | DecimalDigit)*
                           | '`' '_'* Letter (Letter | '_' | DecimalDigit)* '`'
                           ;
                       Letter
                           : [a-zA-Z]
                           ;
                       DecimalDigit
                           : [0-9]
                           ;

  @Description:     Check that a type alias can't be an ordinary identifier. Checking via a for-in expression.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
*/

main() {
    for (type A=Int64 in [0]) {}
}
