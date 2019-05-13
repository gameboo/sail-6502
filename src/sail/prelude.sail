//------------------------------------------------------------------------------
// (c) Alexandre Joannou, University of Cambridge
//------------------------------------------------------------------------------

default Order dec

$include <vector_dec.sail>

val  _reg_deref = "reg_deref" : forall ('a : Type). register('a) -> 'a
val  concat_str = "concat_str": (string, string) -> string
val bit_hex_str = "bit_hex_str" : forall 'n. bits('n) -> string
val bit_bin_str = "bit_bin_str" : forall 'n. bits('n) -> string
