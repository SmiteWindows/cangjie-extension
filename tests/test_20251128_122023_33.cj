/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_02_a10_01

  @Level:         1
  @Assertion:       2.1.1.2(10) Relational operators include less then (<), greater than (>), less than or
                    equal to (<=), greater than or equal to (>=), equal to (==), and not equal to (!=). Their results
                    are Boolean values (i.e. true or false).

  @Description:     Check that the listed operators work as expected for all possible types.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

*/

import utils.assert.Assert

main() {
    Assert.isTrue(-1i8 < 0)
    Assert.isTrue(0u8 < 1)
    Assert.isTrue(-2i16 < -1)
    Assert.isTrue(1u16 < 2)
    Assert.isTrue(-3i32 < -2)
    Assert.isTrue(2u32 < 3)
    Assert.isTrue(-4 < -3)
    Assert.isTrue(3u64 < 4)
    Assert.isTrue(IntNative(-5) < -4)
    Assert.isTrue(UIntNative(4) < 5)

    Assert.isTrue(-4i8 > -5)
    Assert.isTrue(5u8 > 4)
    Assert.isTrue(-5i16 > -6)
    Assert.isTrue(6u16 > 5)
    Assert.isTrue(-6i32 > -7)
    Assert.isTrue(7u32 > 6)
    Assert.isTrue(-7 > -8)
    Assert.isTrue(8u64 > 7)
    Assert.isTrue(IntNative(-8) > -9)
    Assert.isTrue(UIntNative(9) > 8)

    Assert.isTrue(-8i8 <= -8)
    Assert.isTrue(8u8 <= 8)
    Assert.isTrue(-9i16 <= -8)
    Assert.isTrue(8u16 <= 9)
    Assert.isTrue(-9i32 <= -9)
    Assert.isTrue(9u32 <= 9)
    Assert.isTrue(-10 <= -10)
    Assert.isTrue(9u64 <= 10)
    Assert.isTrue(IntNative(-11) <= -10)
    Assert.isTrue(UIntNative(10) <= 10)

    Assert.isTrue(-8i8 <= -8)
    Assert.isTrue(8u8 <= 8)
    Assert.isTrue(-9i16 <= -8)
    Assert.isTrue(8u16 <= 9)
    Assert.isTrue(-9i32 <= -9)
    Assert.isTrue(9u32 <= 9)
    Assert.isTrue(-10 <= -10)
    Assert.isTrue(9u64 <= 10)
    Assert.isTrue(IntNative(-10) <= -10)
    Assert.isTrue(UIntNative(10) <= 10)

    Assert.isTrue(-10i8 >= -10)
    Assert.isTrue(10u8 >= 10)
    Assert.isTrue(-10i16 >= -11)
    Assert.isTrue(11u16 >= 10)
    Assert.isTrue(-11i32 >= -11)
    Assert.isTrue(11u32 >= 11)
    Assert.isTrue(-11 >= -12)
    Assert.isTrue(12u64 >= 11)
    Assert.isTrue(IntNative(-12) >= -12)
    Assert.isTrue(UIntNative(12) >= 12)

    Assert.isTrue(-12i8 == -12)
    Assert.isTrue(12u8 == 12)
    Assert.isTrue(-13i16 == -13)
    Assert.isTrue(13u16 == 13)
    Assert.isTrue(-14i32 == -14)
    Assert.isTrue(14u32 == 14)
    Assert.isTrue(-15 == -15)
    Assert.isTrue(15u64 == 15)
    Assert.isTrue(IntNative(-16) == -16)
    Assert.isTrue(UIntNative(16) == 16)

    Assert.isTrue(-16i8 != -17)
    Assert.isTrue(16u8 != 17)
    Assert.isTrue(-17i16 != -18)
    Assert.isTrue(17u16 != 18)
    Assert.isTrue(-18i32 != -19)
    Assert.isTrue(18u32 != 19)
    Assert.isTrue(-19 != -20)
    Assert.isTrue(19u64 != 20)
    Assert.isTrue(IntNative(-20) != -21)
    Assert.isTrue(UIntNative(20) != 21)

    Assert.isTrue(0.21f16 < 0.22)
    Assert.isTrue(0.22f32 < 0.23)
    Assert.isTrue(0.23 < 0.24)

    Assert.isTrue(0.23f16 > 0.22)
    Assert.isTrue(0.24f32 > 0.23)
    Assert.isTrue(0.25 > 0.24)

    Assert.isTrue(-0.25f16 <= 0.24)
    Assert.isTrue(-0.26f32 <= 0.25)
    Assert.isTrue(-0.27 <= 0.26)

    Assert.isTrue(-0.27f16 >= -0.27)
    Assert.isTrue(-0.27f32 >= -0.28)
    Assert.isTrue(-0.28 >= -0.28)

    Assert.isTrue(0.28f16 == 0.28)
    Assert.isTrue(0.29f32 == 0.29)
    Assert.isTrue(0.30 == 0.30)

    Assert.isTrue(0.31f16 != -0.31)
    Assert.isTrue(0.32f32 != -0.32)
    Assert.isTrue(0.33 != -0.33)
}
