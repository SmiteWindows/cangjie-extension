/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_04_01_a06_01

  @Level:         1

  @Assertion:   2.4.1(6)
    type Class1<V> = GenericClassA<Int64, V> // ok. ClassA is a generic class
    type Class2<Value, V> = GenericClassB<Int64, V> // warning: the type parameter 'Value' in 'Class2<Value, V>' is 
                                                       not used in 'GenericClassB<Int64, V>'
    type Int<T> = Int32 // warning: the type parameter 'T' in 'Int<T>' is not used in `Int32`

  @Description: Check the perfect example

  @Mode:        compileonly

  @Negative:    no

*/

class GenericClassA<K, V> {}

type Class1<V> = GenericClassA<Int64, V> // ok. ClassA is a generic class

main(): Unit {}
