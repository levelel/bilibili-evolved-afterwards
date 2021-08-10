# bilibili-evolved-afterwards
## 注意
仅适用于 Linux 系统。威联通（Qnap） NAS 的系统（虽然也是 Linux 可是好像魔改过 😓，其他品牌的 NAS 系统没有试过）和 MacOS 等 BSD 系统由于 find 等命令用法不同，不能用这个脚本。非要用的话，可以安装个 Linux 虚拟机或 docker 来使用。

## 目的
合并从B站下载的分段 flv 视频文件 -- 在使用油猴脚本 [Bilibili-Evolved](https://github.com/the1812/Bilibili-Evolved "the1812 / Bilibili-Evolved") 下载视频之后，很多视频分段成几个 flv 文件，原脚本并没有合并这些文件的功能。
更新：现在支持其他格式的文件，只要ffmpeg支持且文件名以``` - 02.mkv```这样的格式结尾即可。

## 用法：
- 前提：在系统中安装有 ffmpeg 。并放在 /usr/bin/ffmpeg
- 下载 .sh 文件，将其与视频文件放在一起。
- 打开 terminal，让这个 .sh 文件可执行
  ```chmod +x mergeflv.sh```
- 执行这个 .sh 脚本。可能需要输入管理员密码。
```sudo ./mergeflv.sh``` 如果要合并的是其他格式的文件，可以在后面加上文件后缀，如 ```sudo ./mergeflv.sh mkv```就会合并 mkv 文件
- 合并之后原来的分段 flv 文件被存放在 finshed_folder 文件夹里。检查之后可以删除。
