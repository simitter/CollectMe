## Introduction
Collect Me keeps track of your mounts, companions, titles, toys and followers in the game and can show you what mounts, companions, titles and toys you're missing with additional information on where to get them. It can also summon companions and mounts randomly from a user defined list.

## Basic Features
 * Ignore List
 * Filters
 * Zonebased filtering for mounts, companions, toys and followers
 * LDB Plugin for missing companions, mounts, toys and followers in current zone
 * Source-information
 * 3D model previews
 * Tooltip on wild battle pets for missing companions
 * Chat messages in pet battles for missing, higher quality and level companions
 * User- and Zone-defined random mount-summoning
 * Userdefinded random pet-summoning
 * Auto-summoning of companions when moving
 * Keybinding Support
 * WowAce profile support

## Usage
Collect Me creates two macros for mount and companion summoning. All other features and settings can be accessed on the main window.

## Macros
 * CollectMeRC
  * Left-Click: Summons a random companion
  * Right-Click: Dismisses the current companion
 * CollectMeRM
  * You can configure the behavior of this macro in the Random Mount Tab
 * If the macros are not created or updated accordingly you can try to run /cm macro to create them

## Slash Commands
 * /collectme or /cm will bring up the main window
 * /cm randomcompanion or /cm rc will summon a random companion bases on your defined set
 * /cm randommount or /cm rm will summon a random companion bases on your defined set
 * /cm options will open the profile settings
 * /cm macro will create or update the macro
 * You can also use the "Collect Me" button in the Blizzard Mount Tab to open the addon

## The Main Window
When you start the Main Window the add-on will automatically build a mount, companion, title list based on your faction, class. By hovering over a mount or title with the mouse you will receive additional information on where to get it in a tooltip.

### Ignore List
You can add an item to the ignore list by Ctrl + right-clicking on them, if for any reason you don't want them or you have no way of obtaining them.

### Filters
In addition to the Ignore List, you can add pre-configured filters. Those filters will hide mounts, titles and companions from the missing list. This will allow you to keep the list small to bring in some general survey. By combining the filters and the ignore list you should have a good compromise of speed and detail.

### Random summoning
The add-on can summon a random companion or mount by using the macros the addon creates.

You can define a set of mounts and companions from which CollectMe will choose randomly in the "Random Companion" and "Random Mount" Tab.

#### Zone priorities for mounts
Collect Me tries to autodetect wich mount would be best for the current zone (example vashj'r, non flyable zones) and build the pool based on this suggestion and your defined mounts and than randomly choose one. Let's take a look to AQ40 for an example. You have 2 Qiraj mounts and 10 normal ground mounts and you are in AQ40.
Both Qiraj mounts are not added to the set for auto summoning. In this case Collect Me would summon a random ground mount. If one Qiraj mount would be enabled in your set Collect Me would always take the Qiraj mount. If both Qiraj mounts would be enabled, Collect Me would randomly choose between those two mounts.
Zone Mounts always weigh stronger than non zone mounts. Currently you can not influence that, but in a future release some options may be added.

## 3D Model Preview
* By left-clicking on a mount or companion in the main window you can bring up a window with a 3d preview of the mount.
* By Ctrl + left-clicking on a mount or companion in chat you can view a 3d preview of it.

## Reporting issues and feature requests
 * If you have a feature request of a bug you can open a ticket on curseforge http://wow.curseforge.com/addons/collect_me/tickets/ or github https://github.com/Tschebel/CollectMe/issues
 * For general questions you can use the comments on Curse.

## Translation and help with that
 * Collect Me only comes in english and partial german but fully supports WowAce as translation library.
 * If you want to help and submit translations in your language you can do so by using GitHub https://github.com/Tschebel/CollectMe or if you aren't familiar with GitHub you can send an email.

## Additional Information
 * If you have anything the add-on doesn't have in its database, you will receive a message in your chat frame. Please leave a comment or a ticket on the addon page if this is the case.

Thanks
  * wowdb.com
  * wowhead.com
  * wowace.com
