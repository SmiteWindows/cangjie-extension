/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_10_a11_02

  @Level:         1

  @Assertion:   2.1.10(11) The struct types defined recursively or mutually recursively are illegal, 
                unless there is at least one struct type T_i is encapsulated within a class, 
                interface, enum or function type on each recursive chain T_1, T_2, ..., T_N.
                That is to say, a recursive (or mutually recursive) struct definition can be made 
                legal by using class, interface, enum or function types.

  @Description: Checks that the struct types can be defined mutually recursively 
                using proxy class and function.

  @Mode:        run
  @Negative:    no
  @Structure:   single

*/

import utils.assert.*

func func1(): Class { return Class(200, func2); } 
func func2(): Struct { return Struct(); } 

struct Struct {
    var i64Var: Int64 = 200;
    var s2: Struct2 = Struct2();
}

struct Struct2 {
    var i32Var: Int32 = 100;
    var sf: () -> Class = func1;
}

class Class {
    var i16Var: Int16;
    var cf: () -> Struct;

    public Class(par1: Int16, par2: () -> Struct) {
        this.i16Var = par1;
        this.cf = par2;
    }
}

main() {
    // Test case 1
    var testStructVar  = Struct2().sf().cf().i64Var;
    Assert.equals(200, testStructVar, 
        reason: "Test case 1 FAILED.");

    // Test case 2
    var testStruct2Var  = Struct2().sf().cf().s2.i32Var;
    Assert.equals(100, testStruct2Var, 
        reason: "Test case 2 FAILED.");
}

