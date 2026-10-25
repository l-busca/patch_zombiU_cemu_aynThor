# Correctif experimental pour Cemu Android Sapphire 0.5.2 et ZombiU EUR v0.
# Resout Rabbids_cafe_f.rpl dans code/ avec la casse du fichier constate.
# Saute uniquement la construction inutilisee d'un nom .elf et sa liberation,
# car OSDynLoad_AddNofifyCallback n'est pas implemente dans ce fork.
# Les vrais resultats Acquire, FindExport et initialisation sont conserves.
[ZombiU_RPLFix_EUR_v0_v1]
moduleMatches = 0xa4959fe1
.origin = codecave
.callback entry zfix_entry

zfix_entry:
stwu r1, -0x80(r1)
mflr r0
stw r0, 0x7c(r1)
lis r3, zfix_ready@ha
addi r3, r3, zfix_ready@l
crxor 6, 6, 6
bla import.coreinit.OSReport
lwz r0, 0x7c(r1)
mtlr r0
addi r1, r1, 0x80
blr

zfix_acquire:
stwu r1, -0x80(r1)
mflr r0
stw r0, 0x7c(r1)
stw r3, 0x40(r1)
stw r4, 0x44(r1)
bl zfix_select_name
stw r3, 0x48(r1)
mr r5, r3
lwz r4, 0x40(r1)
lis r3, zfix_acquire_begin@ha
addi r3, r3, zfix_acquire_begin@l
crxor 6, 6, 6
bla import.coreinit.OSReport
lwz r3, 0x48(r1)
lwz r4, 0x44(r1)
bla import.coreinit.OSDynLoad_Acquire
stw r3, 0x50(r1)
mr r4, r3
lwz r5, 0x44(r1)
lwz r5, 0(r5)
lis r3, zfix_acquire_end@ha
addi r3, r3, zfix_acquire_end@l
crxor 6, 6, 6
bla import.coreinit.OSReport
lwz r3, 0x50(r1)
lwz r0, 0x7c(r1)
mtlr r0
addi r1, r1, 0x80
blr

# r3 = chemin original. Retourne le nom corrige uniquement pour ce RPL.
zfix_select_name:
mr r8, r3
mr r9, r3
zfix_name_scan:
lbz r10, 0(r9)
cmpwi r10, 0
beq zfix_name_compare
addi r9, r9, 1
cmpwi r10, 0x2f
beq zfix_name_separator
cmpwi r10, 0x5c
bne zfix_name_scan
zfix_name_separator:
mr r8, r9
b zfix_name_scan
zfix_name_compare:
lis r9, zfix_expected_name@ha
addi r9, r9, zfix_expected_name@l
zfix_name_byte:
lbz r10, 0(r8)
lbz r11, 0(r9)
cmplwi r10, 0x41
blt zfix_name_folded
cmplwi r10, 0x5a
bgt zfix_name_folded
ori r10, r10, 0x20
zfix_name_folded:
cmpw r10, r11
bne zfix_name_done
cmpwi r11, 0
beq zfix_name_match
addi r8, r8, 1
addi r9, r9, 1
b zfix_name_byte
zfix_name_match:
lis r3, zfix_code_name@ha
addi r3, r3, zfix_code_name@l
zfix_name_done:
blr

zfix_export:
stwu r1, -0x80(r1)
mflr r0
stw r0, 0x7c(r1)
stw r3, 0x40(r1)
stw r4, 0x44(r1)
stw r5, 0x48(r1)
stw r6, 0x4c(r1)
mr r4, r3
lis r3, zfix_export_begin@ha
addi r3, r3, zfix_export_begin@l
crxor 6, 6, 6
bla import.coreinit.OSReport
lwz r3, 0x40(r1)
lwz r4, 0x44(r1)
lwz r5, 0x48(r1)
lwz r6, 0x4c(r1)
bla import.coreinit.OSDynLoad_FindExport
stw r3, 0x50(r1)
mr r4, r3
lwz r5, 0x4c(r1)
lwz r5, 0(r5)
lis r3, zfix_export_end@ha
addi r3, r3, zfix_export_end@l
crxor 6, 6, 6
bla import.coreinit.OSReport
lwz r3, 0x50(r1)
lwz r0, 0x7c(r1)
mtlr r0
addi r1, r1, 0x80
blr

zfix_library_boot:
stwu r1, -0x80(r1)
mflr r0
stw r0, 0x7c(r1)
stw r3, 0x40(r1)
stw r4, 0x44(r1)
mfctr r4
stw r4, 0x54(r1)
lis r3, zfix_boot_begin@ha
addi r3, r3, zfix_boot_begin@l
crxor 6, 6, 6
bla import.coreinit.OSReport
lwz r3, 0x40(r1)
lwz r4, 0x44(r1)
lwz r0, 0x54(r1)
mtctr r0
bctrl
stw r3, 0x50(r1)
mr r4, r3
lis r3, zfix_boot_end@ha
addi r3, r3, zfix_boot_end@l
crxor 6, 6, 6
bla import.coreinit.OSReport
lwz r3, 0x50(r1)
lwz r0, 0x7c(r1)
mtlr r0
addi r1, r1, 0x80
blr

