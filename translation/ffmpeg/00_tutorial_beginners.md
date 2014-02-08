A FFmpeg Tutorial For Beginners
============

> [Original Page][src], [Chinese](00_初学者教程.md)

![][logo]

[FFmpeg][link0] is a complete, cross platform command line tool capable of recording, converting and streaming digital audio and video in various formats. It can be used to do most of our multimedia tasks quickly and easily say, audio compression, audio/video format conversion, extract images from a video and a lot more. In this howto I will tell you how to do all of this stuff using FFmpeg.

I am not a professional related to any field that makes use of ffmpeg. I use it sometimes for my daily multimedia requirements. So, these articles might not reach the advanced level you may expect. I have written this tutorial by keeping in mind the needs of regular users who don't always need advanced methods. That's why I have written down the tutorials as day to day tasks that a regular user like me and you may face.

In case you want some tutorial to be added or corrected or have some tip to share about FFmpeg, do leave a reply or send us a a note through the [contact form][link1]. I would love to cover most of the tasks that can be done with FFmpeg and make this tutorial a well formed FFmpeg guide for new users.

## How to install FFmpeg in Linux

![][img0]

In most of the distros, you can directly install ffmpeg from their repositories. But in case you are looking for installing the latest version or want to customize the installation, you might need direct installation from the source code too. I have discussed both of the methods in this howto. This will guide you to properly install ffmpeg on any of the Linux system.

### Install FFmpeg in Ubuntu

Either click this [link][link2] or run this command in the terminal to install FFmpeg.

    [shredder12]$ sudo apt-get install ffmpeg

### Install FFmpeg in Fedora

FFmpeg can be directly installed from the repos. Just run the following command.
    
    [shredder12]$ su -c 'yum install ffmpeg'

### Install FFmpeg in any Linux system from source

This howto will be helpful to all the linuxers who either want to have a fully customized installation of FFmpeg or are having some trouble in installing the default package from the distro repos or want to try the latest release.

First of all you will have to download the latest source from the [main website][link0]. Now, untar it.

    [shredder12]$ tar -xvjf ffmpeg-0.5.tar.bz2

### Install FFmpeg with default options

once you are done with this, in order to install FFmpeg with the default config and options run

    [shredder12]$ ./configure

from within the FFmpeg source directory. When the configuration script finishes compile it by running make

    [shredder12]$ make

If the compile finishes without any errors run 'make install' as root to install FFmpeg

    [shredder12]$ su -c 'make install'

### Install FFmpeg with customized settings

If you want to install FFmpeg by customizing some installation options then you can pass some special parameter while running configure script. Run the following command to find out various options available while running configure script.

    [shredder12]$ ./configure --help

This will show you various options to customize the default installation. Most of the time the default installation will work for you but there is one option which most of us might need freqeuntly. It is

`--enable-libmp3lame`: This one is a must if you want to work with mp3. Encoding mp3 won't be possible without it.

Although in order to make this option work you will need lame installed. You will get the warning at the time of configuring it. This can be done by installing the library "*libmp3lame*". You can either install it directly from the repos.

    [shredder12]$ sudo apt-get install libmp3lame0

or, you can install libmp3lame directly from the source from their [website][link3].

Once you are done with 'lame's' installation. this run configure again, if successful run `make` and then `make install` as root.

## FFmpeg Basics for Beginners

![][img1]

If I were to tell a reason why I like FFmpeg so much, ofcourse other than its power, I would definitely go with the ease it provides through command line. I don't have to open an application, select some file and then ask it to convert it. All of it can be done in just a single command. Check this out, and you will understand how easy media conversion becomes with FFmpeg.

### Basic syntax of FFmpeg command

Lets begin with a simple example, I want to convert an avi file into mpg format. This is how we do this in ffmpeg.

    [shredder12]$ ffmpeg -i input.avi output.mpg

A good thing about ffmpeg is that it automatically guesses which encoders to use by noticing the format of input and output files. So, until you are going to specify the encoders, make sure you mention the full filename, along with the appropriate format. Because of this feature the commands are really small. So, now we can even generalize the default command syntax of ffmpeg.

    [shredder12]$ ffmpeg -i inputfile.fmt1 outputfile.fmt2

Here, the inputfile is in the format "*fmt1*" and the output file in format "fmt2". So, I hope, now you can see the power and level of abstraction provided by FFmpeg. If you are looking for some basic conversions you don't need to know a lot of specs. Just write a simple command following the above syntax and FFmpeg will do the rest for you.

