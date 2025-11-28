/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_01_a09_01

  @Level:         1

  @Assertion:    2.1.6.1(9) A multi-line raw string literal starts with one or more number of # characters
                 and a double quotation ("), followed by any valid characters (except one double quotation
                 and the same number of # characters as the beginning), and is terminated only by first
                 matched double quotation (") and the same number of # characters as the beginning.

  @Description:  Positive test with different variants of multy-line raw string literals.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      

  @Issue:      6118

*/
import utils.assert.Assert

public let myPublicTopLetMultyLine: String = #"
"#
public var myPublicTopVarMultyLine: String = #"
!dsfghf\u{1102}wqeg"#

let myTopLetMultyLine: String = ######"
^5^-03-4kmv \v"######
var myTopVarMultyLine: String = #"
 09u \u{1111}"#

class myClass{
  static let myStaticLetMultyLine: String = ######"
    \
      \t
      07235+
      //
  awfda"######
  static var myStaticVarMultyLine: String = #"
  abc\u{1112}"#

  public let myPublicLetMultyLine: String = ###"
  \' sdgsdg \"
  "###
  public var myPublicVarMultyLine: String = ###" #" my string "# "###
  protected let myProtectedLetMultyLine: String = ######################"
  "######################
  protected var myProtectedVarMultyLine: String = ###"
  qwtgwaegv

  \0
      \t
    \v
  "###
  private let myPrivateLetMultyLine: String = #"
  dsgdrsh
  "#
  private var myPrivateVarMultyLine: String = #"
  
  "#

  let myLetMultyLine: String = ##"
  \"   """
  "##
  var myVarMultyLine: String = #"
  "#

  myClass(inVal: String){
    Assert.equals(this.myPublicVarMultyLine, ###" #" my string "# "###)

    this.myPublicVarMultyLine = inVal
    this.myProtectedVarMultyLine = inVal
    this.myPrivateVarMultyLine = inVal
    this.myVarMultyLine = inVal
  }
  func checkVal() {
    Assert.equals(this.myPublicLetMultyLine,###"
  \' sdgsdg \"
  "###)
    Assert.equals(this.myPublicVarMultyLine,myPublicTopVarMultyLine)
    Assert.equals(this.myProtectedLetMultyLine,######################"
  "######################)
    Assert.equals(this.myProtectedVarMultyLine,myPublicTopVarMultyLine)
    Assert.equals(this.myPrivateLetMultyLine,#"
  dsgdrsh
  "#)
    Assert.equals(this.myPrivateVarMultyLine,myPublicTopVarMultyLine)
    Assert.equals(this.myLetMultyLine,##"
  \"   """
  "##)
    Assert.equals(this.myVarMultyLine,myPublicTopVarMultyLine)
  }
}

main() {
  
  let myLocalLetMultyLine: String = ###"
  ${ 'A' <= 'B'}"###
  var myLocalVarMultyLine: String = ##"
   """ 
  < \t "##

  Assert.equals(myLocalLetMultyLine,###"
  ${ 'A' <= 'B'}"###)
  Assert.equals(myLocalVarMultyLine,##"
   """ 
  < \t "##)
  
  Assert.equals(myTopLetMultyLine,######"
^5^-03-4kmv \v"######)
  Assert.equals(myTopVarMultyLine,#"
 09u \u{1111}"#)
  
  Assert.equals(myClass.myStaticLetMultyLine,######"
    \
      \t
      07235+
      //
  awfda"######)
  Assert.equals(myClass.myStaticVarMultyLine,#"
  abc\u{1112}"#)

  myLocalVarMultyLine = myClass.myStaticLetMultyLine
  Assert.equals(myLocalVarMultyLine,myClass.myStaticLetMultyLine)

  let myClassImpl = myClass(myPublicTopVarMultyLine)
  myClassImpl.checkVal()

  var myLocalVarMultyLineWithWriterSymbol: String = #######################"
  \f  we"#######################
  Assert.equals(myLocalVarMultyLineWithWriterSymbol,#######################"
  \f  we"#######################)
  var myLocalVarMultyLineWithNewLineSymbol: String = #####"
  asfwef \n"#####
  Assert.equals(myLocalVarMultyLineWithNewLineSymbol,#####"
  asfwef \n"#####)
  var myLocalVarMultyLineWithEnterSymbol: String = ####"
  asf \r wef
    """ \0
      #######" 
  "####
  Assert.equals(myLocalVarMultyLineWithEnterSymbol,####"
  asf \r wef
    """ \0
      #######" 
  "####)
  let myLocalLetMultyLineWithHTabSymbol: String = ########"
      ### \\
        """     "##
  asf \t wef"########
  Assert.equals(myLocalLetMultyLineWithHTabSymbol,#####"
      ### \\
        """     "##
  asf \t wef"#####)
  let myLocalLetMultyLineWithVTabSymbol: String = ###"
  e43wqs "##
  \v Swe4tef"###
  Assert.equals(myLocalLetMultyLineWithVTabSymbol,###"
  e43wqs "##
  \v Swe4tef"###)
  var myLocalVarMultyLineWithSingleQuoteSymbol: String = #"
  as
  f \' ${ 3 + 5}
  wef"#
  Assert.equals(myLocalVarMultyLineWithSingleQuoteSymbol,#"
  as
  f \' ${ 3 + 5}
  wef"#)
  let myLocalVarMultyLineWithDoubleleQuoteSymbol: String = #"
  double \" wef
    ###
  "#
  Assert.equals(myLocalVarMultyLineWithDoubleleQuoteSymbol,#"
  double \" wef
    ###
  "#)
}