zfix_type_lookup:
stwu r1, -0x80(r1)
mflr r0
stw r0, 0x7c(r1)
stw r3, 0x40(r1)
bl reloc(0x0241126c)
stw r3, 0x50(r1)
lwz r6, 0x40(r1)
lwz r4, 0x30(r6)
lwz r5, 0x34(r6)
cmpwi r4, 0
bne zfix_type_has_name
lis r4, zfix_null@ha
addi r4, r4, zfix_null@l
zfix_type_has_name:
lis r3, zfix_type_result@ha
addi r3, r3, zfix_type_result@l
crxor 6, 6, 6
bla import.coreinit.OSReport
lwz r3, 0x50(r1)
lwz r0, 0x7c(r1)
mtlr r0
addi r1, r1, 0x80
blr

# Appels originaux verifies dans le RPX fourni :
# 028c2ed0 : 481d3991 bl OSDynLoad_Acquire
# 028c2f60 : 481d3929 bl OSDynLoad_FindExport
# 028c2f7c : 4e800421 bctrl (fonction exportee par la bibliotheque)
# 023084a8 : 48108dc5 bl 0241126c (recherche du type de l'univers)
0x028c2ed0 = bl zfix_acquire
# Apres Acquire reussi, le tampon de notification est non initialise.
# La plage 028c2edc..028c2f34 ne produit qu'un nom .elf local jamais utilise.
# Reprend avant le stockage du handle et la vraie recherche de fonction.
0x028c2edc = b reloc(0x028c2f38)
0x028c2f60 = bl zfix_export
0x028c2f7c = bl zfix_library_boot
0x023084a8 = bl zfix_type_lookup

zfix_ready:
.byte 90, 70, 73, 88, 118, 49, 32, 82, 69, 65, 68, 89, 32, 109, 111, 100, 117, 108, 101, 61, 97, 52, 57, 53, 57, 102, 101, 49, 32, 102, 105, 120, 61, 99, 111, 100, 101, 95, 82, 80, 76, 95, 110, 97, 109, 101, 44, 117, 110, 117, 115, 101, 100, 95, 110, 111, 116, 105, 102, 121, 95, 102, 105, 108, 101, 110, 97, 109, 101, 10, 0

zfix_acquire_begin:
.byte 90, 70, 73, 88, 118, 49, 32, 65, 67, 81, 85, 73, 82, 69, 32, 114, 101, 113, 117, 101, 115, 116, 101, 100, 61, 37, 115, 32, 115, 101, 108, 101, 99, 116, 101, 100, 61, 37, 115, 10, 0

zfix_acquire_end:
.byte 90, 70, 73, 88, 118, 49, 32, 65, 67, 81, 85, 73, 82, 69, 32, 114, 101, 115, 117, 108, 116, 61, 37, 48, 56, 88, 32, 104, 97, 110, 100, 108, 101, 61, 37, 48, 56, 88, 10, 0

zfix_export_begin:
.byte 90, 70, 73, 88, 118, 49, 32, 69, 88, 80, 79, 82, 84, 32, 104, 97, 110, 100, 108, 101, 61, 37, 48, 56, 88, 32, 110, 97, 109, 101, 61, 37, 115, 10, 0

zfix_export_end:
.byte 90, 70, 73, 88, 118, 49, 32, 69, 88, 80, 79, 82, 84, 32, 114, 101, 115, 117, 108, 116, 61, 37, 48, 56, 88, 32, 97, 100, 100, 114, 101, 115, 115, 61, 37, 48, 56, 88, 10, 0

zfix_boot_begin:
.byte 90, 70, 73, 88, 118, 49, 32, 66, 79, 79, 84, 32, 102, 117, 110, 99, 116, 105, 111, 110, 61, 37, 48, 56, 88, 10, 0

zfix_boot_end:
.byte 90, 70, 73, 88, 118, 49, 32, 66, 79, 79, 84, 32, 114, 101, 115, 117, 108, 116, 61, 37, 48, 56, 88, 10, 0

zfix_type_result:
.byte 90, 70, 73, 88, 118, 49, 32, 84, 89, 80, 69, 32, 110, 97, 109, 101, 61, 37, 115, 32, 100, 101, 115, 99, 114, 105, 112, 116, 111, 114, 61, 37, 48, 56, 88, 32, 111, 98, 106, 101, 99, 116, 61, 37, 48, 56, 88, 10, 0

zfix_null:
.byte 40, 110, 117, 108, 108, 41, 0


zfix_expected_name:
.byte 114, 97, 98, 98, 105, 100, 115, 95, 99, 97, 102, 101, 95, 102, 46, 114, 112, 108, 0

zfix_code_name:
.byte 82, 97, 98, 98, 105, 100, 115, 95, 99, 97, 102, 101, 95, 102, 46, 114, 112, 108, 0
