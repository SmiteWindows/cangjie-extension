
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a02_2

  @Level:         1

  @Assertion:    1.4(2) @ Macro call expression
                  
  @Description:  Emit error if macro body and macro call in same file

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/
public macro mot(expected: Tokens, actual: Tokens) {
    quote(match ($(actual)) {
              case $(expected) => ()
              case _ => print(actual)
          })
}

main() {
    @mot ["if"] ("IF")
    return 0;
}
