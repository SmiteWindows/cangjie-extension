/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_05_a01_18

  @Level:         1

  @Assertion:    1.3.5(1) There are only two Boolean literals: true and false.
                 booleanLiteral : 'true' | 'false' ;

  @Description:  Checks that mutable variable of type different from Bool cannot be
                 assigned by Boolean literal.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  

*/

main(){

    var mutableVar:Float32 = false;
    return 0;
}

