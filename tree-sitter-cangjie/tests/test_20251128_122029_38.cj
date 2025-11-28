/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
   @Name:        02_01_07_a01_01

  @Level:         1
   @Assertion:   2.1.7(1) Tuple is an immutable data structure that can contain a heterogeneous sequence of elements.
   @Description: Check that tuple is an immutable data structure.
   @Mode:        compileOnly
   @Negative:    yes
   @Structure:   single
 */

main() {
    var t1 = (12, 34)
    t1 = (43, 55, 66)
    return 0
}
