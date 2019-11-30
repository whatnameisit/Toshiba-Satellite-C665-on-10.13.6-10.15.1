# Toshiba Satellite C665 on High Sierra 10.13.6
HackinToshiba
## Issues
1. The Brightness control does not work. Slider is available in PrefPane, but it does not affect the actual brightness. The display icon item recognizes the display as external, so it appears on the menu bar unless manually removed.
2. The battery is dead. The laptop cannot boot with the battery plugged in. I have ordered a refilled battery and am waiting for its arrival.
3. AppleALC delays the boot time by 180 seconds. This is supposed to be related to unsupported HDMI sound codecs. Current workaround is to delete it and install VoodooHDA.kext.
4. Intel HD 2000 is factory disabled, so it cannot be used to work in the headless mode. Forcibly trying to turn it on by returning 0x0F with _SB.PCI0.GFX0._STA did not work. The device does not exist.
5. The touchpad buttons do not work with VoodooPS2Controller. I have resorted to using AppleSmartTouchpad.kext at the moment. If the battery status is working with the replaced battery, I may return to the Voodoo package because then I can enable tab-to-click and two-touch-right-click options and because I am more familiar with its layout and configuration.
6. ~~Configuring OpenCore is very difficult for me. If possible, I would like to use it so I can inject appropriate UEFI settings to also boot Windows 10 in UEFI mode.~~ First, install Windows 10 on MBR disk: clean the disk, convert to MBR, create two partitions, and install Windows 10 on the second partition. Second, convert the disk with mbr2gpt. Third, install macOS High Sierra on the first partition. Fourth, configure GUI.
7. ~~(Related to 6) I cannot install Windows 10. I am inexperienced with hybrid-GPT-MBR, booting MBR on GPT, making secondary bootloaders such as Grub, etc. Taking out the CD-ROM and replacing it with another SSD guard is unnecessary and ofc requires money.~~ See 6.
8. ~~I have not tested the SD card slot yet, or the headset, or the mic input.~~ It seems that the earphone and the mic does not work with VoodooHDA.kext. The SD card is connected via USB and works well with USBPorts.kext.
9. Lid-sleep and -wake does not seem to work. I think I need to configure the ACPI LID0 device. NUMLOCK does not save its last setting. AppleSmartTouchpad.kext boots with it turned off, and VoodooPS2Controller.kext does not have the NUMLOCK feature.
10. Continuity features do not seem to be working. I have injected BT4LEContinuityFixup.kext via Clover which still does not enable Handoff.
11. Cosmetic injection properties such as PCI information ~~and RAM serial numbers~~ may be applied later.
12. _DSM at PEGP injects the properties to both the graphics and sound card. Also an issue with Clover: PEGP@0 is a graphics device, and PEGP@1 is a sound card. _DSM converted to Devices/Properties/Pci~(0) should be injected to PEGP@0, but it is not and therefore cannot be booted. Devices/Properties/PCI~(1) works, and as with SSDT the properties are both injected to PEGP@0 and @1. Devices/AddProperties, however, works only if there is a blank PCI~(1) at Devices/Properties, and by works I mean all properties are separated between @0 and @1. Some properties are not properly injected via AddProperties. Removing them seemed to have smoothened the graphics and also blinking problem at the start of acceleration.
## Replacements
1. HDD to SSD.
2. AR9285 to BCM94360HMB with little masking. AR9285 works by injecting a compatible id via config.plist/Devices/Properties/Pci(AR9285), but does not allow AirDrop or other continuity features, plus the incompatible bluetooth (outdated firmware uploader).
3. +1 DDR3 4G RAM to original 4G. The printed frequency on the stock RAM is 1066 on the front side, and on the back it says 10600, and in Windows it is 1333, so 10600 lol.
## Other things
1. If you want, you may install and apply appropriate patches to enable Mojave or Catalina. Catalina is as slow as a sloth, but Mojave seems good. Use respective dosdude1's patcher. I recommend installing vanilla and then applying the patch. Apply "disable dGPU" patches and -no_compat_check boot flag in config.plist before trying to boot installer/installed volume. Legacy video patch is all that's needed from the patcher. For the "disable dGPU" patch, see https://github.com/RehabMan/OS-X-Clover-Laptop-Config
## Acknoledgment
Apple for macOS

The Clover Development team

The Acidanthera team

Many other developers and patching guides I have yet to mention
