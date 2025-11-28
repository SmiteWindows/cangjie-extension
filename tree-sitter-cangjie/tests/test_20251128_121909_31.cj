/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_01_a03_024

  @Level:         1

  @Assertion:    3.1(3) A name uniquely represents one entity in any scope. That is, entities in the same
                  scope are not allowed to have the same name, except the names that make up overloading.
                  
  @Description:  Check that mutable variable and struct cannot have the same name in the same scope

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/

var name = 1

struct name {}

main() {}