Please note that, FFmpeg options always apply to the next file in the argument list. Doesn't matter whether it is the input or the output file. e.g any flag/argument mentioned in the command after the input file name will apply to the output file.

But there is one slight flaw. Since FFmpeg devs had to keep a default setting for the audio and video bitrate, they settled on a 64kbps audio(radio quality) and 200 kbps for video, a bad video quality. But these options can always be changed so this is not a big issue.

Here are some of the general options that you might need while using ffmpeg.

### How to keep the video quality of an output file same as the input video file in FFmpeg

For example, if you want to keep the video quality of the output file same as the input file you can easily do this using the -sameq option. This is how it works.

    [shredder12]$ ffmpeg -i input.avi -sameq output.mpg

Or, if you know what type of audio and video quality you are looking for. You can manually various options for doing so.

### Pre-defined audio and video options for various file formats in FFmpeg

Suppose you just recorded a video from your camera and now want to burn it into a dvd. So, before burning you might want to convert the video into a proper DVD format. This is how you do it using the "-target" option in FFmpeg.

    [shredder12]$ ffmpeg -i input.avi -target dvd output.mpg

Since, there are standards for such file formats, ffmpeg will automatically apply them on the output file. Thus, easing the task for you. For more such standards take a look at its man page.

### How to fix the time duration of the output file using FFmpeg

This can be easily done using the `-t` option. Take a look at the example.

    [shredder12]$ ffmpeg -i input.fmt1  -t 30 output.fmt2

The time specified is in seconds. But the format hh.mm.ss is also supported. This command will convert the first 30 seconds of the file *input.fmt2*  into *output.fmt2*.

### Various Audio and Video FFmpeg options

Refer to these articles for various basic options for [audio transcoding][link4] and [video transcoding][link5] using FFmpeg.

This article is intended to just give the user a quick start on media conversion using FFmpeg. There are a lots of other stuff that can be done using FFmpeg. I will try and cover some common use cases in other such how tos.

### Basic Audio Transcoding options in FFmpeg

I hope you are now aware of the [basic command format of ffmpeg][link6]. Now, I will tell you about some basic options/flags that can be used for audio transcoding.

`-ar <value>` This one is used to set the audio frequency of the output file. The comman values used are  22050, 44100, 48000 Hz.

`-ac <value>` Set the number of audio channels.

`-ab <value>` This flag is used to set the bitrate value of an audio file. e.g. you can use -ab 128k to use the 128kb bitrate. The higher the value, the better is the audio quality. This is one of the important factors responsible for the audio quality. But that doesn't mean you can make a poor audio file sound better by increasing its bitrate. The resultant file will just be of bigger size. You can find more about it in this [audio compression howto][link7].

`-an` This stands for "no audio recording" and can be used to strip out an [audio stream from a media file][link8]. When you use this option, all the other audio related attributes are cancelled out.

`-acodec` This options lets you choose the type of audio codec you want to use. e.g. if you are using ffmpeg on a mp3 file, then it will need the audio codec libmp3lame. you can specify it using -acodec libmp3lame. Although, by default, ffmpeg should take care of the codecs you need(by guessing it from the output file format) and if you need anything different then go for this tag. So, a basic audio to audio conversion should be something like this.

    [shredder12]$ ffmpeg -i input.wav output.mp3

In case you are not looking for a specific file format, then try and use open audio format ogg vorbis. It doesn't have any legal crap like patented mp3. You can use the following command to convert any audio file into ogg vorbis format.

    [shredder12]$ ffmpeg -i input.mp3  -b 128k  output.ogg

This will directly convert your audio mp3 file into open format ogg file. You may also deliberately use the option `-acodec vorbis` in case it doesn't work.

## Basic Video Transcoding Options in FFmpeg

Here are some of the basic video options that you might need frequently while using ffmpeg on various video files. For the transonding options of an audio file, refer [this article][link9]. And you might get some help regarding [basic FFmpeg here][link10].

### Set the bitrate of a video file using FFmpeg

`-b <value>` This options sets the bitrate of a video file. e.g.

    [shredder12]$ ffmpeg -i input.avi -b 200k output.avi

### Set the Frame rate of a video file

`-r <value>` This option is used to set the frame rate.

### Set the size or resolution of a video file

`-s <resolution>` is used to specify the resolution of the output file. The basic syntax is

    [shredder12]$ ffmpeg -i input.avi  -s 1024x768 output.avi

