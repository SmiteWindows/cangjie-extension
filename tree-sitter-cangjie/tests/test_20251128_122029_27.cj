/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a02_077

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

  @Description: Check that the constructor name can not appear many times

  @Mode: compileonly

  @Negative: yes

  @Structure: single
*/

struct fhYIU {
    private fhYIU fhYIU fhYIU fhYIU(){}
}

main() {

}