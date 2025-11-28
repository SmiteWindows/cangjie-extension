/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_a03_007

  @Level:         1

  @Assertion:   1.3(3) The syntax of literal is defined as follows.
                   literalConstant
                       : IntegerLiteral
                       | FloatLiteral
                       | CharacterLiteral
                       | booleanLiteral
                       | stringLiteral
                       ;

                   stringLiteral
                       : lineStringLiteral
                       | multiLineStringLiteral
                       | MultiLineRawStringLiteral
                       ;

  @Description:  Checks that literalConstant cannot be of invalid syntax.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  

*/

main(){
    let floatVariable = 1.0f33;
    return 0;
}

