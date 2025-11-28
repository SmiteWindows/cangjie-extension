/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            03_02_02_a08_03

  @Level:         1
  @Assertion:       3.2.2(8) For classes and interfaces, the name in this class is at a higher level of scope than the
                    name in the superclass. The name in a subclass may shadow or override the name in the superclass.

  @Description:     Check that the name of an overriden function or property in this interface is at a higher level of
                    scope than the name in a superinterface.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Issue:           0006086,0006133

*/

import utils.assert.Assert

interface SuperInterface1 {
    func superInterface1F() { "SuperInterface1.superInterface1F" }

    prop superInterface1G: String {
        get() { "SuperInterface1.superInterface1G" }
    }
}

interface SuperInterface2 {
    func superInterface2F() { "SuperInterface2.superInterface2F" }

    prop superInterface2G: String {
        get() { "SuperInterface1.superInterface2G" }
    }
}

interface I <: SuperInterface1 & SuperInterface2 {
    override func superInterface1F() { "I.superInterface1F" }
    override func superInterface2F() { "I.superInterface2F" }

    override prop superInterface1G: String {
        get() { "I.superInterface1G" }
    }
    override prop superInterface2G: String {
        get() { "I.superInterface2G" }
    }

    func test() {
        Assert.equals("I.superInterface1F", superInterface1F())
        Assert.equals("I.superInterface2F", superInterface2F())

        Assert.equals("I.superInterface1G", superInterface1G)
        Assert.equals("I.superInterface2G", superInterface2G)
    }
}

class C <: I {}

main() {
    C().test()
}
