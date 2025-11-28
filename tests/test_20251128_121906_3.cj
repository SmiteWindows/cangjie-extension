/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            03_02_02_a01_01

  @Level:         1
  @Assertion:       3.2.2(1) The scope of a name is the part of the program where the name can be used to refer to the
                    entity, without any qualifier, provided that the name is not shadowed.

  @Description:     Check that using the name in the scope we refer to the entity.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Comment:         There are several entities at different levels: several globals (GLOBAL_CONST, GlobalClass) and
                    locals, all named by `local`. The test below is a positive test that checks at each level that the
                    visible variable has the correct value. Numbers are taken randomly.

  @Issue: 0006124

*/

import utils.assert.Assert

let GLOBAL_CONST = 192i32

let GLOBAL_LAMBDA = { =>
    let local = 33
    Assert.equals(33, local)
    Assert.equals(192i32, GLOBAL_CONST)
    GLOBAL_CONST
}

class GlobalClass {
    var classVar = 0
    mut prop classProp: Int64 {
        get() { classVar }
        set(local) {
            Assert.equals(0, classVar)
            Assert.notEquals(33, local)
            Assert.notEquals(192, local)
            classVar = local
        }
    }
}

main() {
    let local = Int64(GLOBAL_CONST)
    Assert.equals(192i32, GLOBAL_CONST)
    Assert.equals(192, local)

    var local1 = GlobalClass()
    local1.classProp = 67
    Assert.equals(192, local)
    Assert.equals(67, local1.classVar)

    Assert.equals(GLOBAL_CONST, GLOBAL_LAMBDA())
}
