/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_01_a02_001

  @Assertion:    3.1(2) Keywords, variables, functions, types (including class, interface, struct, enum, 
                  and type alias), packages and modules in the Cangjie programming language share 
                  the same name spaces.

  @Description:  Сheck that entities have the same namespace.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      

*/

import utils.assert.*

class C {
    let x = 0.6787
}

struct s {
    let x = 4444
}

func f() {}

enum e { x }

type t = (Int64, Int64)


main() {
    var class_obj = C()
    Assert.isTrue(class_obj is C)
    Assert.equals(class_obj.x, 0.6787)

    var struct_obj = s()
    Assert.isTrue(struct_obj is s)
    Assert.equals(struct_obj.x, 4444)

    var func_obj = f
    Assert.isTrue(func_obj is ()->Unit)
    
    var enum_obj = e.x
    Assert.isTrue(enum_obj is e)

    var alias_obj: t = (56, 753434534)
    Assert.isTrue(alias_obj is t)
}