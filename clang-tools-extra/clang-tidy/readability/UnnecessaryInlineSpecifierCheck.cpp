//===--- UnnecessaryInlineSpecifierCheck.cpp - clang-tidy -----------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include <iostream>
#include "UnnecessaryInlineSpecifierCheck.h"
#include "clang/AST/ASTContext.h"
#include "../utils/LexerUtils.h"
#include "../utils/FileExtensionsUtils.h"

#include "clang/ASTMatchers/ASTMatchFinder.h"

using namespace clang::ast_matchers;

namespace clang::tidy::readability {

namespace {
const TemplateParameterList *
getLastTemplateParameterList(const FunctionDecl *FuncDecl) {
  const TemplateParameterList *ReturnList =
      FuncDecl->getDescribedTemplateParams();

  if (!ReturnList) {
    const unsigned NumberOfTemplateParameterLists =
        FuncDecl->getNumTemplateParameterLists();

    if (NumberOfTemplateParameterLists > 0)
      ReturnList = FuncDecl->getTemplateParameterList(
          NumberOfTemplateParameterLists - 1);
  }

  return ReturnList;
}

AST_MATCHER(CXXMethodDecl, isMethodDeclWithInline) {
  return Node.isInlineSpecified();
}
AST_MATCHER(CXXMethodDecl, isDefinitionOrInline) {
  // A function definition, with optional inline but not the declaration.
  return !(Node.isThisDeclarationADefinition() && Node.isOutOfLine());
}
}

UnnecessaryInlineSpecifierCheck::UnnecessaryInlineSpecifierCheck(llvm::StringRef Name, clang::tidy::ClangTidyContext *Context)
    : ClangTidyCheck(Name, Context),
      HeaderFileExtensions(Context->getHeaderFileExtensions()) {}


void UnnecessaryInlineSpecifierCheck::registerMatchers(MatchFinder *Finder) {
  // FIXME: Add matchers.
  Finder->addMatcher(
      cxxMethodDecl(
        isMethodDeclWithInline(),
        isDefinitionOrInline()
      ).bind("unnecessary_inline"),
  this);
}

void UnnecessaryInlineSpecifierCheck::check(const MatchFinder::MatchResult &Result) {
  // FIXME: Add callback implementation.
  const auto *MatchedDecl =
      Result.Nodes.getNodeAs<CXXMethodDecl>("unnecessary_inline");

  if (MatchedDecl == nullptr || !MatchedDecl->isInlined()) {
    return;
  }

  SourceLocation SrcBegin = MatchedDecl->getBeginLoc();
  //SourceLocation RetLoc = MatchedDecl->getLocation();

  // If we have a template parameter list, we need to skip that because the
  // LIBC_INLINE macro must be placed after that.
  //  if (const TemplateParameterList *TemplateParams =
  //          getLastTemplateParameterList(MatchedDecl)) {
  //    SrcBegin = TemplateParams->getRAngleLoc();
  //    std::optional<Token> NextToken =
  //        utils::lexer::findNextTokenSkippingComments(
  //            SrcBegin, *Result.SourceManager, Result.Context->getLangOpts());
  //    if (NextToken)
  //      SrcBegin = NextToken->getLocation();
  //  }

  //  // Consider functions only in header files.
  //  if (!utils::isSpellingLocInHeaderFile(SrcBegin, *Result.SourceManager,
  //                                        HeaderFileExtensions))
  //    return;

  // Ignore lambda functions as they are internal and implicit.
  if (MatchedDecl->getParent()->isLambda()) {
    return;
  }

  //
  //  const SourceLocation endLoc = MatchedDecl->getBeginLoc();
  //
  //  std::optional<Token> token;
  //  while (true) {
  //        token = utils::lexer::findNextTokenSkippingComments(SrcBegin, *Result.SourceManager, getLangOpts()); break; if (!token) {
  //          break;
  //        }
  //        if (token->getLocation() >= endLoc) {
  //          break;
  //        }
  //        if (token->isOneOf(tok::kw_inline, tok::eof)) {
  //          break;
  //        }
  //        SrcBegin = token->getLocation();
  //  }
  std::string is_inline = "?";
  std::string is_static = "?";
  std::string value = "?";
  //  if (token.has_value()) {
  //    if (token->is(tok::kw_inline)) {
  //      is_inline = "yes";
  //    } else if (token->is(tok::kw_static)) {
  //      is_static = "yes";
  //    } else {
  //      value = std::to_string(token->getKind());
  //    }
  //  } else {
  //    value = "no token";
  //  }
  //
  bool FoundInlineToken = false;
  while (!FoundInlineToken) {
    auto Loc = FullSourceLoc(Result.SourceManager->getFileLoc(SrcBegin),
                             *Result.SourceManager);
    auto loc_str = Loc.printToString(*Result.SourceManager);
      llvm::StringRef SrcText =
          Loc.getBufferData().drop_front(Loc.getFileOffset());
      if (SrcText.starts_with("inline ")) {
        FoundInlineToken = true;
      } else {
        std::optional<Token> NextToken =
            utils::lexer::findNextTokenSkippingComments(
                SrcBegin, *Result.SourceManager, Result.Context->getLangOpts());
        if (NextToken) {
          //SrcBegin = NextToken->getEndLoc();
          SrcBegin = NextToken->getLocation().getLocWithOffset(NextToken->getLength() + 1);
        } else {
          // error find next token;
          break;
      }
  }

    //  auto RetLocStr = RetLoc.printToString(*Result.SourceManager);
    //  auto inline_token = utils::lexer::findNextAnyTokenKind(RetLoc, *Result.SourceManager, getLangOpts(), tok::kw_inline, tok::kw_inline);
    //
    // std::string msg = std::string("function %0 'inline' specifier is redundant: ")  + token->getName();
    diag(MatchedDecl->getLocation(),
         std::string("function %0 'inline' specifier is redundant: ") +
             " is inline " + is_inline + ", is static = " + is_static +
             "  value=" + value)
        << MatchedDecl;
    //  if (token.has_value()) {
    //    d <<
    //      << FixItHint::CreateRemoval(SourceRange(token->getLocation()));
    //  }
//    diag(RetLoc, std::string("Remove 'inline' specifier: ") + SrcText.str(),
//         DiagnosticIDs::Note);
  }
}

} // namespace clang::tidy::readability
