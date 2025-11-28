/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_10_a01_04

  @Level:         1

  @Assertion:   2.1.10(1) The struct type is mutable, in which multiple member 
                variables and member functions can be defined.

  @Description: Checks that in the struct multiple member variables and 
                multiple member functions can be defined.

  @Mode:        compileOnly
  @Negative:    no
  @Structure:   single

*/

struct Struct {
    var varMember1: Int32;
    var varMember2: Bool = true;
    var varMember3: String = "s1";

    init(varMember1: Int32) {
        this.varMember1 = varMember1;
    };

    func function1(param: Int32): Int32 { return param + varMember1; }
    func function2(param: Bool): Bool { return param == varMember2; }
    func function3(param: String): String { return param + varMember3; }

}

main() {
    var testStructVar: Struct = Struct(20);

    return 0;
}