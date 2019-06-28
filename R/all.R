dvrScan =
    function(f, bin = TRUE, exec = if(bin) "dvr-scan" else "python3 dvr-scan.py") {
         tt = system(sprintf('%s -so -i "%s"', exec, f), intern = TRUE)
         ans = tt[length(tt)]
         if(grepl("No motion", ans))
             return(character())
         else
             ans
     }

filenames = list.files(pattern = "Pexels_.*", recursive = TRUE)
ev = lapply(filenames, dvrScan)

dd = mapply(function(f, ev) {
    if(length(ev) == 0) 
        return(data.frame(file = f, start = NA, end = NA))

    tm = as.POSIXct(strptime(strsplit(ev, ",")[[1]], "%H:%M:%S"))
    numEvents = length(tm)/2
    data.frame(file = rep(f, numEvents),
               start = tm[ seq(1, length = numEvents, by = 2) ],
               end = tm[ seq(1, length = numEvents, by = 2) + 1 ],
               stringsAsFactors = FALSE)
       }, filenames, ev, SIMPLIFY = FALSE)

allEvents = do.call(rbind, dd)

allEvents$duration = allEvents$end - allEvents$start

#To run in parallel on a machine  mcmapply


