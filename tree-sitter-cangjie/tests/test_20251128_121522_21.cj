/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_09_a02_05

  @Level:         1

  @Assertion:   2.1.9(2) The syntax of function type is:
                 arrowType
                  : parameterTypes '->' type
                  ;
                 parameterTypes
                  : '(' (type (',' type)*)? ')'
                  ;

  @Description: Checks that function type, declared with syntax violation above
                (no ')') causes compilation error;

  @Mode:        compileonly
  @Negative:    yes
  @Structure:   single
*/

type funcType = (Float16, Bool -> String;

main() {
    return 0;
}

