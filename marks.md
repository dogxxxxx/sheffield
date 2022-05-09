Overall, this report shows a good understanding of document representation, model training and parameter tuning, with fair justifications. However, it:
1. Miss the implementation of BOW+BOCN with raw counts.
2. Lack an in-depth comparison and reasoning of models using different feature spaces. 
3. Lack of reasoning on choices of parameters.
4. Chose best hyperarameters with regards to the performance on test dataset.

The following is the detailed comments and marks.
  Text processing methods for extracting Bag-Of-Word features (2.5 marks):
    Successfully extract the ngrams. However, the incorrect creation of vocabulary makes the preprocessing and vectorization unconvinced.
      Correct implementation to extract ngrams.
      
      Incorrect creation of vocabulary. For example, the Keep_topN is set to 55, how come the vocabulary has a total of 919 elements when we show the length of vocab? 
      Also, why are there only 1 and 2 grams in vocab when you have 1-3 grams as the argument? 
      It is better to deal with the documents one by one instead of merging them from the start. 2 mark reduction.
      
      Miss the implementation of BOW+BOCN with raw counts. 0.5 mark reduction.
      
  Binary Logistic Regression (LR) classifiers (5 marks)
    Beautiful tables for showing the results. Showing a good understanding of training process. However,
      The place you add L2 regularization in binary_loss function is incorrect. It should not be added after the mean of total loss in a batch.
      Also, the gradient of weights fails to incorporate the term from L2 regularizition. 1 mark reduction.
        
  Discuss how did you choose hyperparameters (1 mark).
    Experiment with different combinations of hyperparameters, but lack of in-depth explanation of why such settings are chosen. 1 mark reduction.
  
  After training each LR model, plot the learning process (i.e. training and validation loss in each epoch) using a line plot.
  Does your model underfit, overfit or is it about right? Explain why. (1 mark).
    Show a good understanding of overfitting and underfitting.
    
  Identify and show the most important features (model interpretability) for each class (i.e. top-10 most positive and top-10 negative weights).
  Give the top 10 for each class and comment on whether they make sense (if they don't you might have a bug!). 
  If you were to apply the classifier into a different domain such laptop reviews or restaurant reviews, do you think these features would generalise well?
  Can you propose what features the classifier could pick up as important in the new domain? (2 marks)
    Show good justifications for the model and reasoning on new domain with intuition.
  
  Provide well documented and commented code describing all of your choices. In general, you are free to make decisions about text processing
  (e.g. punctuation, numbers, vocabulary size) and we expect to see justifications for your choices (0.5 marks).
    Lack sufficient and clear comments on the code. Also, no justification for the choices of parameters. 1.5 marks reduction
  
  Provide efficient solutions. Executing the whole notebook with your solutions should take around 5-10 minutes excluding hyperparameter tuning runs (1 mark)
    Inefficiently using loops to create tf-idf features for documents. 0.5 mark reduction.
    
    Fail to use Counter object provided by the assignment to count and store the frequencies. 0.5 mark reduction.
