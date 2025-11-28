/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_02_a01_dec_exp_2

  @Level:         1

  @Assertion:    1.3.2(1) 
                 Floating-point literals can be written in 2 bases:
                 decimal (without prefix) and hexadecimal (prefixed with 0xor 0X).
                  
  @Description:  Check that float number with decimal exponent folded correctly
                 Considered all float types f16,f32,f64, default(f32)
                 Cases with mantisses represented
  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      

*/
import utils.assert.Assert
main() {
    Assert.equals(2.001e4,20010.0)
    Assert.equals(2.002e4f32,20020.0f32)
    Assert.equals(2.003e4f16,20030.0f16)
    Assert.equals(2.004e4f64,20040.0f64)
    Assert.equals(1.5e-2,0.015)
    Assert.equals(1.5e-2f16,0.015f16)
    Assert.equals(1.5e-2f32,0.015f32)
    Assert.equals(1.5e-2f64,0.015f64)
}
