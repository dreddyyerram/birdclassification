"# birdclassification" 
Bird Classification using machine learning

Input Dataset:
	- bird audio files in FLAC format (present in songs folder)
	- 'birdsong_metadata.csv' : This file contains all details(file_id, genus, species, english_cname, who_provided_recording, country, latitude, longitute, type, license) of each Bird audio files
Note: each audio file is named in this format "xc<file_id>". This <file_id> is present in the csv which gives details about the audio.


Step 1:
	- Convert all the FLAC files to WAV files using an online tool 
	- After converting, trim only that particular segment of audio where we can hear the bird sound without much noise.
	- Name the file accordingly and store it in wavfiles folder

Step 2: Extracting feature vector from audio files
	- Extraction is done by the 'featureextraction.py' file
	- 'extractedfeatures.csv' file is the generated dataset(it contains 14 columns: 13 MFCC features , Bird Label)
	- 'featureextraction.py' file takes each wav file, resamples it and extracts MFCC features for every small chunk of audio segment of one wav file and append them to the dataset with the corresponding bird label from 'birdsong_metadata.csv'.
	- This way one audio file produces more than one row of data in 'extractedfeatures.csv'

  
