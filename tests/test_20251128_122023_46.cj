/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_01_a02_060

  @Assertion:    3.1(2) Keywords, variables, functions, types (including class, interface, struct, enum, 
                  and type alias), packages and modules in the Cangjie programming language share 
                  the same name spaces.
                  
  @Description:  Сheck that entity `immutable variable` and keyword `UInt64` have the same namespace.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/

let UInt64 = 0

main() {}
