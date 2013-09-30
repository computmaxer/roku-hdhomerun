Roku-HDHomerun
==============

Watch TV on your Roku using your HDHomerun PRIME and Wallop!

The HDHomerun PRIME (hdhr3-cc) supports HTTP Live Streaming (HLS).  Unfortunately it is an MPEG2 stream and the Roku cannot decode it.  Fortunately, [maddox](https://github.com/maddox) has created a transcoding application called [Wallop](https://github.com/maddox/wallop) to convert the MPEG2 stream to H.264 and serve it up live over HLS using ffmpeg.  Thanks to his work, I was able to easily create a Roku app to stream from [Wallop](https://github.com/maddox/wallop).

![Screenshot](http://i.imgur.com/GJUiye0.png)


#What You Need#
 * HDHomerun PRIME (hdhr3-cc)
 * [Wallop](https://github.com/maddox/wallop) installed and running on a some machine/server.
 * Roku

#Future Plans#
SiliconDust, the creaters of the HDHomerun have announce a new generation of network TV tuners, hdhr4, that have built-in transcoders.  Once these devices are avaiable, we will be able to skip the Wallop step and stream directly from the tuner to the Roku.  I plan to add this functionality to this Roku application as soon as the devices are available and I can get my hands on one.

#FAQ#

###Does this work with the HDHomerun Dual TV tuner?###
No. Sorry. :(  The Dual (hdhr3-us) does not have the ability to do HLS streaming, and SiliconDust has said it will never be able to have this ability due to hardware limitations.  You will have to purchase an HDHomerun PRIME or wait for the new generation of tuners with built-in transcoders.

