/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_01_a02_bil_u64

  @Level:         1

  @Assertion:   1.3.1(2) Binary literals must start with 0b(or 0B)
                  

  @Description:  Compiler find that binary literal exceeds range UInt64  
                 and emit error about it
  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/
main():UInt64 {
   return 0b1010_1010_1010_1010__1010_1010_1010_1010___1010_1010_1010_1010__1010_1010_1010_1010_1u64
}
