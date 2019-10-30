setwd("C:/Users/hp/Documents/R/ml")

names=read.csv('birdsong_metadata.csv')
objects(names)
data=names[,c(1,2,4)]
data




f = function(x) {
  
  rename=x[1]
  name = x[2]
  a=paste0("xc",name,".wav",sep='')
  b=paste0(rename,".wav",sep='')
  print(b)
  file.rename(a,b)
  rename=rename+1
  
  
  
}
apply(data, 1, f)


install.packages('soundgen')

library(tuneR)
library(seewave)
library(soundgen)



a<-readWave('xc25119.wav')
play(a)
b=acoustat(a)
b




analyze('xc25119.wav', samplingRate = NULL, dynamicRange = 80, silence = 0.04,
        scale = NULL, SPL_measured = 70, Pref = 2e-05, windowLength = 50,
        step = NULL, overlap = 50, wn = "gaussian", zp = 0,
        cutFreq = 6000, nFormants = 3, pitchMethods = c("autocor", "spec",
                                                        "dom"), entropyThres = 0.6, pitchFloor = 75, pitchCeiling = 3500,
        priorMean = 300, priorSD = 6, priorPlot = FALSE, nCands = 1,
        minVoicedCands = NULL, domThres = 0.1, domSmooth = 220,
        autocorThres = 0.7, autocorSmooth = NULL, cepThres = 0.3,
        cepSmooth = 400, cepZp = 0, specThres = 0.3, specPeak = 0.35,
        specSinglePeakCert = 0.4, specHNRslope = 0.8, specSmooth = 150,
        specMerge = 1, shortestSyl = 20, shortestPause = 60,
        interpolWin = 75, interpolTol = 0.3, interpolCert = 0.3,
        pathfinding = c("none", "fast", "slow")[2], annealPars = list(maxit =
                                                                        5000, temp = 1000), certWeight = 0.5, snakeStep = 0.05,
        snakePlot = FALSE, smooth = 1, smoothVars = c("pitch", "dom"),
        summary = FALSE, summaryFun = c("mean", "median", "sd"),
        plot = TRUE, showLegend = TRUE, savePath = NA, plotSpec = TRUE,
        pitchPlot = list(col = rgb(0, 0, 1, 0.75), lwd = 3),
        candPlot = list(), ylim = NULL, xlab = "Time, ms", ylab = "kHz",
        main = NULL, width = 900, height = 500, units = "px", res = NA)













play(b)
b=melfcc(a)
deltas(b)