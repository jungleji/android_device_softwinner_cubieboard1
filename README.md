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

Copy cm-10.1.xml from local_manifest under this project to .repo/local_manifests

3) sync code. IMPORTANT: be prepared this is a 13 Gig download. 

    $ cd ~/cb-cm-10.1
    $ repo sync

4) run cm get-prebuilts

    $ cd vendor/cm
    $ ./get-prebuilts

5) envsetup

    $ cd ~/cb-cm-10.1
    $ . build/envsetup.sh
    $ breakfast cubieboard1

6) build all

    $ mka

Build nand image
----------------

Before build, you need prepare cache.img and data.img in $OUT folder.

These images are ext4 filesystem data file, you can create them by hand. e.g. data.img:

1) Create empty img file(size = 1G)

    $ dd if=/dev/zero of=largedata.img bs=4k count=256000

2) Format image to ext4

    $ mkfs.ext4 largedata.img

3) Tune fs options

    $ tune2fs -c0 -i0 largedata.img

Then, go to tools/pack, run pack-cm.sh script to generate nand image:

    $ cd tools/pack
    $ ./pack-cm.sh

XBMC
----

The primary target of this porting is to support XBMC hardware decode on AllWinner A10.

Now XBMC 13.0 with stagefright hardware decoder works on this system.

You can download latest XBMC from http://mirrors.xbmc.org/releases/android/arm/
and install with adb:

    $ adb install xbmc-13.0-armeabi-v7a.apk

After XBMC launch, open System->Setting->Video->Acceleration page, need Setting level to advanced,
uncheck MediaCodec and keep libstagefright hardware acceleration checked.
