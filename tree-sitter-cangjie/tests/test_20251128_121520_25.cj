/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a01_57

  @Level:         1

  @Assertion:    3.3.1(1) 
  The syntax of variable definition is as follows. 
    variableDeclaration 
         : variableModifier* ('let' | 'var') patternsMaybeIrrefutable ( (':' type)? ('=' expression) 
         | (':' type)) 
         ; 
    variableDeclaration 
    patternsMaybeIrrefutable 
         : wildcardPattern 
         | varBindingPattern 
         | tuplePattern 
         | enumPattern 
         ; 

  @Description:  Check that variable declaration using wrong syntax will produce error on compilation.
                 Case: immutable local-level variable declaration with type and w/o ':'

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single
*/

main() {
    let x Float16 = 5.36
}