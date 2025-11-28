/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_04_01_a04_01

  @Level:         1

  @Assertion:    2.4.1(4) 
                    class LongNameClassA {
                    }
                    type ClassB = LongNameClassB // error: use of undeclared type 'LongNameclassB'

  @Description:  Check example

  @Mode:         compileonly

  @Negative:     yes

*/

class LongNameClassA {}
type ClassB = LongNameClassB // error: use of undeclared type 'LongNameclassB'

main(): Unit {}
