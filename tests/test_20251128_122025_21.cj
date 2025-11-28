/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_05_a02_02_neg

  @Level:         1

  @Assertion:    1.5(2) Multi-line comments put the comment between /* and */ 
                 (nested multi-line comments are supported), whose syntax is:
                  
  @Description:  Represent incorrect - enclosed comment

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/
import utils.assert.Assert
main() {
  /* all tests contain multi-line comment as header  // other comment
        /*
    /* */  // /*
                    */

}
