/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a18_02

  @Level:         1

  @Assertion:    3.3.1(18) The keyword let/varand the pattern are mandatory.

  @Issue:        6526

  @Description:  Check that immutable variable definition is possible with and without specifying a variable type

  @Mode:         compileonly

  @Negative:     no

  @Structure:    single

*/

public let myPublicTopLet = 127
public let myPublicTopLetWithType: Float64 = 0.01
let myTopLet = 'J'

class MyClass {
    static public let myStaticPublicClassMemberLet = 127
    static public let myStaticPublicClassMemberLetWithType: Range<UInt8> = 0..9:1
    public let myPublicClassMemberlet = ("HmY", 3.14)
    static private let myStaticPrivateClassMemberLet = 0
    static private let myStaticPrivateClassMemberLetWithType: Rune = 'h'
    private let myPrivateClassMemberLet = 5
    static protected let myStaticProtectedClassMemberLet = -12.70
    protected let myProtectedClassMemberLet = 127
    protected let myProtectedClassMemberLetWithType: String = "asfljh"
    static let myStaticClassMemberLet = -1
    let myClassMemberLet = 127
}

struct Triangle { 
    static let myStaticLet = 10.9 
    static public let myStaticPublicLet = 'L' 
    static public let myStaticPublicLetWithType: Int64 = 10 
    public let myPublicLet = ('Y', "AAA")
    let myLet = [10, 7, 55]
} 

main() {
    let myLocalLet = "k3e5r0jk"
    let myLocalLetWithType: Int8 = 12
}
