/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_01_a04_xil_u64

  @Level:         1

  @Assertion:    1.3.1(4) and hexadecimal literals must start with 0x(or 0X).
                  
  @Description:  Compiler find that hex literal exceeds range u64
                 and emit error about it

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/
main():UInt64 {
   return 0XF70F06001771177100u64
}
