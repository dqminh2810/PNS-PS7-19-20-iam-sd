import keras

class TestCallback(keras.callbacks.callbacks.Callback):
    def __init__(self, x_test, y_test):
        self.x_test = x_test
        self.y_test = y_test
        self.test_loss = []
        self.test_accuracy = []


    def on_epoch_end(self, epoch, logs={}):
        x = self.x_test
        y = self.y_test
        loss, acc = self.model.evaluate(x, y, verbose=0)
        self.test_loss.append(loss)
        self.test_accuracy.append(acc)
        #print('\nTesting loss: {}, Testing acc: {}\n'.format(loss, acc))