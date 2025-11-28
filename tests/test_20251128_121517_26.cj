/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        test_ffi_c_simple

  @Assertion:   Harness support ffi for c lang

  @Description: A simple example of calling C from Cangjie

  @Mode:        run

  @Negative:    no

  @Structure:   single

  @Comment:

*/

foreign func putsi(ptr: CString): Unit

main() {
    var Text : CString = CString("abcde");
    unsafe {
        putsi(Text);
    }
}
