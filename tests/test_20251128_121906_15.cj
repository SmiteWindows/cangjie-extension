/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_03_a01_01

  @Level:         1

  @Assertion:    3.2.3.3(1) The scope of classes/interface/struct’s members is the entire class/interface/struct
                  definition.


  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

class C {
    let a: Int64
    static let FOO1: String = "foo1"
    static public let FOO2: String = "foo2"
    static private let FOO3: String = "foo3"
    public let foo4: String = "foo4"
    private let foo5: String = "foo5"
    let foo6: String = "foo6"
 
    init (p: Int64) {
        this.a = p
    }

    func getA(): Int64 { a }

    static func getFoo1(): String { FOO1 }

    static func getFoo2(): String { FOO2 }

    static func getFoo3(): String { FOO3 }

    func getFoo4(): String { foo4 }
  
    func getFoo5(): String { foo5 }

    func getFoo6(): String { foo6 }
}

main() {
    var obj = C(2023)
    Assert.equals(2023  , obj.getA())
    Assert.equals("foo1", C.getFoo1())
    Assert.equals("foo2", C.getFoo2())
    Assert.equals("foo3", C.getFoo3())
    Assert.equals("foo4", obj.getFoo4())
    Assert.equals("foo5", obj.getFoo5())
    Assert.equals("foo6", obj.getFoo6())
}
