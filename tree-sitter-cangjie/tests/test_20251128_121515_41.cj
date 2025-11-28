/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a17_06

  @Level:         1

  @Assertion:    1.2(17) For multi-line comment, the comment is terminated by the first '*'/

  @Description:  Check when there are only opening '*'/ items for embeded multi-line comments. 

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
/*
    /*
	comment #1
        /*
              comment #2
}