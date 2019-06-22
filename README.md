# ytbDown : Download youtube videos from Terminal (v0.1)

## Example:
To download the video : `https://www.youtube.com/watch?v=`**`a6bBbTWgxCU`**
```bash
ytbDown -d a6bBbTWgxCU
```
*This will generate **a6bBbTWgxCU.mp4** on the current directory.*

**You can change the name of the created file by adding -n option :**
```bash
ytbDown -n myvideo -d a6bBbTWgxCU
```
*This will generate **myvideo.mp4** on the current directory.*


## Usage :

```bash
Usage: ./ytbDownloader [-n <fileName>] -d <videoId>
-h            : Show help
-d <videoId>  : Downloads youtube video with id <videoId>
-n <fileName> : Sets the name of the downloaded video to <fileName> (<videoID> is default name)
```
## Installation : 

```bash
git clone https://github.com/yassram/ytbDown.git
cd ytbDown
./install.sh
```

## Features :
* [x] Download any youtube video from terminal
* [x] Specify a name for the file
* [ ] Choose video quality
* [ ] Download full playlist
* [ ] Download full user videos
* [ ] Convert videos to mp3 files

