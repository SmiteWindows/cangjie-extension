/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a01_05

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
                 Case: top-level immutable variable with type and with wrong init value

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single
*/

let myLetVariable: Int32 = 'A'

main() {
}