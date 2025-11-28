/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_10_01_a01_12

  @Level:         1

  @Assertion:   2.1.10.1(1) The syntax for the definition of member variables is:
                 variableDeclaration
                  : variableModifier* NL* (LET | VAR) 
                    NL* patternsMaybeIrrefutable ((NL* COLON NL* type)? (NL* ASSIGN NL* expression) 
                  | (NL* COLON NL* type))
                  ;

  @Description: Checks that member variable with type but without initializer causes compilation error.

  @Mode:        compileOnly
  @Negative:    yes
  @Structure:   single
*/

struct MyStruct {
    let v: String;
}

main() {
}


