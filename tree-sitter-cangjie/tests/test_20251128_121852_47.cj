/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_01_a06_dil_u8

  @Level:         1

  @Assertion:   1.3.1(6) Meanwhile, a suffix can be added to denote the exact type of an integral literal
                  
  @Description:  Check that decimal number with type u8 folded correctly

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      

*/
import utils.assert.Assert
main() {
   Assert.equals(127u8,0b1111111u8)

}
