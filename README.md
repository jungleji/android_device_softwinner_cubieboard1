Cubieboard1 porting to cm-10.1(android-4.2.2)
=============================================

Compile steps
-------------

1) fetch cm-10.1

$ mkdir ~/cb-cm-10.1
$ cd ~/cb-cm-10.1
$ repo init -u git://github.com/CyanogenMod/android.git -b cm-10.1

2) create local_manifests

$ cd .repo
$ mkdir local_manifests

Copy cm-10.1.xml located in this folder's local_manifest to .repo/local_manifests

3) sync code

$ cd ~/cb-cm-10.1
$ repo sync

4) run cm get-prebuilts

$ cd vendor/cm
$ ./get-prebuilts

5) envsetup

$ cd ~/cb-cm-10.1
$ . build/envsetup.sh
$ breakfast cubieboard1

6) create Makefile

If there is no Makefile generated, you can create on manually:

$ echo include build/core/main.mk > Makefile

10) make

$ mka

