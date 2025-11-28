/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_04_01_a08_01

  @Level:         1

  @Assertion:   2.4.1(8) The generic constraints can only be added when the generic type alias is used.  

  @Description: Check that can use generic constraints when using a generic alias.

  @Mode:        compileonly

  @Negative:    no


*/

class GenericClassA<V> {}
type Class1<V> = GenericClassA<V>

func foo<V> (p: Class1<V>) where V <: ToString { }

main(): Unit {}
