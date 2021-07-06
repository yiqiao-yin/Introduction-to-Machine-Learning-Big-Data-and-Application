# Representation Learning

There are three major types of *Representation Learning*.

## Artificial Neural Network

The architecture of a basic Artificial Neural Network (ANN) is the following
$$
\text{input variables:} \rightarrow
[\vdots] \rightarrow [\vdots]
\rightarrow
\text{output: predictions}
$$

$$\begin{array}{l}
a \\
b \\
\end{array}$$



- *Regressor*: This type of ANN learns from $X$ and produces an estimated value of $Y$ while $Y$ is continuous. The common loss function is [MSE](https://towardsdatascience.com/https-medium-com-chayankathuria-regression-why-mean-square-error-a8cad2a1c96f). In a neural network architecture that is designed as a regressor (predict a continuous variable, i.e. like regression model), we output one neuron.
$$
\text{input variables:} \rightarrow
[\vdots] \rightarrow [\vdots]
\rightarrow
[.], 
\text{output: predictions}
$$

- *Classifier*: This type of ANN learns from $X$ and produes an estimated probability of $Y$ that is a particular discrete value (aka factor or class). The common loss function is [binary cross-entropy](https://towardsdatascience.com/understanding-binary-cross-entropy-log-loss-a-visual-explanation-a3ac6025181a). For a neural network architecture that is designed as a classifier (predict a discrete variable, a class, or a label, i.e. like logistic model), we output a certain number of neurons (number should match the number of levels in the response variable). 
$$
\text{input variables:} \rightarrow
[\vdots] \rightarrow [\vdots]
\rightarrow
[:], 
\text{output: predictions}
$$
The above architecture assumes two-class classification (the output has two dots).
- *Optimizer*: The architecture of an ANN consists of input layer (which is the explanatory variables), hidden layer (if any), the output layer (tailored to the type of problems, regressor or classifier), and a loss function. Once the architecture is setup we can use an optimizer to find the weights that are used in the optimizer. A famous optimizer is called [gradient descent](https://towardsdatascience.com/gradient-descent-explained-9b953fc0d2c). Here are some videos I posted: [Gradient Descent](https://www.youtube.com/watch?v=OtLSnzjT5ns), [Adam](https://www.youtube.com/watch?v=AqzK8LeRThM), [ANN Regressor Classifier Summary](https://www.youtube.com/watch?v=zhBLiMdqOdQ), related python scripts are posted [here](https://www.github.com/yiqiao-yin/YinsPy)

## Convolutional Neural Network

Some additional sources:
- Computer Vision Feature Extraction: [post](https://towardsdatascience.com/computer-vision-feature-extraction-101-on-medical-images-part-1-edge-detection-sharpening-42ab8ef0a7cd)

## Recurrent Neural Network
