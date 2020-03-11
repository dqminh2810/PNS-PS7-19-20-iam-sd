import os
import sys 
import pandas as pandas
import csv
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn import metrics
from keras.utils import to_categorical
from keras.models import Sequential
from keras.layers import Dense
from matplotlib import pyplot as plt
from keras.callbacks import EarlyStopping, ModelCheckpoint
from TestCallback import TestCallback;



'''
df = pandas.read_csv(cwd+'\\' + 'dataset.csv', sep=',')
dataset = df.values
print(dataset.shape)
'''

# Get argument to make 
lati = float(sys.argv[1])
longi = float(sys.argv[2])
distanceA = float(sys.argv[3])
distanceB = float(sys.argv[4])
distanceC = float(sys.argv[5])
distanceD = float(sys.argv[6])

data_test = np.array([lati, longi, distanceA, distanceB, distanceC, distanceD])



cwd = os.getcwd()
#print(cwd)
df = open(cwd+'\\' + 'prediction_py'+'\\'+'dataset.csv', 'r')
#df = open(cwd+'\\' + '\\'+'dataset.csv', 'r')
datareader = csv.reader(df, delimiter=';')
next(datareader, None)	#Skip the header
datasetList=[]

for row in datareader:
	datasetList.append(row)

# Prepare list dataset, String to array and eliminate ';' (first row) - String to float (distance row)
for i in range(len(datasetList)):
	datasetList[i][0] = float(datasetList[i][0])
	datasetList[i][1] = float(datasetList[i][1])
	datasetList[i][2] = float(datasetList[i][2])
	datasetList[i][3] = float(datasetList[i][3])
	datasetList[i][4] = float(datasetList[i][4])
	datasetList[i][5] = float(datasetList[i][5])


datasetArr = np.asarray(datasetList)	#List to Array
x_data = datasetArr[:,:-1]			#x_train without label (eliminate label row)
y_data = datasetArr[:,6]			#y_train with the last column as label

x_data = x_data.astype(np.float)	#Convert array element type String to float 


#Convert label type String to int 
for i in range(len(y_data)):
	if y_data[i]=="A" :
		y_data[i]=0
	elif y_data[i]=="B" :
		y_data[i]=1
	elif y_data[i]=="C" :
		y_data[i]=2
	elif y_data[i]=="D" :
		y_data[i]=3
		

#Prepare training data, valid data and test data
x_train, x_test, y_train, y_test = train_test_split(x_data, y_data, test_size=0.30, random_state=42, shuffle=True)
# Convert to "one-hot" vectors using the to_categorical function
num_classes = 4 	# A, B, C or D
y_train = to_categorical(y_train, num_classes) 
y_test = to_categorical(y_test, num_classes) 



'''
print(x_train.shape)
print(x_valid.shape)
print(x_test.shape)
print(y_train.shape)
print(y_valid.shape)
print(y_test.shape)
'''

# Prepare neural network model 
model = Sequential()

hidden_layer_1 = Dense(units=32, activation='relu', input_shape=(6,))
hidden_layer_2 = Dense(units=4, activation='relu')
output_layer = Dense(units=4, activation='softmax')

model.add(hidden_layer_1)
#model.add(hidden_layer_2)

model.add(output_layer)

#model.summary()
model.compile(optimizer='rmsprop',loss='categorical_crossentropy', metrics=['accuracy'])

#Fit data to model and split test dataset to valid dataset
es = EarlyStopping(monitor='val_loss', mode='min', patience=10)
mc = ModelCheckpoint('best_model', monitor='val_loss')
testCallback = TestCallback(x_test, y_test)

history = model.fit(x_train, y_train, batch_size=32, epochs=10, callbacks=[es, mc, testCallback], validation_split=0.5, verbose=False)

#Evaluate Model
#score = model.evaluate(x_test,y_test)
#print("%s: %.2f%%" % (model.metrics_names[1], score[1]*100))

#Prediction on test dataset and evaluate
predictions = model.predict(x_test);
predictions = np.argmax(predictions, axis=1)
y_test = np.argmax(y_test, axis=1)

#print("Confusion matrix:\n%s" % cm)

#print(history.history.keys())

data_predictions = model.predict(np.reshape(data_test, (1, 6)))
data_predictions = np.argmax(data_predictions, axis=1)

event_predict = ''

if data_predictions[0]==0: 
	event_predict='A'
elif data_predictions[0]==1: 
	event_predict='B'
elif data_predictions[0]==2: 
	event_predict='C'
elif data_predictions[0]==3: 
	event_predict='D'
print("According to the system prediction, the visitor being at position "+str(data_test[0])+' - '+str(data_test[1])+" will be present at event "+event_predict+" for 1 hour later.")
#print("lat: "+str(x_test[32][0])+" - long: "+str(x_test[32][1]))

'''
# summarize history for accuracy
plt.figure(1)
plt.plot(history.history['accuracy'])
plt.plot(history.history['val_accuracy'])
plt.plot(testCallback.test_accuracy)
plt.title('model accuracy')
plt.ylabel('accuracy')
plt.xlabel('epoch')
plt.legend(['train', 'validation', 'test'], loc='upper left')

# summarize history for loss
plt.figure(2)
plt.plot(history.history['loss'])
plt.plot(history.history['val_loss'])
plt.plot(testCallback.test_loss)
plt.title('model loss')
plt.ylabel('loss')
plt.xlabel('epoch')
plt.legend(['train', 'validation', 'test'], loc='upper left')


plt.figure(figsize=(5,5))
plt.imshow(cm, interpolation='nearest', cmap='Pastel1')
plt.title('Confusion matrix', size = 15)
plt.colorbar()
tick_marks = np.arange(10)
plt.xticks(tick_marks, ["A", "B", "C", "D"], rotation=45, size = 4)
plt.yticks(tick_marks, ["A", "B", "C", "D"], size = 4)
plt.tight_layout()
plt.ylabel('Actual label', size = 15)
plt.xlabel('Predicted label', size = 15)
width, height = cm.shape

xrange = range

for x in xrange(width):
    for y in xrange(height):
        plt.annotate(str(cm[x][y]), xy=(y, x), 
                    horizontalalignment='center',
                    verticalalignment='center')
plt.show()
'''
