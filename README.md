# gta-v-language-changer

An open-source language changer for *Grand Theft Auto V* by Rockstar Games.

This language changer was originally created by Rockstar Games for the PC release of *Grand Theft Auto V* but was never publicly released.

This repo includes the required NSIS version that was used by Rockstar Games.

It was discovered in the 2023 source code leak at the following path:  
`X:\gta5\src\dev_ng\extra\pc_language_switcher\Builds`

## Repository Branches

There are **two versions** of the language changer available in this repository:

### Main Branch
[main branch](https://github.com/FranklinClintonDev/gta-v-language-changer/tree/main)

Contains the **unedited source code** from the leak.

- [Download Language Changer Builds (Compiled by Rockstar Games)](https://github.com/FranklinClintonDev/gta-v-language-changer/releases/tag/Main)
- [Download Language Changer Source Code](https://github.com/FranklinClintonDev/gta-v-language-changer/archive/refs/heads/main.zip)

---

### Cracked Branch
[cracked branch](https://github.com/FranklinClintonDev/gta-v-language-changer/tree/cracked)

- This version was made by [greensci](https://github.com/greensci)

This branch contains modified code with the following changes:

- `vSteamLoad` is forced to `1` (Steam version only).  
  Other language changer builds are not compatible with retail copies of GTA V.
- The launcher now starts the game using `GTAVLauncher.exe` instead of `PlayGTAV.exe`.

  This change was made because later versions of **GTA V Legacy** require a batch file to disable BattlEye before launching.  
  `GTAVLauncher.exe` is a batch script converted to an executable in my GTA V crack.  
  `PlayGTAV.exe` cannot be used because it is part of the Goldberg Social Club Emulator.
- The launcher icon has been changed.

- [Download Language Changer (Cracked)](https://github.com/FranklinClintonDev/gta-v-language-changer/releases/tag/Cracked)
- [Download Language Changer Source Code (Cracked)](https://github.com/FranklinClintonDev/gta-v-language-changer/archive/refs/heads/cracked.zip)

## Credits

- Original Language Changer by [Rockstar Games](https://www.rockstargames.com/).
- Cracked Version made by [greensci](https://github.com/greensci).
