
R CMD INSTALL VideoEvents

install.packages("VideoEvents", repos = ".")

From github
devtools::github_install()

```
library(VideoEvents)
```

```
dvrScan(system.file("videos/Other/54.mp4", package = "VideoEvents"))
```

To process all the videos in a 
```
processVideos("inst", exec = "python3 ../DVR-Scan-1.0.1/dvr-scan.py")
```

```
dvrScan("inst/videos/Other/54.mp4", , "python3 ../DVR-Scan-1.0.1/dvr-scan.py")
```
