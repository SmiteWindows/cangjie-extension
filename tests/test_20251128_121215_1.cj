/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_01_a03_03

  @Level:         1

  @Assertion:    2.1.6.1(3) 
 let s1 = "" // empty string
 let s2: String = "Hello Cangjie Lang" // define string s2
 var s3 = "\"Hello Cangjie Lang\"" // define string s3 containing character "
 var s4: String = "Hello Cangjie Lang\n" // define string s4 containing character \n
 // illegal string with character \
 let s5 = "hello\"
 // illegal string with character "
 let s6 = "Hello "Cangjie Lang"

  @Description:  Negative example from specification.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/

main() {
  // illegal string with character "
  let s6 = "Hello "Cangjie Lang"
}