You can even use abbreviations in place of the actual resolution. e.g "-s xga" in place of 1024x768 above. You can find more about the abbreviations here.

### Set the aspect ratio

`-aspect <ratio>` is used to specify the aspect ratio of the output file. A common usage could be.

    [shredder12]$ ffmpeg -i input.avi -aspect 4:3 output.avi

In order to get this ratio, the video will be stretched either along the width or the height.

### Howto cropping and padding videos using FFmpeg

Refer these articles for [cropping][link11] and [padding][link12].

### Remove the video recording or stream from a media file.

`-vn` This option ensures that there is no video stream in the output file and also all the video related options are negated.

### Specify video codec to be used by FFmpeg

`-vcodec <codec>` This is similar to the audio codec option "acodec". Specify the codec you want to use for video transcoding and FFmpeg will use it. The default codec is based upon the output file format.

Well, if you are not looking for a specific codec then I would suggest you to go for open video format [theora][link13]. This format doesn't have any legal crap and is pretty good too. You can do the conversion like this.

    [shredder12]$ ffmpeg -i input.avi  -vcodec libtheora output.ogv

Althoug, you don't have to mention the video codec until you are using the proper format. You can find a little more about video conversion [here][link14].

## How to compress audio files using ffmpeg

![][img2]

Whenever I go home and meet my friends after a long time, its like a tradition to share songs. Since, I keep my Music collection on the laptop, I don't have to deal with disk space issues. Where as the filesize of a song does matter to most of my friends, because they use iPods or MP3 players. For them, small size songs means more songs.

So, the solution to this problem was audio compression but I didn't know any application in linux that could compress songs. I was thinking of switching to Windows to do this task when I came across this great tool FFmpeg.

### What is audio compression?

The whole concept behind audio compression is to lower the audio bitrate(128kbps, 192 kbps etc.). So, all we need to do is set the audio bitrate manually(ofcourse a value lower than the original) to compress an audio file. You might want to keep in mind that, a high bitrate audio file confirms a better sound quality so by lowering its bitrate, you are actually degrading the quality.

### How to Compress audio files using FFmpeg

You can use the '-ab' flag to set the audio bitrate of a media file. Suppose you already have a song of 320kbps bitrate. And you want to compress it to 128kpbs. This is how you do it using FFmpeg.

    [shredder12]$ ffmpeg -i inputfile.mp3 -ab 128 outputfile.mp3

This will result in a 128kbps outputfile.

