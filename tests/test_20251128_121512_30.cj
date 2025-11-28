/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: test_composites_1

  @Assertion: Check @Dependencies work 

  @Description: Test with multiple files and different packages
  
  @Mode: run

  @Negative: no

  @Structure: complex-main

  @Dependencies:  composites_aux_0.cj other/other_aux_0.cj
*/

package composites

import other.bar

main() {
  foo()
  bar()
}