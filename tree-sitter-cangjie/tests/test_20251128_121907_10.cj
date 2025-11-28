/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_04_01_a12_02

  @Level:         1

  @Assertion:   2.4.1(12) 
                    type Value = GenericClassAp<Int64, Value> // error: 'Value' references itself
                    type Type1 = (Int64)->Type1 // error: 'Type1' references itself
                    type Type2 = (Int64, Type2) // error: 'Type2' references itself
                    type Type3 = Type4 // error: 'Type3' indirectlly references itself
                    type Type4 = Type3

  @Description: Check example, case 2

  @Mode:        compileonly

  @Negative:    yes

*/

type Type1 = (Int64)->Type1 // error: 'Type1' references itself

main(): Unit {}
