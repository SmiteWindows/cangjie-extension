/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a02_186

  @Level:         1

  @Assertion: 2.1.10.2(2)
              The syntax of the primary constructor is as follows:
              structPrimaryInit
                : (structNonStaticMemberModifier)? structName '('
                  structPrimaryInitParamLists? ')'
                  '{'
                  expressionOrDeclarations?
                  '}'
                ;
              structName
                : identifier
                ;
              structPrimaryInitParamLists
                : unnamedParameterList (',' namedParameterList)?
                (',' structNamedInitParamList)?
                | unnamedParameterList (',' structUnnamedInitParamList)?
                (',' structNamedInitParamList)?
                | structUnnamedInitParamList (',' structNamedInitParamList)?
                | namedParameterList (',' structNamedInitParamList)?
                | structNamedInitParamList
                ;
              structUnnamedInitParamList
                : structUnnamedInitParam (',' structUnnamedInitParam)*
                ;
              structNamedInitParamList
                : structNamedInitParam (',' structNamedInitParam)*
                ;
              structUnnamedInitParam
                : structNonStaticMemberModifier? ('let' | 'var') identifier ':' type
                ;
              structNamedInitParam
                : structNonStaticMemberModifier? ('let' | 'var') identifier '!' ':' type
                ('=' expression)?
                ;

  @Description: Check that struct named parameters can not be defined with
                both public and private modifiers

  @Mode: compileonly

  @Negative: yes

  @Structure: single

  @Issue: 0006175
*/

struct dfqof {
    dfqof(public private let a!: Int64) {}
}

main() {
}