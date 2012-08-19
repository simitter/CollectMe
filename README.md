## Introduction
Collect Me keeps track of your mounts and titles in the game and can show you your missing mounts and titles with additional information on where to get them. It can also summon companions and mounts randomly with a priority list.

## Basic Features

 * Ignore List for mount and titles
 * Filters for mounts and titles
 * Source-information of mounts and titles
 * 3D model preview of mounts
 * Zone- and priority-based random mount-summoning
 * Priority-based random pet-summoning
 * Auto-summoning of companions on moving
 * WowAce profile support

## Usage
Collect Me creates two macros for mount and companion summoning. All other features and settin can be accessed on the main window.

## Slash Commands
 * /collectme or /cm will bring up the main window
 * /cm randomcompanion or /cm rc will summon a random companion bases on your priority list
 * /cm randommount or /cm rm will summon a random companion bases on your priority list
 * /cm options will open the profile settings
 * You also can use the "Collect Me" button in the Blizzard Mount Tab to open the addon

## The Main Window
When you start the Main Window the add-on will automatically build a mount, pet, title list based on your faction, class. By hovering over a mount or title with the mouse you will receive additional information on where to get it in a tooltip.

### Ignore List
You can add an item to the ignore list by Ctrl + right-clicking on them, if for any reason you don't want them or you have no way of obtaining them.

### Filters
In addition to the Ignore List, you can add pre-configured filters. Those filters will hide mounts and titles from the missing list. This will allow you to keep the list small to bring in some general survey. By combining the filters and the ignore list you should have a good compromise of speed and detail.

#### Priority-based summoning
The add-on can summon a random companion or mount by using the macros the addon creates.

You can manage the priority lists in the main window. There you'll find a list of every companion and mount you have and you can assign them priorities between 0 and 10.
 * 0: If you set a companion or mount to 0 it will never be summoned (this is the default setting).
 * 1-10: The higher the priority, the higher the chance that the companion or mount will be summoned.

NOTE: The chance depends not only on the companion priority but on all priorities of all companions.
##### Example
 * Companion A) 5
 * Companion B) 0
 * Companion C) 10
 * Companion D) 10

That gives A a chance of 20% to be summoned. B will never be summoned (0 %). C and D have both a chance of 40% to be summoned.

##### Zone priorities for mounts
Collect Me tries to autodetect wich mount would be best for the current zone (example vashj'r, non flyable zones) and build the pool based on this suggestion and your priorities and than randomly choose one. Let's take a look to AQ40 for an example. You have 2 Qiraj mounts and 10 normal ground mounts and you are in AQ40.
Both Qiraj mounts have a priority of 0. In this case Collect Me would summon a random ground mount. If one Qiraj mount would have priority Collect Me would always take the Qiraj mount. If both Qiraj mounts would have a priority, Collect Me would randomly choose between those two mounts based on your priority.
Zone Mounts always weigh stronger than non zone mounts. Currently you can not influence that, but in a future release some options may be added.

## 3D Model Preview
* By left-clicking on a mount in the main window you can bring up a window with a 3d preview of the mount.
* By Ctrl + left-clicking on a mount or companion in chat you can view a 3d preview of it.

## Reporting issues and feature requests
 * If you have a feature request of a bug you can open a ticket on curseforge http://wow.curseforge.com/addons/collect_me/tickets/ or github https://github.com/Tschebel/CollectMe/issues
 * For general questions you can use the comments on curse.

## Translation and help with that
 * Collect Me only comes in english and partial german but fully supports WowAce as translation library.
 * If you want to help and submit translations in your language you can do so by using GitHub https://github.com/Tschebel/CollectMe or if you aren't familiar with GitHub you can send an email.

## Additional Information
 * If you have a mount or title which the add-on doesn't have in its database, you will receive a message in your chat frame. Please leave a comment or a ticket on the addon page if this is the case.

Thanks
  * warcraftpets.com
  * warcraftmounts.com
  * wowhead.com
  * wowace.com
