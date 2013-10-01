Roku-HDHomerun
==============

Watch TV on your Roku using your HDHomerun PRIME and Wallop!

The HDHomerun PRIME (hdhr3-cc) supports streaming over HTTP.  Unfortunately it is an MPEG2 stream and the Roku cannot decode it.  Fortunately, [maddox](https://github.com/maddox) has created a transcoding application called [Wallop](https://github.com/maddox/wallop) to convert the MPEG2 stream to H.264 and serve it up live over HLS using ffmpeg.  Thanks to his work, I was able to easily create a Roku app to stream from [Wallop](https://github.com/maddox/wallop).

![Screenshot](http://i.imgur.com/GJUiye0.png)


##What You Need##
 * HDHomerun PRIME (hdhr3-cc)
 * [Wallop](https://github.com/maddox/wallop) installed and running on a some machine/server.
 * Roku


##I have that stuff, what's next?##
 * Add the channel. Here is the link to the [private channel](https://owner.roku.com/add/rokuhdhr).
 * Enter the Wallop server information on the Settings page. (NOT the HDHomerun address)
 * Sit back and enjoy live TV on your Roku.

##Channel Logos##
Wallop has the ability to serve up channel logos for each of your channels.  I have included some logos sized appropriately for this Roku app in the `channel_logos` directory.  Copy these logos to your Wallop install and add each channel to your Wallop config, as described [here](https://github.com/maddox/wallop#network-logos). Please contribute more logos if you create them for your setup!  The proper image size is 210x270.

##Future Plans##
SiliconDust has announced a new generation of network TV tuners, hdhr4, that have built-in transcoders.  Once these devices are avaiable, we will be able to skip the Wallop step and stream directly from the tuner to the Roku.  I plan to add this functionality to this Roku application as soon as the devices are available and I can get my hands on one.  Once this happens, I think I can justify making this a Public Roku channel.

##FAQ##

###Does this work with the HDHomerun Dual TV tuner?###
No. Sorry. :(  The Dual (hdhr3-us) does not have the ability to stream over HTTP, and SiliconDust has said it will never be able to have this ability due to hardware limitations.  You will have to purchase an HDHomerun PRIME or wait for the new generation of tuners with built-in transcoders.


###Can you make a Plex channel?###
I am going to take a look and see if I can use the same techniques to make this work on a Plex channel as well.  Ideally we would use Plex's transcoder instead of Wallop, but Plex's transcoder currently does not support live streams of any kind.
