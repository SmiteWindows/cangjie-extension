/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        bug_0005891

  @Assertion:   0005891: Internal Compiler Error: invalid primitive type with code with double error in line of code

  @Description: Internal Compiler Error: invalid primitive type!

  @Mode:        compileonly

  @Negative:    yes

  @Structure:   single

*/

main(){
    let Int_literal:Int33 = 1suffix;
    // let Int_literal:Int33 = suffix; // with this - OK: reports about 2 errors
    return 0;
}

