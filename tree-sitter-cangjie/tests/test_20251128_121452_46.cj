/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a03_001

  @Level:         1

  @Assertion:   1.3.6(3) Furthermore, a single-line string literal can only be written on the same line.

  @Description:  Checks that single-line string literal with zero characters cannot be written on two lines.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  

*/

main(){
    let stringValue:String = "
";
    return 0;
}

