/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_02_a02_fpl_4

  @Level:         1

  @Assertion:    1.3.2(2) 
                 In the decimal representation, a floating-point number must contain an integer part or a fractional part

  @Description:  Compiler emit error if number has empty fractional part. Only dot (.) w/o mantis numbers

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/
main() 
    5.f32       
}
