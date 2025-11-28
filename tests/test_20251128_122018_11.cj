/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_a01_09

  @Level:         1

  @Assertion:    1.3(1) A literal is an expression that represents a value that cannot be modified.

  @Description:  Checks that literal of type UInt64 cannot be used in the left part of the operator 'Assignment'.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/

main(){ 
    88u64 = 89u64;
    return 0;
}

