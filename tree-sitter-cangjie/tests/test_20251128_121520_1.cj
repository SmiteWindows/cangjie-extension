/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_01_a12_02

  @Level:         1
  @Assertion:       2.1.11.1(12) It is supported to define recursive and mutually recursive enum types.

  @Description:     Checks that it is possible to define mutually recursive enums

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/

enum E {
    E1 | E1(Q) | E1(E, Q)
}

enum Q {
  QWERT(E, Q) | QAZ
}

main() {
    let a = E1
    var b = E1(QAZ)
    var c = QWERT(a, QAZ)
}
