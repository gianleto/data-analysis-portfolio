# ==============================================================================
# AIRBNB NYC DATASET ANALYSIS PROJECT
# Script based on the course topics: Logit, Performance, Ensemble and Text
# ==============================================================================
 
# Required packages: run the lines below once to install them, then re-comment
# (uncomment by removing the leading '#')
 
# Packages for data manipulation, plotting and reading Excel files
# install.packages("tidyverse")
# install.packages("readxl")
 
# Packages for Logistic Regression, Sampling and Performance
# install.packages("caret")
# install.packages("pROC")
 
# Packages for Decision Trees and Ensemble Methods (Random Forest)
# install.packages("rpart")
# install.packages("rpart.plot")
# install.packages("randomForest")
 
# Packages for Naive Bayes and text analysis
# install.packages("e1071")
# install.packages("tidytext")
 
# 1. LOADING LIBRARIES
library(tidyverse)   # Data manipulation and ggplot2
library(readxl)      # Reading Excel files
library(caret)       # Sampling and confusion matrices
library(pROC)        # ROC curves and AUC
library(rpart)       # Decision trees
library(rpart.plot)  # Tree visualisation
library(randomForest)# Ensemble methods
library(tidytext)    # Text Mining
library(e1071)       # Support for Naive Bayes
 
# 2. DATA LOADING AND CLEANING
# The dataset (AB_NYC_2019) is not included in this repository: download it
# (e.g. from Kaggle), save it as an Excel file named "AB_NYC_2019.xlsx" in the
# same folder as this script and set that folder as the working directory.
df <- read_excel("AB_NYC_2019.xlsx")
 
df_clean <- df %>%
  # Outlier removal: keep only prices between 1 and 1000 dollars.
  # This is done BEFORE computing the median so that the target classes
  # are balanced on the data actually used for modelling.
  filter(price > 0 & price < 1000) %>%
  # Force the column to be numeric (converts any text values into numbers)
  mutate(reviews_per_month = as.numeric(reviews_per_month)) %>%
  # NA handling now works because the column is numeric
  mutate(reviews_per_month = replace_na(reviews_per_month, 0)) %>%
  # Feature Engineering: binary target variable (median as threshold)
  mutate(high_price = as.factor(ifelse(price > median(price, na.rm = TRUE), 1, 0))) %>%
  # Make the factors explicit
  mutate(neighbourhood_group = as.factor(neighbourhood_group),
         room_type = as.factor(room_type))
 
# ------------------------------------------------------------------------------
# 3. STRATIFIED SAMPLING
# Why: To keep the proportion of 'high_price' the same in the train and test sets
# ------------------------------------------------------------------------------
set.seed(123) # For reproducibility
train_index <- createDataPartition(df_clean$high_price, p = 0.7, list = FALSE)
train_set <- df_clean[train_index, ]
test_set  <- df_clean[-train_index, ]
 
# ------------------------------------------------------------------------------
# 4. LOGISTIC REGRESSION AND PREDICTIVE MODELLING
# ------------------------------------------------------------------------------
# Fit the logit model
logit_model <- glm(high_price ~ neighbourhood_group + room_type + number_of_reviews + availability_365, 
                   data = train_set, family = binomial)
 
# Stepwise variable selection (AIC)
logit_step <- step(logit_model, direction = "both")
 
# Calculation of Odds Ratios (exponential of the coefficients)
# Why: To interpret how much a variable increases the probability of a high price
odds_ratios <- exp(coef(logit_step))
print(odds_ratios)
 
# ------------------------------------------------------------------------------
# 5. PERFORMANCE EVALUATION
# ------------------------------------------------------------------------------
# Predictions on the test set (probabilities)
pred_prob <- predict(logit_step, newdata = test_set, type = "response")
# Conversion into classes (standard threshold 0.5)
pred_class <- as.factor(ifelse(pred_prob > 0.5, 1, 0))
 
# Confusion Matrix
conf_matrix <- confusionMatrix(pred_class, test_set$high_price)
print(conf_matrix)
 
# ROC Curve and AUC
roc_obj <- roc(test_set$high_price, pred_prob)
plot(roc_obj, col = "blue", main = paste("ROC Curve - AUC:", round(auc(roc_obj), 3)))
 
 
# ------------------------------------------------------------------------------
# 6. ENSEMBLE METHODS AND TREES (Decision Trees & Random Forest)
# ------------------------------------------------------------------------------
# Build the Decision Tree
tree_model <- rpart(high_price ~ neighbourhood_group + room_type + availability_365, 
                    data = train_set, method = "class")
rpart.plot(tree_model, main = "Airbnb Price Classification Tree")
 
 
# Random Forest (Variable Importance)
# Note: we use a subset for computation speed if the dataset is large
rf_model <- randomForest(high_price ~ neighbourhood_group + room_type + availability_365, 
                         data = train_set %>% sample_n(2000), importance = TRUE)
varImpPlot(rf_model, main = "Variable Importance (Random Forest)")
 
 
# ------------------------------------------------------------------------------
# 7. SENTIMENT ANALYSIS AND TEXT MINING ON LISTING TITLES (Column 'name')
# ------------------------------------------------------------------------------
# Tokenisation and word cleaning
text_analysis <- df_clean %>%
  select(id, neighbourhood_group, name) %>%
  unnest_tokens(word, name) %>%
  anti_join(stop_words) # Remove stop words (e.g. "the", "and")
 
# Word frequency for the Top 2 boroughs (Comparative Analysis)
text_analysis %>%
  filter(neighbourhood_group %in% c("Manhattan", "Brooklyn")) %>%
  group_by(neighbourhood_group) %>%
  count(word, sort = TRUE) %>%
  slice_max(n, n = 10) %>%
  ggplot(aes(x = n, y = reorder(word, n), fill = neighbourhood_group)) +
  geom_col() +
  facet_wrap(~neighbourhood_group, scales = "free") +
  labs(title = "Top 10 words used in listings", x = "Frequency", y = "Word")
 
# ------------------------------------------------------------------------------
# CONCLUSIONS
# In this script we:
# 1. Cleaned the data and created a target variable (high_price).
# 2. Trained a Logistic Regression, evaluating Odds Ratios and Stepwise selection.
# 3. Measured performance with the Confusion Matrix and ROC/AUC.
# 4. Compared the results with Decision Trees and Random Forest.
# 5. Analysed the text of the listings to find patterns in the titles.
# 5. Analysed the text of the listings to find patterns in the titles.tern nei nomi.
