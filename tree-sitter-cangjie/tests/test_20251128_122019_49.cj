/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_01_a05_dil_u64_1

  @Level:         1

  @Assertion:    1.3.1(5) Decimal literals do not require a prefix.
                  
  @Description:  Compiler check that decimal used only 0-9 . Type UInt64

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/
main():UInt64 {
   return 9807045053f053756031u64
}
