import librosa #a python package for music and sound analysis
import numpy
import pandas as pd
import os
import csv


directory=('C:/Users/hp/PycharmProjects/untitled1/wavfiles') #Specifying path to wavfiles directory

dataset=pd.DataFrame()#creating an empty dataframe
''' The below loop opens birdsong_metadata.csv file and takes the file_id and 
the name of corresponding species stores it in a 'names' dictionary '''
id=1
names={}
filename = "birdsong_metadata.csv"
with open(filename, 'r') as csvfile:
    csvreader = csv.reader(csvfile)

    for row in csvreader: #each row in the csv file
        nam = "xc" + row[1] + ".wav"  #row[1] is file id which is appended with xc and used it as a key for dictionary
        names[nam]=row[3] #row[3] is the corresponding species name



for i in os.listdir(directory): #for each wav file 
    print(i)

    audiosamples, samplerate=librosa.load('C:/Users/hp/PycharmProjects/untitled1/wavfiles/'+i) #loading the audio file
    audiosamples=librosa.resample(audiosamples, samplerate, 8000) # resampling audio to a fixed sample rate
    mfcc_features=librosa.feature.mfcc(y=audiosamples,sr= 8000, n_mfcc=13)
   
    a=numpy.transpose(mfcc_features) #transposing the mfcc_features 
    na=names[i] #getting name of the species of that wav
    ad = numpy.full(( mfcc_features.shape[1],1), na)#mfcc_features.shape[1] tells the no of times mfcc features were extracted
    print(ad)
    df1=pd.DataFrame(ad)
    df = pd.DataFrame(a)#this data frame contains all feature vectors extracted from the present wav file
    df['label'] = df1 #this dataframe contains the same name of the species repeated 'mfcc_features.shape[1]' times
    if id == 1: # this block satisfies only once in the begining
        dataset=df.copy() #to intialize the dataset for the first time. This line runs only once at the begining and then id set to 0
        id=0
    else:
        dataset=pd.concat([dataset,df]) #appends the dataset with feature vectors and label of the present wavfile(so, all the vectors that are taken from same wav file will have the same label)

dataset.to_csv('extractedfeatures.csv') #output it to csv file







