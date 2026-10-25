ZombiU (EUR) sur Cemu Android 0.5.2 - correctifs experimentaux
==============================================================

FRANCAIS
--------
Ces deux packs permettent a ZombiU EUR de demarrer et de se jouer sur
Cemu Android SapphireRhodonite 0.5.2 (teste sur AYN Thor).

- ZombiU_RPLFix_v1 : le jeu charge sa bibliotheque de scripts avec un chemin
  que ce Cemu ne resout pas. Sans ce pack : plantage au demarrage.
- ZombiU_AudioFix_v1 : le mixeur audio de ce Cemu lit les volumes et
  panoramiques du jeu avec les octets inverses. Sans ce pack : plantage
  juste apres l'intro.

Le Cemu officiel sur PC a deja corrige ces bugs (juin-juillet 2026).
La version Android 0.5.2 ne contient pas encore ces correctifs.

Prerequis
- Cemu Android SapphireRhodonite 0.5.2.
- ZombiU EUR, ID 000500001010EF00, version disque sans mise a jour (v0).
  Avec une autre version ou region, les packs ne s'activent pas.

Installation sans PC
1. Dans Cemu, menu principal : "Open Cemu folder" (ouvrir le dossier Cemu).
   L'application Fichiers s'ouvre dans le dossier de Cemu.
2. Copie les dossiers ZombiU_RPLFix_v1 et ZombiU_AudioFix_v1 dans graphicPacks.
3. Relance Cemu. Les deux packs sont actifs par defaut
   (Graphic packs > ZombiU > Workarounds).

Avec un PC et ADB
  adb push ZombiU_RPLFix_v1 /sdcard/Android/data/info.cemu.cemu/files/graphicPacks/
  adb push ZombiU_AudioFix_v1 /sdcard/Android/data/info.cemu.cemu/files/graphicPacks/

Important
- Correctif experimental, teste sur une seule console.
- Si ton Cemu Android est mis a jour avec le correctif audio officiel
  (commit Cemu c2d428e), retire ZombiU_AudioFix_v1 : il fausserait le son.
- Les effets de reverberation et d'echo restent absents
  (non implementes dans ce Cemu).
- Le son du GamePad n'est pas mixe par ce Cemu ; le son TV fonctionne.


ENGLISH
-------
These two graphic packs let ZombiU EUR boot and play on
Cemu Android SapphireRhodonite 0.5.2 (tested on an AYN Thor).

- ZombiU_RPLFix_v1: the game loads its script library through a path this
  Cemu build cannot resolve. Without it: crash at startup.
- ZombiU_AudioFix_v1: this Cemu build reads the game's MIX volume/pan values
  with swapped bytes. Without it: crash right after the intro.

Official Cemu (PC) already fixed these bugs (June-July 2026).
Cemu Android 0.5.2 does not include those fixes yet.

Requirements
- Cemu Android SapphireRhodonite 0.5.2.
- ZombiU EUR, title ID 000500001010EF00, disc version without update (v0).
  Other versions or regions: the packs simply do not activate.

Install without a PC
1. In Cemu's main menu, tap "Open Cemu folder".
   The Files app opens Cemu's folder.
2. Copy the ZombiU_RPLFix_v1 and ZombiU_AudioFix_v1 folders into graphicPacks.
3. Restart Cemu. Both packs are enabled by default
   (Graphic packs > ZombiU > Workarounds).

With a PC and ADB
  adb push ZombiU_RPLFix_v1 /sdcard/Android/data/info.cemu.cemu/files/graphicPacks/
  adb push ZombiU_AudioFix_v1 /sdcard/Android/data/info.cemu.cemu/files/graphicPacks/

Important
- Experimental, tested on a single device.
- If your Cemu Android build gets the official audio fix (Cemu commit
  c2d428e), remove ZombiU_AudioFix_v1: it would distort audio again.
- Reverb and echo effects are missing (not implemented in this Cemu build).
- GamePad audio is not mixed by this Cemu build; TV audio works.
