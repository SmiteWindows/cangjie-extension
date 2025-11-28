/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a19_10

  @Level:         1

  @Assertion:   2.1.1(19) For ease of use, the Cangjie programming language provides some type aliases
                in particular (For details about type aliases, see the Type Alias section below.):
                1. A Byte type as a type alias of UInt8, and Byte is completely equivalent to UInt8.
                2. Int/UInt type as type alias of Int64/UInt64. Int is completely equivalent to Int64,
                UInt is completely equivalent to UInt64.)

  @Description: Checks that variable declared with type UInt cannot be assigned a negative value.

  @Mode:        compileonly

  @Negative:    yes

  @Structure:   single

  @Issue:       0006613

*/

main() {
    let uintVar: UInt = -1
    0
}

