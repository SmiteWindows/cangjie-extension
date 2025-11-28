/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_01_a05_dil_u8

  @Level:         1

  @Assertion:    1.3.1(5) Decimal literals do not require a prefix.
                  
  @Description:  Compiler find that decimal literal exceeds range u8
                 and emit error about it

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/
main():UInt8 {
   return 427u8
}