This list might help you get a better understanding of the relation b/w audio bitrates and the corresponding sound quality. This list is the work of [http://www.mp3-tech.org/tests/gb][link15]

* **96kbs:** The sound clearly lacks definition: as an example, hall's noises are perceived as some breath. The result is comparable to a good FM radio.
* **112kbs:** The sound seems less present and less natural than the original. The definition is a bit less good, the voice is less clear. Attacks are less spontaneous. The spatialization is different from the original recording: the sound seems to be located more far and more lower. There is however a very noticeable improvement compared to 96kbs.
* **128kbs:** Hall's noises are slightly less defined than the original. The violin is a bit less present and the piano attacks a bit less sharp. The voice is nearly identical to the original recording but sibilants are less pronounced. We can notice the same spatialization problem as with the 112kbs's one although there is again a good improvement compared to the 112kbs rate.
* **160kbs:** The sound is more natural than 128kbs but the improvement is less spectacular than during the two preceding stages. The sound is different from the original, without however being possible to tell in what. I think that the difference resides more in what we feel rather than in what we hear.
* **192kbs:** The sound is not felt as the original recording. It is however totally impossible to tell in what.
* **256kbs:** The sound is indiscernible from the original. It is impossible to make the difference with the original recording.
* **320kbs:** The sound is indiscernible from the original. It is impossible to make the difference with the original recording.
* **CD Audio:** The sound of the burned CD is strictly identical the manufactured CD. This test, although it could appear useless, is however necessary so in order to insure that it is impossible that the burning step introduces differences, that would have falsified tests.

## How to convert video files into various other video formats using FFmpeg

![][img3]

Media Conversion into various formats is probably the widest and most popular use of FFmpeg.  As I have already shown in the [FFmpeg for Basics][link10], a simple ffmpeg command should take care of most of your media conversion. e.g. If you want to convert a flv file to mpeg.

    [shredder12]$ ffmpeg -i inputfile.flv -sameq outputfile.mpeg

FFmpeg is smart enough to take care of it. Please not that, we are using the -sameq option to ensure that FFmpeg uses the same audio and video quality as the input file and  doesn't use its default options for media conversion.

### How to set the resolution or frame size of a video using ffmpeg

We can use various other options. e.g. If you want to lower the resolution of the output video file, you can do this by setting the frame size of the final video using '-s' flag.

    [shredder12]$ ffmpeg -i  inputfile.avi  -s 320x240  outputfile.avi

You can even use direct notations in place of writing down the resolution. e.g.  hd720 stands for 1280x720. Use the notation. You can find more information in the table I have specified in [this howto][link16].

### How to force FFmpeg to use a particular type of video codec for conversion.

Sometimes you might want to force a particular type of codec or format for video conversion. You can easily do it using the -vcodec flag.

    [shredder12]$ ffmpeg -i  inputfile.mpg  -vcodec mpeg4 outputfile.avi

If you want to force a particular format. You can easily do this using the `-f` flag.

### How to convert a high quality file into a .flv file format

Now, lets up all this knowledge to convert a single high quality file you have shot from your video camera and convert it into a low quality file, say flv for a player. Although the flags and the method we are using is all that matters, I am using flv to just define the output video's specs.

    Video Bitrate     : < 500 kbps
    aspect ratio      : 480x360
    audio bitrate     : 32kbps
    Frames per second : 25

We will use the following command to make this happen.

    [shredder12]$ ffmpeg -i  recorded_file.mov  \
                         -ar 22050  \
                         -ab 32k  \
                         -r 25 \ 
                         -s 480x360  \
                         -vcodec flv \
                         -qscale 9.5 \
                         output_file.avi

ar is used to set the audio frequency of the output file. The default value is 41000Hz but we are using a low value to produce a low flv quality file.

qscale is a quantisation scale which is basically a quality scale for variable bitrate and coding, with lower number indicating a higher quality. You can try running the above command with and without qscale flag and then you can easily see the quality difference.

In order to get a list of all the formats supported by ffmpeg, run this command.

    [shredder12]$ ffmpeg -formats

I hope I have covered most of the options to let you easily convert video media files into various formats yourself.

## How to crop videos using ffmpeg

![][img4]

Sometime you might want a specific resolution for a video(ofcourse, smaller than the original). You can either resize the video and degrade the quality or you can just crop the video to achieve that resolution. This might affect the content of the video but if the content is mostly centric then it is probably a good option.

Suppose, we have a video of resolution 1920x1200 and we want to convert into a video of resolution 1200x1024. This is how you will do it using ffmpeg.

    [shredder12]$ ffmpeg -i inputfile.avi \
                         -croptop 88 \
                         -cropbottom 88 \
                         -cropleft 360 \
                         -cropright 360 \
                         outputfile.avi

Just take a look at the original resolution the width of the video was 1920 pixels and we want it to be 1200, the difference is 720 so we removed 360 pixels each from right and left. Similarly, we did the same for the height.

## How to extract images from a Video using FFmpeg

![][img5]

Extracting images from a video depends upon the frames we are considering per second and then using that frame to output an image. So, here we need to control the frame rate, image format and in case you want a specific resolution of the image, you can do that by setting the frame size which is explained later.

This command is the most basic way of extracting images from a Video.

    [shredder12]$ ffmpeg -i inputfile.avi -r 1 -f image2 image-%3d.jpeg

Now, let us see what all these different flags in the above command means.

* `-r`  This is used to set the frame rate of video. i.e. no. of frames to be extracted into images per second. The default value is 25, using which, would have yielded a large number of images.
* `-f`  This option defines the format we want to force/use, although removing this option shouldn't  cause any problem.
* `image-%3d.jpeg`  By `%3d`, we mean that we want the naming of the image files to be of the format "image-001.jpeg, image-002.jpeg.." and so on. If we had used image-%2d the names would have been image-01.jpeg, image-02.jpeg. You can use any format as per your choice.

We can also define the image size of the extracted images using the -s flag. The default option is to use the image size same as the video resolution.

    [shredder12]$ ffmpeg -i inputfile.avi \
                         -r 1 \
                         -s 4cif \
                         -f image2 \
                         image-%3d.jpeg

4cif options stands for the frame size 704x576. There are a variety of options that you can use.

 sqcif  | 128x96    | qcif   | 176x144   | cif    | 352x288
--------|-----------|--------|-----------|--------|---------- 
 4cif   | 704x576   | qqvga  | 160x120   | qvga   | 320x240
 vga    | 640x480   | svga   | 800x600   | xga    | 1024x768
 uxga   | 1600x1200 | qxga   | 2048x1536 | sxga   | 1280x1024
 qsxga  | 2560x2048 | hsxga  | 5120x4096 | wvga   | 852x480
 wxga   | 1366x768  | wsxga  | 1600x1024 | wuxga  | 1920x1200
 woxga  | 2560x1600 | wqsxga | 3200x2048 | wquxga | 3840x2400
 whsxga | 6400x4096 | whuxga | 7680x4800 | cga    | 320x200
 hd480  | 852x480   | hd720  | 1280x720  | hd1080 | 1920x1080

 Now, if you want to set the duration for which image extraction will take place, you can use the '-t' option to set the duration in seconds.

    [shredder12]$ ffmpeg -i inputfile.avi -r 1 -t 4 image-%d.jpeg

Since, we are forcing 1 frame per second and the duration is only 4 seconds, the images extracted will be 4.

If you want to start the extraction from particular point, say 01:30:14 in the video for a specific duration(40 seconds), you can easily do it using the combination of '-ss' and '-t'. This should do it for you.

    [shredder12]$ ffmpeg -i inputfile.avi \
                         -r 1 \
                         -t 40 \
                         -ss 01:30:14 \
                         image-%d.jpeg

You can even set the number of video frames to record using `-vframes` flag.

    [shredder12]$ ffmpeg -i inputfile.avi \
                         -r 1 \
                         -vframes 120 \
                         -ss 01:30:14 \
                         image-%d.jpeg

This will record 120 frames of the video starting from 1:30:14 at 1frames per second. So, after 120 seconds, you should have 120 images.

## How to pad videos using ffmpeg

![][img6]

You might need padding when you want to burn a video into a DVD widescreen format say 16:9 or any other video format, I am talking about the 2 black portions/bars (at top and bottom) on a DVD video. Just like [cropping a video][link11], padding is pretty easy too. Just a game of 4 options.

Now, lets consider the same scenario, convert a video into widescreen 16:9 format. Suppose the video format we have is 1280x720 and no we want to padd it with bars on top and bottom to get the final aspect ration of the video as 4:3 i.e. resolution is 1280x960. In order to achieve this we will have to increase the height of the video by 240 pixels. We will use the following command to do that.

    [shredder12]$ ffmpeg -i input.avi \
                         -padtop 120 \
                         -padbottom 120 \
                         -padcolor 000000 \
                         output.avi

As it is already clear from the options, -padbottom means adding a 120px(height) bar at the bottom of the video and similarly we can use padleft and padright. Although there, the padding value will mean the width of the bar.

We can even select the colour of the bar using the option padcolor, the colour is specified in the same hexadecimal format used in HTML and CSS.

> Note: The value for padding can't be an odd vlaue. So, you want to pad 90px of height, you should use padding values as 44 and 46 and not 45. They have to be even.

## How to record audio from mic using FFmpeg aka audio grabbing

![][img7]

Recently [a linuxer pointed out][link17] that in spite of the amazing and widespread capabilities of FFmpeg, I have just been focused upon its media conversion feature. If you take a look at all our previous [ffmpeg articles][link18], the guy is right. So, from now we will discuss other features of the superstar too, starting with audio recording.

Why don't you try out the command first and we will see later how it actually works.

    [shredder12]$ ffmpeg -f oss -i /dev/dsp audio.mp3

Once you run this command you will see ffmpeg saving some data in the file audio.mp3. What is it? Its actually recording all the audio that is going through the device /dev/dsp. Try speaking something on your microphone and play the file.

We can even do some pretty cool stuff using the device /dev/dsp.

But first, what is this device /dev/dsp? It is an audio sampling and recording device, stands for Digital Signal processor. It converts audio signal(from microphone) to digital(for computer) and vice versa. This device only understands complete raw audio, playing an encoded file (mp3, ogg etc.) will just result in garbage sound. And by raw audio file I meant a meaningful music, you can literally give any file to this device as input and it will play it. All it care for are bits and bytes which is what every file is made of. Try playing any of your hard disk partition for fun sake .

    [shredder12]$ cat /dev/sda1 > /dev/dsp

After doing that, you can say and actually mean "Windows doesn't sound good"

## How to remove audio and video streams in a media file using FFmpeg

![][img8]

Many times we are either looking for only the video or the audio component of a media file. This is useful for people who are making video mix or if you can't find a mp3 for a song but have a video file.

### How to remove audio stream from a media file using FFmpeg

In order to remove the audio stream, we can use the '-an' flag, which stands for "*no audio recording*". Suppose you have a media file inputfile.avi and you want to remove the audio, this is how you do it. This option will negate all the other audio related flags because no audio is going to be present in the final output file.

    [shredder12]$ffmpeg -i inputfile.avi -an outputfile.avi

### How to remove video stream from a media file using FFmpeg

Use `-vn` flag to remove the video from a media file. This flag stands for no video recording. This option will negate all the video options since the final output file has only the audio component. But audio options will still work, say you want to remove the video content and want a 128kbps audio file.

    [shredder12]$ffmpeg -i inputfile.avi -vn -ab 128 outputfile.

## How to convert online flash or flv (youtube) videos into mpeg format using ffmpeg

![][img9]

Although youtube provides high quality videos now, there is still a lot of media content on the web which is available in flv. In this howto, I will show you how to convert those flv files into mpeg format using ffmpeg in a single command.

Suppose we have a file video.flv and we want to convert it into video.mpeg. This is how we convert a flv file into mpeg using FFmpeg.

    [shredder12]$ ffmpeg -i video.flv -sameq video.mpeg

Yes, exactly its that simple. You can do a bit of tweaking with various other ffmpeg flags but since the specs of a flv file are already pretty low, its better to let the default method handle it

---------------------------------------------------------
[src]:http://linuxers.org/book/export/html/593
[link0]: http://ffmpeg.org/
[link1]: http://linuxers.org/contact
[link2]: apt://ffmpeg
[link3]: http://lame.sourceforge.net/index.php
[link4]: http://linuxers.org/tutorial/basic-audio-transcoding-options-ffmpeg
[link5]: http://linuxers.org/tutorial/basic-video-transcoding-options-ffmpeg
[link6]: http://linuxers.org/tutorial/ffmpeg-basics-beginners
[link7]: http://linuxers.org/tutorial/how-compress-audio-files-using-ffmpeg
[link8]: http://linuxers.org/tutorial/how-remove-audio-and-video-streams-media-file-using-ffmpeg
[link9]: http://linuxers.org/tutorial/basic-audio-transcoding-options-ffmpeg
[link10]: http://linuxers.org/tutorial/ffmpeg-basics-beginners
[link11]: http://linuxers.org/tutorial/how-crop-videos-using-ffmpeg
[link12]: http://linuxers.org/tutorial/how-pad-videos-using-ffmpeg
[link13]: http://linuxers.org/category/theora
[link14]: http://linuxers.org/tutorial/how-convert-video-files-various-other-video-formats-using-ffmpeg
[link15]: http://www.mp3-tech.org/tests/gb
[link16]: http://linuxers.org/tutorial/how-extract-images-video-using-ffmpeg
[link17]: http://linuxers.org/tutorial/ffmpeg-tutorial-beginners#comment-1085
[link18]: http://linuxers.org/tutorial/ffmpeg-tutorial-beginners

[logo]: http://linuxers.org/sites/default/files/article-logo/ffmpeg.png?1268646968
[img0]: http://linuxers.org/sites/default/files/article-logo/1268656256_gnome-app-install.png?1268656276
[img1]: http://linuxers.org/sites/default/files/article-logo/1268656103_package_multimedia.png?1268656477
[img2]: http://linuxers.org/sites/default/files/article-logo/1268551566_video_compress.png?1268551729
[img3]: http://linuxers.org/sites/default/files/article-logo/1268168814_xine.png?1268654938
[img4]: http://linuxers.org/sites/default/files/article-logo/1268632119_cut.png?1268632150
[img5]: http://linuxers.org/sites/default/files/article-logo/1268632243_images.png?1268632271
[img6]: http://linuxers.org/sites/default/files/article-logo/1268656154_applications-multimedia.png?1269441169
[img7]: http://linuxers.org/sites/default/files/article-logo/1280946741_Microphone.png?1280946765
[img8]: http://linuxers.org/sites/default/files/article-logo/1268632407_audio_wave.png?1268632487
[img9]: http://linuxers.org/sites/default/files/article-logo/FlashVideo_128px.png?1268632051