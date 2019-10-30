import librosa
import numpy
import pandas as pd
import matplotlib
import os
import librosa
import csv
from sklearn.model_selection import train_test_split

directory=('C:/Users/hp/PycharmProjects/untitled1/wavfiles')
feature_matrix=numpy.empty([1,14])
dataset=pd.DataFrame()
id=1
names={}
filename = "birdsong_metadata.csv"
with open(filename, 'r') as csvfile:
    csvreader = csv.reader(csvfile)

    for row in csvreader:
        nam = "xc" + row[1] + ".wav"
        names[nam]=row[3]


for i in os.listdir(directory):
    print(i)

    audiosamples, samplerate=librosa.load('C:/Users/hp/PycharmProjects/untitled1/wavfiles/'+i)
    audiosamples=librosa.resample(audiosamples, samplerate, 8000)
    mfcc_features=librosa.feature.mfcc(y=audiosamples,sr= 8000, n_mfcc=13)
    print(mfcc_features.shape[1])
    a=numpy.transpose(mfcc_features)
    na=names[i]
    ad = numpy.full(( mfcc_features.shape[1],1), na)
    df1=pd.DataFrame(ad)
    df = pd.DataFrame(a)
    df['label'] = df1
    if id == 1:
        dataset=df.copy()
        id=0
    else:
        dataset=pd.concat([dataset,df])
    print(dataset)

dataset.to_csv('extractedfeatures.csv')



