/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_01_a07_dil_u8

  @Level:         1

  @Assertion:   1.3.1(7) The syntax of integer literals
                  
  @Description:  Check that octal number with type u8 folded correctly

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      

*/
import utils.assert.Assert
main() {
   Assert.equals(0O371u8, 0b11111001)
}
