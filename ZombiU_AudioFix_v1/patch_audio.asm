# Correctif experimental pour Cemu Android SapphireRhodonite 0.5.2 et ZombiU EUR v0.
# MIXInitDeviceControl du fork copie MixControl octet par octet dans des sint16
# natifs : pan 91 devient 23296 et le mixeur lit hors de ses tables (SIGSEGV).
# Les appels du jeu recoivent ici une copie dont chaque champ 16 bits est
# inverse, ce qui redonne les vraies valeurs apres la copie faite par Cemu.
# Le Cemu officiel a corrige la fonction elle-meme (commit c2d428e).
# La structure d'origine du jeu n'est pas modifiee. Les resultats sont reels.
[ZombiU_AudioFix_EUR_v0_v1]
moduleMatches = 0xa4959fe1
.origin = codecave
.callback entry zaud_entry

zaud_entry:
stwu r1, -0x20(r1)
mflr r0
stw r0, 0x24(r1)
lis r3, zaud_ready@ha
addi r3, r3, zaud_ready@l
crxor 6, 6, 6
bla import.coreinit.OSReport
lwz r0, 0x24(r1)
mtlr r0
addi r1, r1, 0x20
blr

# Meme ABI que MIXInitDeviceControl :
# r3 voix, r4 peripherique, r5 index, r6 MixControl* (14 octets), r7 mode.
zaud_mixctl:
stwu r1, -0x40(r1)
mflr r0
stw r0, 0x44(r1)
stw r3, 0x20(r1)
stw r4, 0x24(r1)
stw r5, 0x28(r1)
stw r6, 0x2c(r1)
stw r7, 0x30(r1)
# Copie des 7 champs 16 bits vers r1+0x10 en inversant leurs deux octets.
li r0, 7
mtctr r0
addi r9, r6, -2
addi r10, r1, 0x0e
zaud_swap_loop:
lbz r11, 2(r9)
lbz r12, 3(r9)
stb r12, 2(r10)
stb r11, 3(r10)
addi r9, r9, 2
addi r10, r10, 2
bdnz zaud_swap_loop
# Journal des 12 premiers appels avec les valeurs lues comme sur Wii U.
lis r11, zaud_count@ha
addi r11, r11, zaud_count@l
lwz r12, 0(r11)
cmplwi r12, 12
bge zaud_call
addi r12, r12, 1
stw r12, 0(r11)
lwz r9, 0x2c(r1)
lha r7, 6(r9)
lha r8, 8(r9)
lha r9, 10(r9)
lwz r4, 0x20(r1)
lwz r5, 0x24(r1)
lwz r6, 0x28(r1)
lwz r10, 0x30(r1)
lis r3, zaud_fmt@ha
addi r3, r3, zaud_fmt@l
crxor 6, 6, 6
bla import.coreinit.OSReport
zaud_call:
lwz r3, 0x20(r1)
lwz r4, 0x24(r1)
lwz r5, 0x28(r1)
addi r6, r1, 0x10
lwz r7, 0x30(r1)
bla import.snd_user.MIXInitDeviceControl
lwz r0, 0x44(r1)
mtlr r0
addi r1, r1, 0x40
blr

# Appels originaux verifies dans le RPX fourni :
# 0229aea4 : 487fdae5 bl MIXInitDeviceControl (TV, index 0, r6 = r1+0x28)
# 0229aebc : 487fdacd bl MIXInitDeviceControl (GamePad (DRC), index 0, r6 = r1+0x38)
# 0229aed4 : 487fdab5 bl MIXInitDeviceControl (GamePad (DRC), index 1, r6 = r1+0x46)
0x0229aea4 = bl zaud_mixctl
0x0229aebc = bl zaud_mixctl
0x0229aed4 = bl zaud_mixctl

zaud_count:
.int 0

zaud_ready:
.byte 90, 65, 85, 68, 118, 49, 32, 82, 69, 65, 68, 89, 32, 109, 111, 100, 117, 108, 101, 61, 97, 52, 57, 53, 57, 102, 101, 49, 32, 102, 105, 120, 61, 77, 73, 88, 73, 110, 105, 116, 68, 101, 118, 105, 99, 101, 67, 111, 110, 116, 114, 111, 108, 95, 98, 121, 116, 101, 115, 119, 97, 112, 32, 115, 105, 116, 101, 115, 61, 48, 50, 50, 57, 97, 101, 97, 52, 44, 48, 50, 50, 57, 97, 101, 98, 99, 44, 48, 50, 50, 57, 97, 101, 100, 52, 10, 0

zaud_fmt:
.byte 90, 65, 85, 68, 118, 49, 32, 77, 73, 88, 67, 84, 76, 32, 118, 111, 105, 99, 101, 61, 37, 48, 56, 88, 32, 100, 101, 118, 105, 99, 101, 61, 37, 100, 32, 105, 110, 100, 101, 120, 61, 37, 100, 32, 112, 97, 110, 61, 37, 100, 32, 115, 112, 97, 110, 61, 37, 100, 32, 102, 97, 100, 101, 114, 61, 37, 100, 32, 109, 111, 100, 101, 61, 37, 88, 10, 0
