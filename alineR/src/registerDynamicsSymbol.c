// Register native routines

#include <R.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>

// Was "R_init_markovchain" (copied from another package), which R never
// calls for alineR, so no routine was registered.
extern SEXP exchange(SEXP s, SEXP coeff, SEXP skpen);

static const R_CallMethodDef CallEntries[] = {
    {"exchange", (DL_FUNC) &exchange, 3},
    {NULL, NULL, 0}
};

void R_init_alineR(DllInfo *dll) {
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
