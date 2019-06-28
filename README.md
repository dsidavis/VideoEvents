
R CMD INSTALL VideoEvents

install.packages("VideoEvents", repos = ".")

From github
devtools::github_install()


Load the package to get the 3 functions:
```
library(VideoEvents)
```

Process a single video. We'll use the one of the rug that is included in the package
```
f = system.file("videos/Other/54.mp4", package = "VideoEvents")
dvrScan(f)
```
This assumes the dvr-scan command is available in your path as a regular executable.
I don't have it installed so I have to call python3 dvr-scan.py and I have to specify
where the dvr-scan.py file is so I call the R dvrScan() function as 
```
e = dvrScan(f, exec = "python3 ../DVR-Scan-1.0.1/dvr-scan.py")
```
Given the result, we can convert it to a data frame with
```
e = events2DataFrame(e, f)
```
This video has no events, so we end up with a row with NAs.


To process all the videos in a directory and its subdirectories and convert the events to a data
frame all in one step, use the processVideos() function:
```
processVideos("inst", exec = "python3 ../DVR-Scan-1.0.1/dvr-scan.py")
```
