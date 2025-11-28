/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_04_01_a10_01

  @Level:         1

  @Assertion:   2.4.1(10) 
        type Class1<V> where V <: MyTrait = GenericClassA<Int64, V> // error: generic constraints are not allowed here
        type Class2<V> = GenericClassB<Int64, V> where V <: MyTrait // error: generic constraints are not allowed here
        type Class3<V> = GenericClassC<Int64, V>
        func foo<V> (p: Class3<V>) where V <: MyTrait { // add generic constraints when 'Class3<V>' is used
        functionBody
        }
        class ClassWithLongName<T> where T<:MyTrait {
        classBody
        }
        type Class<T> = ClassWithLongName<T> // Class<T> also has the constraint 'where T<:MyTrait'  

  @Description: Check full example

  @Mode:        compileonly

  @Negative:    yes


*/

interface MyTrait {}
class GenericClassA<K, V> {}
class GenericClassB<K, V> {}
class GenericClassC<K, V> {}

type Class1<V> where V <: MyTrait = GenericClassA<Int64, V> // error: generic constraints are not allowed here
type Class2<V> = GenericClassB<Int64, V> where V <: MyTrait // error: generic constraints are not allowed here
type Class3<V> = GenericClassC<Int64, V>

func foo<V> (p: Class3<V>) where V <: MyTrait { // add generic constraints when 'Class3<V>' is used
}

class ClassWithLongName<T> where T<:MyTrait {}

type Class<T> = ClassWithLongName<T> // Class<T> also has the constraint 'where T<:MyTrait' 

main(): Unit {}
