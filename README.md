## Introduction
Collect Me keeps track of your mounts and titles in the game and can show you your missing mounts and titles with additional information where to get them. It also can summon companions and mounts randomly with a priority list.

## Basic Features

 * Ignore List for mount and titles
 * Filters for mounts and titles
 * Source-information of mounts and titles
 * 3D model preview of mounts
 * Zone- and priority-based random mount-summoning
 * Priority-based random pet-summoning
 * auto-summoning companions on moving
 * WowAce profile support

## Usage
Collect Me creates two macros for mount and companion summoning. All other features and settings can be accessed on the main window

## Slash Commands
 * /collectme or /cm will bring up the main window
 * /cm randomcompanion or /cm rc will summon a random companion bases on your priority list
 * /cm randommount or /cm rm will summon a random companion bases on your priority list
 * You also can use the "Collect Me" button in the Blizzard Mount Tab to start the add-on

## The Main Window

When you start the Main Window the add-on will automatically build a mount, pet, title list based on your faction, class.
By hovering over a pet/mount/title with the mouse you will receive additional information where to get it.
Ignore List

You can add an item to the ignore list by right-clicking on them, if you don't want them or you can't get them by any reasons.
Filters

In addition to the Ignore List, you can add some pre-configured filters in the option menu. Those filters will hide companions, mounts and titles from both, the missing and the ignore list. This will allow you to keep the list small to bring in some general survey. By combining the filters and the ignore list you should have a good compromise of speed and detail.
Priority-based random companion summoning

The add-on can summon a random companion by using the slash command /cm randomcompanion. I highly recommend to use a macro for this.
To manage the priority list, go into the CollectMe options and select the subcategory: Random Companion. There you'll find a list of every companion you have and you can assign them priorities between 0 and 10 (default value for new companions is 5).

    * 0: If you set a companion to zero it will never be summoned.
    * 1-10: The higher the priority, the higher the chance that the companion will be summoned.

NOTE: The chance depends not only on the companion priority but on all priorities of all companions.
Example

    * Companion A) 5
    * Companion B) 0
    * Companion C) 10
    * Companion D) 10

That gives A a chance of 20% to be summoned. B will never be summoned (0 %). C and D have both a chance of 40% to be summoned.
The Collect Me Summon Button

By default you'll have a button where you can see the next companion which will be summoned. The companion is calculated by the priority list.
By left-clicking the companion will be summoned.
By right-clicking the companion will be skipped and a new companion will be calculated.
By shift-left-clicking the companion it will be de-summoned if already summoned.
You can simply drag the button to a place where you want. To lock it, go to the Collect Me Options. If you don't like the button and prefer the slash command instead you can easily hide the button in the options too.
3D Model Preview

By left-clicking on a mount or a companion you can bring up a window with a 3d preview of the mount or companion.
NOTE: You can only see models from your local cache. If the model has not been seen in-game, the preview window will remain empty. There is currently no possibility to workaround that fact.
Additional Information

    * Collect Me should work on all languages but the tool-tips with the Source-information will remain English. If someone likes to translate them, feel free to do it and send it to me so i can implement it.
    * If you have a pet or mount which the add-on doesn't know, you will receive a message in the default chat frame. Please let me know, so that I can add the pet or mount to the add-on.
    * I don't have the possibility to check the add-on on all possible professions/class/faction combos. So if you encounter any errors please let me know.

Thanks

    * SkeeveSM for his add-on TheCollector which inspired me and where I've taken the base interface and some ideas and algorithms.
    * warcraftpets.com
    * warcraftmounts.com
    * wowhead.com