/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_02_a03_dec_exp_2

  @Level:         1

  @Assertion:    1.3.2(3) 
                 An exponential part (prefixed with e or E) is required when there is no decimal part

                  
  @Description:  Compiler checks that number with exponent part has no integer and fractional part
                 and emit error 

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/
main() {
    E-1
    0
}
