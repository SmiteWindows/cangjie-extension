/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_02_a02_fpl_1

  @Level:         1

  @Assertion:    1.3.2(2) 
                 In the decimal representation, a floating-point number must contain an integer part or a fractional part
  @Description:  Check float numbers are written correctly

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:

*/
import utils.assert.Assert
main() {
    Assert.isTrue(.001       > 0.0)   
    Assert.isTrue(20010.0    > 0.0)     
    Assert.isTrue(20020.1f32 > 0.0)

    Assert.equals(1e-2,0.01)
    Assert.equals(1e-2f16,0.01f16)
    Assert.equals(1e-2f32,0.01f32)
    Assert.equals(1e-2f64,0.01f64)

    return 0; 
}
