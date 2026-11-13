// Copyright (c) 2015 by Sean Downey
// Authors: Sean Downey (sean@codexdata.com) and Guowei Sun (gwsun@umd.edu)
// This software is distributed under GPL-3.
// Includes modified C++ code originally developed by Greg Kondrak (c) 2000

#include "glob.h"
#include "Word.h"
#include "wagner.h"

#ifndef R_NO_REMAP
#define R_NO_REMAP
#endif
#include <R.h>
#include <Rinternals.h>

// Number of feature weights passed from R (Syllabic ... Round).
static const int NFEAT = 12;

// Modifier codes understood by Word::modify().
static const char *MODIFIERS = "ACDFHLNPSVX";

// Validate an encoded ALINE word before handing it to the C++ code, so that
// bad input produces an R error rather than a buffer overflow or abort().
static void check_word(const char *w, int which)
{
    size_t n = strlen(w);
    if (n == 0)
        Rf_error("word %d is empty after encoding (all characters invalid?)", which);
    if (n >= (size_t) ELEN)
        Rf_error("word %d is too long: %d encoded characters (maximum is %d)",
                 which, (int) n, ELEN - 1);
    if (w[0] < 'a' || w[0] > 'z')
        Rf_error("word %d must start with a segment (a-z), not '%c'", which, w[0]);
    for (size_t i = 1; i < n; i++) {
        char c = w[i];
        if ((c < 'a' || c > 'z') && (c == '\0' || strchr(MODIFIERS, c) == NULL))
            Rf_error("word %d contains invalid encoded character '%c'", which, c);
    }
}

extern "C" {

SEXP exchange(SEXP s, SEXP coeff, SEXP skpen)
{
    if (TYPEOF(s) != STRSXP || XLENGTH(s) != 2)
        Rf_error("'s' must be a character vector of length 2");
    if (STRING_ELT(s, 0) == NA_STRING || STRING_ELT(s, 1) == NA_STRING)
        Rf_error("NA words are not allowed");
    if (TYPEOF(coeff) != INTSXP || XLENGTH(coeff) != NFEAT)
        Rf_error("feature weights must be an integer vector of length %d", NFEAT);
    if (TYPEOF(skpen) != INTSXP || XLENGTH(skpen) != 1)
        Rf_error("skip penalty must be a single integer");
    for (int i = 0; i < NFEAT; i++)
        if (INTEGER(coeff)[i] == NA_INTEGER)
            Rf_error("feature weights must not be NA");
    if (INTEGER(skpen)[0] == NA_INTEGER)
        Rf_error("skip penalty must not be NA");

    const char *s1 = CHAR(STRING_ELT(s, 0));
    const char *s2 = CHAR(STRING_ELT(s, 1));
    check_word(s1, 1);
    check_word(s2, 2);

    int vec[NFEAT];
    for (int i = 0; i < NFEAT; i++) vec[i] = INTEGER(coeff)[i];
    int SkipPen = INTEGER(skpen)[0];

    int score = 0;
    char aback1[ABACK];
    char aback2[ABACK];
    aback1[0] = '\0';
    aback2[0] = '\0';

    Word::applyRedundancyRules();   // idempotent
    // Automatic storage: nothing leaks if an R error is raised below.
    Word w1(s1);
    Word w2(s2);
    align(&w1, &w2, &score, aback1, aback2, vec, SkipPen);

    SEXP result = PROTECT(Rf_allocVector(VECSXP, 3));
    SET_VECTOR_ELT(result, 0, Rf_mkString(aback1));
    SET_VECTOR_ELT(result, 1, Rf_mkString(aback2));
    SET_VECTOR_ELT(result, 2, Rf_ScalarReal((double) score));
    UNPROTECT(1);
    return result;
}

}

float gP::ScoreMargin = 1.0;
int gP::MaxScore = conv(35);
int gP::MaxCmpScore = conv(45);
int gP::VwlDecr = conv(10);
