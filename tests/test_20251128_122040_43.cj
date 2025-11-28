/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_09_a04_02

  @Level:         1

  @Assertion:   2.1.9(4) The () outside of the parameter type list is mandatory, in which zero or 
                  multiple types can be included (multiple types are separated by ,).

  @Description: Checks that function type, declared without the () outside of the parameter 
                type list causes compilation error;

  @Mode:        compileonly
  @Negative:    yes
  @Structure:   single

*/

type funcType = Float64, Rune -> String;

main() {
    return 0;
}

