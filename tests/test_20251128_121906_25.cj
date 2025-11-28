/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a13_005

  @Level:         1

  @Assertion:   1.3.6(13) The syntax of the multi-line raw string literal is:
                MultiLineRawStringLiteral
                    : MultiLineRawStringContent
                    ;
                fragment MultiLineRawStringContent
                    : '#' MultiLineRawStringContent '#'
                    | '#' '"' .*? '"' '#'
                    ;

  @Description:  Checks that multi-line raw string literal cannot be represented 
                 without ending double quotes.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  
*/

main(){
    let stringValue_01:String ="###1111###;
    return 0;
}




