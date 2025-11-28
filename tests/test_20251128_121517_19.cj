/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_a01_02

  @Level:         1

  @Assertion:    1.3(1) A literal is an expression that represents a value that cannot be modified.

  @Description:  Checks that literal of type Int8 cannot be used in the left part of the operator 'Assignment'.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/

main(){ 
    1i8 = -2i8;
    return 0;
}

