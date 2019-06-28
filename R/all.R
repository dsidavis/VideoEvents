dvrScan =
    #
    # dvrScan(system.file("videos/Other/54.mp4", package = "VideoEvents")
    # dvrScan("inst/videos/Other/54.mp4", , "python3 ../DVR-Scan-1.0.1/dvr-scan.py")
    #
    #
function(f, bin = TRUE, exec = if(bin) "dvr-scan" else "python3 dvr-scan.py", verbose = FALSE)
{
    if(verbose)
       message("DVR-Scan for ", f)
    tt = system(sprintf('%s -so -i "%s"', exec, f), intern = TRUE)
    ans = tt[length(tt)]
    if(grepl("No motion", ans))
        return(character())
    else
        ans
}

events2DataFrame =
function(ev, f = NA)
{
    if(length(ev) == 0) 
        return(data.frame(file = f, start = as.POSIXct(NA), end = as.POSIXct(NA)))

    tm = as.POSIXct(strptime(strsplit(ev, ",")[[1]], "%H:%M:%S"))
    numEvents = length(tm)/2
    data.frame(file = rep(f, numEvents),
               start = tm[ seq(1, length = numEvents, by = 2) ],
               end = tm[ seq(1, length = numEvents, by = 2) + 1 ],
               stringsAsFactors = FALSE)
   }


processVideos =
    # To run in parallel on a machine  mcmapply
function(dir, filenames = list.files(dir, recursive = TRUE, full.names = TRUE), ...)
{
    ev = lapply(filenames, dvrScan, ...)
    dd = mapply(events2DataFrame, ev, filenames, SIMPLIFY = FALSE)
    allEvents = do.call(rbind, dd)
    allEvents$duration = allEvents$end - allEvents$start

    allEvents
}



