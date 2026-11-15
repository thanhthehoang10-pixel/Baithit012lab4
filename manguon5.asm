# Ma nguon 5 – phan bac dien nang
.data
prompt: .asciiz “Nhap dien nang (kWh): “
msg:    .asciiz “Bac: “
nl:     .asciiz “\n”
 
.text
.globl main
main:
  li  $v0, 4
  la  $a0, prompt
  syscall
  li  $v0, 5            # doc kWh, ket qua o $v0
  syscall
  add $s0, $v0, $zero   # $s0 = dien nang (kWh)
  # >>> xac dinh bac (1..4) theo Bang 6, dat vao $s1
  # >>> in “Bac: “, roi $s1, roi xuong dong
  li  $v0, 10
  syscall