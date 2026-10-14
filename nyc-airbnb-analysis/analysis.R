# ==============================================================================
# PROGETTO ANALISI DATASET AIRBNB NYC
# Script basato sugli argomenti del corso: Logit, Performance, Ensemble e Text
# ==============================================================================

# Pacchetti per la manipolazione dati e grafici
install.packages("tidyverse")

# Pacchetti per la Regressione Logistica, Campionamento e Performance
install.packages("caret")
install.packages("pROC")

# Pacchetti per Alberi Decisionali e Metodi Ensemble (Random Forest)
install.packages("rpart")
install.packages("rpart.plot")
install.packages("randomForest")

# Pacchetti per Naive Bayes e analisi del testo
install.packages("e1071")
install.packages("tidytext")

# 1. CARICAMENTO LIBRERIE
library(tidyverse)   # Manipolazione dati e ggplot2
library(caret)       # Campionamento e matrici di confusione
library(pROC)        # Curve ROC e AUC
library(rpart)       # Alberi decisionali
library(rpart.plot)  # Visualizzazione alberi
library(randomForest)# Metodi Ensemble
library(tidytext)    # Text Mining
library(e1071)       # Supporto per Naive Bayes

# 2. CARICAMENTO E PULIZIA DATI
# (Assicurati che il percorso del file sia corretto per il tuo ambiente)
df <- read_excel("AB_NYC_2019.xlsx")

df_clean <- df %>%
  # Forza la colonna a essere numerica (trasforma eventuali testi in numeri)
  mutate(reviews_per_month = as.numeric(reviews_per_month)) %>%
  # Ora la gestione NA funzionerà perché la colonna è numerica
  mutate(reviews_per_month = replace_na(reviews_per_month, 0)) %>%
  # Feature Engineering: variabile Target binaria
  mutate(high_price = as.factor(ifelse(price > median(price, na.rm = TRUE), 1, 0))) %>%
  # Rendiamo i fattori espliciti
  mutate(neighbourhood_group = as.factor(neighbourhood_group),
         room_type = as.factor(room_type)) %>%
  filter(price > 0 & price < 1000)

# ------------------------------------------------------------------------------
# 3. CAMPIONAMENTO STRATIFICATO
# Perché: Per mantenere la proporzione di 'high_price' tra train e test set
# ------------------------------------------------------------------------------
set.seed(123) # Per riproducibilità
train_index <- createDataPartition(df_clean$high_price, p = 0.7, list = FALSE)
train_set <- df_clean[train_index, ]
test_set  <- df_clean[-train_index, ]

# ------------------------------------------------------------------------------
# 4. REGRESSIONE LOGISTICA E MODELLAZIONE PREDITTIVA
# ------------------------------------------------------------------------------
# Stima del modello logit
logit_model <- glm(high_price ~ neighbourhood_group + room_type + number_of_reviews + availability_365, 
                   data = train_set, family = binomial)

# Selezione delle variabili Stepwise (AIC)
logit_step <- step(logit_model, direction = "both")

# Calcolo degli Odds Ratios (Esponenziale dei coefficienti)
# Perché: Interpretare quanto una variabile aumenta la probabilità di un prezzo alto
odds_ratios <- exp(coef(logit_step))
print(odds_ratios)

# ------------------------------------------------------------------------------
# 5. VALUTAZIONE DELLE PERFORMANCE
# ------------------------------------------------------------------------------
# Previsioni sul test set (probabilità)
pred_prob <- predict(logit_step, newdata = test_set, type = "response")
# Conversione in classi (soglia standard 0.5)
pred_class <- as.factor(ifelse(pred_prob > 0.5, 1, 0))

# Matrice di Confusione
conf_matrix <- confusionMatrix(pred_class, test_set$high_price)
print(conf_matrix)

# Curva ROC e AUC
roc_obj <- roc(test_set$high_price, pred_prob)
plot(roc_obj, col = "blue", main = paste("Curva ROC - AUC:", round(auc(roc_obj), 3)))


# ------------------------------------------------------------------------------
# 6. METODI ENSEMBLE E ALBERI (Decision Trees & Random Forest)
# ------------------------------------------------------------------------------
# Costruzione Albero Decisionale
tree_model <- rpart(high_price ~ neighbourhood_group + room_type + availability_365, 
                    data = train_set, method = "class")
rpart.plot(tree_model, main = "Albero di Classificazione Prezzi Airbnb")


# Random Forest (Variable Importance)
# Nota: utilizziamo un subset per velocità di calcolo se il dataset è grande
rf_model <- randomForest(high_price ~ neighbourhood_group + room_type + availability_365, 
                         data = train_set %>% sample_n(2000), importance = TRUE)
varImpPlot(rf_model, main = "Importanza delle Variabili (Random Forest)")


# ------------------------------------------------------------------------------
# 7. SENTIMENT ANALYSIS E TEXT MINING SUI TITOLI (Colonna 'name')
# ------------------------------------------------------------------------------
# Tokenizzazione e pulizia parole
text_analysis <- df_clean %>%
  select(id, neighbourhood_group, name) %>%
  unnest_tokens(word, name) %>%
  anti_join(stop_words) # Rimozione parole vuote (es. "the", "and")

# Frequenza parole per i Top 2 Quartieri (Analisi Comparativa)
text_analysis %>%
  filter(neighbourhood_group %in% c("Manhattan", "Brooklyn")) %>%
  group_by(neighbourhood_group) %>%
  count(word, sort = TRUE) %>%
  slice_max(n, n = 10) %>%
  ggplot(aes(x = n, y = reorder(word, n), fill = neighbourhood_group)) +
  geom_col() +
  facet_wrap(~neighbourhood_group, scales = "free") +
  labs(title = "Top 10 parole usate negli annunci", x = "Frequenza", y = "Parola")

# ------------------------------------------------------------------------------
# CONCLUSIONI
# In questo script abbiamo:
# 1. Pulito i dati e creato una variabile target (high_price).
# 2. Addestrato una Regressione Logistica valutando Odds Ratios e Stepwise.
# 3. Misurato le performance con Confusion Matrix e ROC/AUC.
# 4. Confrontato i risultati con Alberi Decisionali e Random Forest.
# 5. Analizzato il testo degli annunci per trovare pattern nei nomi.
