/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a19_03

  @Level:         1

  @Assertion:   2.1.1(19) For ease of use, the Cangjie programming language provides some type aliases
                in particular (For details about type aliases, see the Type Alias section below.):
                1. A Byte type as a type alias of UInt8, and Byte is completely equivalent to UInt8.
                2. Int/UInt type as type alias of Int64/UInt64. Int is completely equivalent to Int64,
                UInt is completely equivalent to UInt64.)

  @Description: Checks that variable declared with type Byte can be assigned by 
                value '255' which is maximal value of UInt8 type;

  @Mode:        run

  @Negative:    no

  @Structure:   single

*/

import utils.assert.Assert

main() {
    let byteVar: Byte = 255;
    Assert.equals(255, byteVar, 
        reason: """
A variable, declared with type Byte
and assigned by value '255', has unexpected value.
""");

    return 0;
}

