*Check out the most recent updates on the [wiki](https://github.com/computmaxer/roku-hdhomerun/wiki/News-and-Updates).*

Roku-HDHomerun
==============

Watch TV on your Roku using your HDHomerun PRIME/PLUS!

The HDHomerun PRIME (hdhr3-cc) and PLUS (hdtc-2us) support streaming over HTTP.  Unfortunately the Roku cannot consume this stream directl. [maddox](https://github.com/maddox) has created a transcoding application called [Wallop](https://github.com/maddox/wallop) to convert the MPEG2 stream to H.264 and serve it up live over HLS using ffmpeg.  Thanks to his work, I was able to easily create a Roku app to stream from [Wallop](https://github.com/maddox/wallop).

[themacks](https://github.com/themacks) created a similar application called [Ply](https://github.com/themacks/ply) that is compatible with the HDTC devices. Ply takes advantage of the fact that the tuner has built-in transcoding so you do not need to dedicate a lot of computing resources to it.

![Screenshot](http://i.imgur.com/GJUiye0.png)


##What You Need##
 * HDHomerun PRIME (hdhr3-cc) OR HDHomerun PLUS (hdtc-2us)
 * [Wallop](https://github.com/maddox/wallop) (for PRIME) OR [Ply](https://github.com/themacks/ply) (for PLUS) installed and running on a some machine/server.
 * Roku


##I have that stuff, what's next?##
 * Add the channel. Here is the link to the [private channel](https://owner.roku.com/add/rokuhdhr).
 * Enter the Wallop/Ply server information on the Settings page. (NOT the HDHomerun address)
 * Sit back and enjoy live TV on your Roku.

##Channel Logos##
Wallop has the ability to serve up channel logos for each of your channels.  I have included some logos sized appropriately for this Roku app in the `channel_logos` directory.  Copy these logos to your Wallop install and add each channel to your Wallop config, as described [here](https://github.com/maddox/wallop#network-logos). Please contribute more logos if you create them for your setup!  The proper image size is 210x270.

##Future Plans##
Currently waiting for Roku to support .ts containers (live streams).
Follow the updates on the [wiki](https://github.com/computmaxer/roku-hdhomerun/wiki/News-and-Updates).

##FAQ##

###Does this work with the HDHomerun Dual TV tuner?###
No. Sorry. :(  The Dual (hdhr3-us) does not have the ability to stream over HTTP, and SiliconDust has said it will never be able to have this ability due to hardware limitations.  You will have to purchase a newer HDHomerun device.


###Can you make a Plex channel?###
I am going to take a look and see if I can use the same techniques to make this work on a Plex channel as well.  Ideally we would use Plex's transcoder instead of Wallop, but Plex's transcoder currently does not support live streams of any kind.

###Does it have a channel guide/schedule?###
No. This is something I am looking into.  If you know of any free/open APIs where I can get that information for, say, a zip-code, please let me know!
