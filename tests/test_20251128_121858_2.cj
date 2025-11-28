/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a07_001

  @Level:         1

  @Assertion:   1.3.6(7) If non-escaped three double quotations is not matched before the end of current file, 
                a compiler error is reported.

  @Description:  Checks that multi-line string literal cannot be represented 
                 without ending non-escape three double quotations;

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  

*/

main(){
    let stringValue:String = """
111
222
333
    return 0;
}

