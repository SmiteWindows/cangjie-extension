/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a03_011

  @Level:         1

  @Assertion:   2.1.1(3) Signed integer types include Int8, Int16, Int32, Int64 and IntNative,
                which are used to represent types of signed integer values whose lengths are
                8-bit, 16-bit, 32-bit, 64-bit and platform dependent size, respectively.

  @Description: Checks that variable declared with signed integer type Int32 cannot be assigned by 
                  value '4294967296', which takes 33 bits;

  @Mode:        compileonly

  @Negative:    yes

  @Structure:   single

*/

main() {
    let intVar: Int32 = 4294967296;

    return 0
}