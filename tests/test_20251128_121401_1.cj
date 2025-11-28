/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            01_01_a06_18

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

  @Description:     Check that a comment can't be an ordinary identifier. Checking via an interface property name.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single

  @Issue:           0006124
*/

interface A {
    prop /*a*/: Unit
}

main() {}
