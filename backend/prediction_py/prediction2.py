import os
import sys 
import pandas as pandas
import csv
from keras.utils import to_categorical
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn import metrics
from keras.utils import to_categorical
from keras.models import Sequential
from keras.layers import Dense


'''
from sklearn.model_selection import train_test_split
from sklearn import metrics
from keras.utils import to_categorical
from keras.models import Sequential
from keras.layers import Dense
from matplotlib import pyplot as plt
from keras.callbacks import EarlyStopping, ModelCheckpoint
from TestCallback import TestCallback;
'''

def read_csv_data(csvFileName):
	cwd = os.getcwd()
	df = open(cwd+'\\' + 'prediction_py'+'\\'+csvFileName, 'r')
	#df = open(cwd+'\\' + '\\'+csvFileName, 'r')
	datareader = csv.reader(df, delimiter=';')
	next(datareader, None)	#Skip the header
	datasetList=[]

	for row in datareader:
		datasetList.append(row)
	datasetArr = np.asarray(datasetList)	#List to Array	
	return datasetArr

def get_input_column(dataArray):
	x_data = dataArray[:,:-1]			#x_train without label (eliminate label row)
	x_data = x_data.astype(np.int)
	return x_data;

def get_label_column(dataArray):		
	y_data = dataArray[:,10]			#y_train with the last column as label
	y_data = y_data.astype(np.int)
	num_classes = 8
	y_data = to_categorical(y_data, num_classes) 
	return y_data;

def prepare_data_x():
	data_array = read_csv_data('dataset2.csv')
	x_data = get_input_column(data_array)
	return x_data

def prepare_data_y():
	data_array = read_csv_data('dataset2.csv')
	y_data = get_label_column(data_array)
	return y_data

def prepare_data():
	x_train = prepare_data_x()
	y_train = prepare_data_y()
	#x_train, x_test, y_train, y_test = train_test_split(x_data, y_data, test_size=0.1, random_state=42, shuffle=True)
	#print(type(x_train))
	#print(type(y_train))
	data = []
	data.append(x_train)
	data.append(y_train)
	#np.append(data, [x_train], axis=0)	
	#np.append(data, [y_train], axis=0)	
	return data

def prepare_data_x_train():
	data = prepare_data()
	x_train = data[0]
	x_train = x_train.astype(np.int)
	#print(x_train.shape)
	return x_train

def prepare_data_y_train():
	data = prepare_data()
	y_train = data[1]
	y_train = y_train.astype(np.int)
	#print(y_train.shape)
	return y_train

def prepare_data_x_test():
  	#x_test = prepare_data_x_train()
 	#x_test = [[3,4,0,0,0,0,7,0,0,0]]
 	x_test = [[0,0,1,0,0,0,0,0,0,0]]
 	x_test = np.asarray(x_test)
 	return x_test

def prepare_data_y_test():
  	#y_test = prepare_data_y_train()
  	y_test = [[4]]
  	y_test = np.asarray(y_test)
  	num_classes = 8
  	y_test = to_categorical(y_test, num_classes) 
  	return y_test


def find_data_test(i, j):
	data_array = read_csv_data('dataset2.csv')
	data_array = data_array.astype(np.int)
	data_array = data_array[:,:-1]
	input_data = []
	for m in range(len(data_array)):
		if data_array[m][0]==i and data_array[m][1]==j:
			#NEXT MOVE INDEX I and INDEX J
			input_data = data_array[m]
			break
	input_list = [[input_data[0], input_data[1], input_data[2], input_data[3], input_data[4], input_data[5], input_data[6], input_data[7], input_data[8], input_data[9]]]
	input_array = np.asarray(input_list)
	return input_array


def build_prediction_model(x_train, y_train):
	# Prepare neural network model 
	model = Sequential()

	hidden_layer_1 = Dense(units=32, activation='relu', input_shape=(10,))
	#hidden_layer_2 = Dense(units=4, activation='relu')
	output_layer = Dense(units=8, activation='softmax')
	model.add(hidden_layer_1)
	#model.add(hidden_layer_2)
	model.add(output_layer)
	#model.summary()
	model.compile(optimizer='rmsprop',loss='categorical_crossentropy', metrics=['accuracy'])
	history = model.fit(x_train, y_train, batch_size=32, epochs=100, verbose=False)
	return model;




def make_prediction(test_data, model):
	predict_res = model.predict(test_data)
	predict_res = np.argmax(predict_res, axis=1)
	input_data = find_next_input(predict_res[0], test_data[0][0], test_data[0][1])
	input_list = [[input_data[0], input_data[1], input_data[2], input_data[3], input_data[4], input_data[5], input_data[6], input_data[7], input_data[8], input_data[9]]]
	input_array = np.asarray(input_list)
	return input_array
	

def find_next_input(adjacentNumber, currenti, currentj):
	i = find_index_row(adjacentNumber, currenti)	#Next move index i
	j = find_index_column(adjacentNumber, currentj)	#Next move index j 
	
	data_array = read_csv_data('dataset2.csv')
	data_array = data_array.astype(np.int)
	data_array = data_array[:,:-1]
	for m in range(len(data_array)):
		if data_array[m][0]==i and data_array[m][1]==j:
			#NEXT MOVE INDEX I and INDEX J
			input = data_array[m]
			#print(input)
			return input	



def find_index_row(adjacentNumber, currenti):
	switcher = {
		0: currenti,
		1: currenti-1,
		2: currenti-1,
		3: currenti-1,
		4: currenti,
		5: currenti+1,
		6: currenti+1,
		7: currenti+1,
	}
	return switcher.get(adjacentNumber, "Invalid adjacenet Number")


def find_index_column(adjacentNumber, currentj):
	switcher = {
		0: currentj+1,
		1: currentj+1,
		2: currentj,
		3: currentj-1,
		4: currentj-1,
		5: currentj-1,
		6: currentj,
		7: currentj+1,
	}
	return switcher.get(adjacentNumber, "Invalid adjacenet Number")




x_train = prepare_data_x_train()
y_train = prepare_data_y_train()
x_test = prepare_data_x_test()
y_test = prepare_data_y_test()
model = build_prediction_model(x_train, y_train)
#score = model.evaluate(x_test, y_test)
#print("%s: %.2f%%" % (model.metrics_names[1], score[1]*100))


indexRow = int(sys.argv[1])
indexColumn = int(sys.argv[2])

res = []
input_array = find_data_test(indexRow, indexColumn)
for k in range(5):
	input_array =  make_prediction(input_array, model)
	res.append(input_array[0][0])	
	res.append(input_array[0][1])

res = np.array(res)
print(res)
