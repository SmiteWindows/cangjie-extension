/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_08_01_a08_02

  @Level:         1
  @Assertion:       2.1.8.1(8) The start and (or) end can be omitted in the scenario that using
                    instances of type Range<Int64> in the index access operator [] (see the next
                    section). But for other cases, only the step is optional (defaultly step=1),
                    which means start and end are both mandatory.

  @Description:     Checks that end value is required in definition.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single

*/

main() {
  let a = 200..
  return 0
}
