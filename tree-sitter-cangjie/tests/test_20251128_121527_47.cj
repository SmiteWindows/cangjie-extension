/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_04_01_a07_02

  @Level:         1

  @Assertion:   2.4.1(7) When defining a generic type alias, it is not allowed for adding generic constraints for
                type parameters in the alias and the original type. 

  @Description: Check that when defining a generic type alias, is not allowed to add common constraints for type
                parameters in the type alias.

  @Mode:        compileonly

  @Negative:    yes


*/

class GenericClassA<K> {}

type Class1<V> where V <: ToString = GenericClassA<V> 

main(): Unit {}
