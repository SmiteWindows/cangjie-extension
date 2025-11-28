/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a08_002

  @Level:         1

  @Assertion:   1.3.6(8) Different from single-line string literals, a multi-line string literal can span multiple lines.

  @Description:  Checks that multi-line string literal can span multiple lines.

  @Mode:         compileonly

  @Negative:     no

  @Structure:    single

  @Comment:  

*/

main(){
    let stringValue:String = """
1
2

"""
    return 0;
}

