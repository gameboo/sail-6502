//------------------------------------------------------------------------------
// (c) Alexandre Joannou, University of Cambridge
//------------------------------------------------------------------------------

register A : bits(8) // Accumulator register
register X : bits(8) // X index register
register Y : bits(8) // Y index register
register S : bits(8) // stack pointer register

// Program Counter
bitfield PC_t : vector(16, dec, bit) = {
  H : 15 .. 8, // high order byte of the Program Counter
  L :  7 .. 0  // low order byte of the Program Counter
}
register PC : PC_t // Program Counter register

// STATUS
bitfield STATUS_t : vector(8, dec, bit) = {
  N : 7, // Negative flag
  V : 6, // oVerflow flag
  r : 5, // reserved (set to 1)
  B : 4, // Break flag
  D : 3, // Decimal mode flag
  I : 2, // Interrupt ReQuest disable flag
  Z : 1, // Zero flag
  C : 0  // Carry flag
}
register STATUS : STATUS_t // STATUS register

// interrupts
bitfield INT_t : vector(3, dec, bit) = {
  IRQ   : 2, // interrupt request
  NMI   : 1, // non maskable interrupt
  RESET : 0  // reset
}
register INT : INT_t // Interrupt sources

// types
type ByteStream = list(bits(8)) // Byte stream (variable length instructions)
register instrNbr : nat

// Initialisation
val Init : bits(16) -> unit
function Init (initPC) = {
  A           = 0x00;
  X           = 0x00;
  Y           = 0x00;
  S           = 0x00;
  PC          = Mk_PC_t(initPC);
  STATUS      = Mk_STATUS_t(0x00);
  STATUS->r() = 0b1;
  INT         = Mk_INT_t(0b000);
  instrNbr    = 0
}

// debug
val cpuStateStr : unit -> string
function cpuStateStr () = {
  concat_str("A = 0x", concat_str(bit_hex_str(A),
  concat_str(", S = 0x", concat_str(bit_hex_str(S),
  concat_str("\nX = 0x", concat_str(bit_hex_str(X),
  concat_str(", Y = 0x", concat_str(bit_hex_str(Y),
  concat_str("\nPC = [0x", concat_str(bit_hex_str(PC.H()),
  concat_str(":0x", concat_str(bit_hex_str(PC.L()), concat_str("]",
  concat_str("\nSTATUS = <", concat_str(bit_bin_str(STATUS.bits()), concat_str(">",
  concat_str("\nINT{IRQ:", concat_str(bit_bin_str(INT.IRQ()),
  concat_str(",NMI:", concat_str(bit_bin_str(INT.NMI()),
  concat_str(",RESET:", bit_bin_str(INT.RESET())
  )))))))))))))))))))))
}
