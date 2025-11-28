/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a26_01

  @Level:         1

  @Assertion: 2.1.10.2(26)
              A primary constructor is a syntax sugar of regular constructor.
              The compiler automatically generates a definition of the constructor
              and member variables corresponding to the main constructor,
              the form of the automatically generated constructor is as follows:
              • The modifier is the same as that of the primary constructor.
              • The sequence of parameters from left to right is the same as that of parameters
                declared in the primary constructor parameter list.
              • The constructor body is in the following format:
                – Assign values to member variables in sequence.
                  The syntax format is this.x = x, where x indicates the member variable name.
                – Then other code inside the primary constructor body.

  @Description: Check that a primary constructor automatically generates
                member variables corresponding to member variable parameters

  @Mode: run

  @Negative: no

  @Structure: single

*/

import utils.assert.Assert

struct Test {
    Test(
        public var p1: Int64,
        private var p2: Int64,
        var p3: Int64,
        public let p4: Int64,
        private let p5: Int64,
        let p6: Int64,

        public var p7!: Int64,
        private var p8!: Int64,
        var p9!: Int64,
        public let p10!: Int64,
        private let p11!: Int64,
        let p12!: Int64
    ) {}

    func check() {
        Assert.equals(1, this.p1)
        Assert.equals(2, this.p2)
        Assert.equals(3, this.p3)
        Assert.equals(4, this.p4)
        Assert.equals(5, this.p5)
        Assert.equals(6, this.p6)
        Assert.equals(7, this.p7)
        Assert.equals(8, this.p8)
        Assert.equals(9, this.p9)
        Assert.equals(10, this.p10)
        Assert.equals(11, this.p11)
        Assert.equals(12, this.p12)
    }
}

main() {
    let a = Test(1, 2, 3, 4, 5, 6, p7: 7, p8: 8, p9: 9, p10: 10, p11: 11, p12: 12)
    a.check()
}