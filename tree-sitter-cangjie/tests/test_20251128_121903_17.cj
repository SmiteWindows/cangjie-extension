/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_04_01_a09_01

  @Level:         1

  @Assertion:   2.4.1(9) Moreover, the generic type alias naturally has the generic constraints in the original type.  

  @Description: Check that the generic type alias naturally has the generic constraints in the original type

  @Mode:        compileonly

  @Negative:    yes


*/

class MyCls {}

class GenericClassA<V> where V <: ToString {}
type Class1<V> = GenericClassA<V>

main(): Unit {
    var c = Class1<MyCls>()
}
