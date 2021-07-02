# bilibili-evolved-afterwards
## 目的
合并从B站下载的分段 flv 视频文件 -- 在使用油猴脚本 [Bilibili-Evolved](https://github.com/the1812/Bilibili-Evolved, "the1812 / Bilibili-Evolved") 下载视频之后，很多视频分段成几个 flv 文件，原脚本并没有合并这些文件的功能。

## 用法：
- 下载 .sh 文件，将其与视频文件放在一起。
- 打开 terminal，让这个 .sh 文件可执行
  ```chmod +x mergeflv.sh```
- 执行这个 .sh 脚本。
```./mergeflv.sh```
- 合并之后原来的分段flv文件被存放在 finshed_folder 文件夹里。检查之后可以删除。
