/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            03_02_02_a01_03

  @Level:         1
  @Assertion:       3.2.2(1) The scope of a name is the part of the program where the name can be used to refer to the
                    entity, without any qualifier, provided that the name is not shadowed.

  @Description:     Check that outside the scope we can't refer to the entity.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
  @CompileWarning:  no

*/

let LAMBDA = { => a }

main() {
    let a = 13
}
