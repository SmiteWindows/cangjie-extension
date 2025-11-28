/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_10_a13_01

  @Level:         1

  @Assertion:   2.1.10(13) Examples of recursive or mutually recursive struct types are defined as follows.
                 struct R1 { // error: 'R1' cannot have a member that recursively contains it
                  let other: R1
                 }
                 struct R2 { // ok
                  let other: Box<R2>
                 }
                 struct R3 { // error: 'R3' cannot have a member that recursively contains it
                  let other: R4
                 }
                 struct R4 { // error: 'R4' cannot have a member that recursively contains it
                  let other: R3
                 }
                 struct R5 { // ok
                  let other: E1
                 }
                 enum E1 { // ok
                  A(R5)
                 }

  @Description: Checks that the struct type 'R1', defined above, causes compilation error.

  @Mode:        compileonly
  @Negative:    yes
  @Structure:   single

*/

struct R1 { 
    let other: R1
}

main() {
    return 0;
}

