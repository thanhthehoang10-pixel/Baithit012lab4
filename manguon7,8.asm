.data
m1:      .asciiz "Thang "
m2:      .asciiz ": "
mt:      .asciiz "Tong: "
mm:      .asciiz "Thang cao nhat: "
lp:      .asciiz " ("
rp:      .asciiz ")"
nl:      .asciiz "\n"
reading: .word 1000, 1095, 1205, 1345, 1510, 1715, 1955
         .word 2210, 2440, 2625, 2775, 2895, 2995
usage:   .space 48
# Ma nguon 8 – dien nang tung thang

.text
.globl main
main:
  la   $s0, reading      # $s0 = dia ch? n?n reading
  la   $s1, usage        # $s1 = dia ch? n?n usage
  addi $s2, $zero, 0     # i = 0
  addi $s3, $zero, 12    # n = 12 thang

  # Kh?i t?o các bi?n tính toán t?ng và max
  addi $t7, $zero, 0     # $t7 = Tong (l?u t?ng ?i?n n?ng)
  addi $t8, $zero, 0     # $t8 = Max value (giá tr? cao nh?t)
  addi $t9, $zero, 1     # $t9 = Thang cao nhat (tháng ch?a giá tr? max)

Loop:
  # Thoát n?u i == n
  beq  $s2, $s3, Done

  # Tính ??a ch? reading[i] và l?y giá tr? reading[i], reading[i+1]
  sll  $t1, $s2, 2       # $t1 = i * 4 (offset)
  add  $t2, $s0, $t1     # $t2 = ??a ch? reading[i]
  lw   $t3, 0($t2)       # $t3 = reading[i]
  lw   $t4, 4($t2)       # $t4 = reading[i+1]

  # $t5 = $t4 - $t3 (dien nang thang i+1)
  sub  $t5, $t4, $t3     # $t5 = ?i?n n?ng tháng (i + 1)

  # Tính ??a ch? usage[i], l?u $t5 vào usage[i]
  add  $t6, $s1, $t1     # $t6 = ??a ch? usage[i]
  sw   $t5, 0($t6)       # l?u $t5 vào usage[i]

  # C?ng d?n vào t?ng ($t7 = $t7 + $t5)
  add  $t7, $t7, $t5

  # Ki?m tra n?u $t5 > $t8 thì c?p nh?t max
  slt  $at, $t8, $t5     # n?u max_value < $t5 thì $at = 1
  beq  $at, $zero, SkipUpdate
  move $t8, $t5          # c?p nh?t giá tr? max m?i
  addi $t9, $s2, 1       # c?p nh?t tháng t??ng ?ng (i + 1)
SkipUpdate:

  # In “Thang “, i+1, “: ", $t5, xuong dong
  li   $v0, 4
  la   $a0, m1
  syscall

  li   $v0, 1
  addi $a0, $s2, 1
  syscall

  li   $v0, 4
  la   $a0, m2
  syscall

  li   $v0, 1
  move $a0, $t5
  syscall

  li   $v0, 4
  la   $a0, nl
  syscall

  # i = i + 1, quay l?i Loop
  addi $s2, $s2, 1
  j    Loop

Done:
  # 1. In dòng Tong: 1995
  li   $v0, 4
  la   $a0, mt
  syscall

  li   $v0, 1
  move $a0, $t7
  syscall

  li   $v0, 4
  la   $a0, nl
  syscall

  # 2. In dòng Thang cao nhat: 7 (255)
  li   $v0, 4
  la   $a0, mm
  syscall

  li   $v0, 1
  move $a0, $t9
  syscall

  li   $v0, 4
  la   $a0, lp
  syscall

  li   $v0, 1
  move $a0, $t8
  syscall

  li   $v0, 4
  la   $a0, rp
  syscall

  li   $v0, 4
  la   $a0, nl
  syscall

  # K?t thúc ch??ng trình
  li   $v0, 10
  syscall