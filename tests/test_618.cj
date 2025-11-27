/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_05_a01_2

  @Level:         1

  @Assertion:    1.5(1) Single-line comments begin with //, whose syntax is:
                  
  @Description:  Example with other language(Ada) comment

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/
import utils.assert.Assert

main() {
   Assert.equals(55i8,0b110111_i8)   -- line 1
   Assert.equals(0o37i8,0b11111_i8); -- line 2
   Assert.equals(0x1Fi8,0b11111_i8)  -- line 3
}
