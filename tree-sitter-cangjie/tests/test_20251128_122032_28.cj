/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a11_002

  @Level:         1

  @Assertion:   1.3.6(11) If another double quotation (") and the same number of # characters 
                as the beginning is not matched before the end of current file, a compiler error is reported.

  @Description:  Checks that multi-line raw string literal cannot be represented 
                 with ending signs (#) are not the same as the beginning.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  

*/

main(){
    let stringValue:String =###"multi-line raw string"####;

    return 0;
}

