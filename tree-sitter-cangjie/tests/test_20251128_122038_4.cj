/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_01_a02_083

  @Assertion:    3.1(2) Keywords, variables, functions, types (including class, interface, struct, enum, 
                  and type alias), packages and modules in the Cangjie programming language share 
                  the same name spaces.
                  
  @Description:  Сheck that entity `mutable variable` and keyword `func` have the same namespace.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/

var func = 1

main() {}
