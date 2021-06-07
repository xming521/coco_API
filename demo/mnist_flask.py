import numpy as np
import logging, os

logging.disable(logging.WARNING)
os.environ["TF_CPP_MIN_LOG_LEVEL"] = "3"
import tensorflow as tf
from flask import Flask, jsonify, render_template, request


app = Flask(__name__)

@app.route('/api/mnist', methods=['POST'])
def mnist():
    input = ((255 - np.array(request.json, dtype=np.uint8)) / 255.0).reshape(1,28,28)
    new_model = tf.keras.models.load_model('/mnt/tensorflow_train/my_model')
    output1 = new_model.predict(input).tolist()[0]
    return jsonify(results=[output1, output1])


@app.route('/')
def main():
    return render_template('index.html')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000,debug=True)
