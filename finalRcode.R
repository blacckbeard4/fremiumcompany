#Final model after multiple training and validation cycles 
# Load libraries
library(dplyr)
library(caret)
library(rpart)
library(class)
library(pROC)
library(readr)
library(rpart.plot)
library(ROSE)
library(e1071)
library(writexl)
set.seed(4)

# Import data
data <- read_csv("/Users/justinvarghese/Downloads/XYZData.csv", col_names = TRUE)

# Rename factor levels of adopter for compatibility
data$adopter <- factor(data$adopter, levels = c(0, 1), labels = c("no", "yes"))

# Balance the data using both under- and over-sampling with ROSE
data_both <- ovun.sample(adopter ~ ., data = data, method = "both", p = 0.5, nrow(data))$data

# Set up cross-validation with 10 folds
train_control <- trainControl(method = "cv", number = 10, classProbs = TRUE, 
                              summaryFunction = twoClassSummary, savePredictions = "final")
tune_grid <- expand.grid(cp = seq(0.01, 0.1, by = 0.01))

# Model training with cross-validation
tree_model <- train(adopter ~ ., data = data_both[, 2:27], 
                    method = "rpart", 
                    trControl = train_control, 
                    metric = "ROC", 
                    tuneGrid = tune_grid)

# Display model details
print(tree_model)
prp(tree_model$finalModel, varlen = 0)

# Predict on full dataset to get probabilities and predicted classes
data$predicted_prob_positive <- predict(tree_model, data[, 2:27], type = "prob")[, "yes"]
data$predicted_class <- predict(tree_model, data[, 2:27])

# Evaluate model performance on ROC and AUC
roc_obj <- roc(data$adopter, data$predicted_prob_positive)
auc_value <- auc(roc_obj)
print(paste("AUC: ", auc_value))

# Plot ROC curve
plot(roc_obj, col = "#2c7bb6", lwd = 2, main = "ROC Curve")
abline(a = 0, b = 1, col = "grey", lty = 2)

# Cumulative Response Curve (CRC)
plot_df <- data %>% arrange(desc(predicted_prob_positive))

# Calculate cumulative response rate and % population
plot_df <- plot_df %>% 
  mutate(cumulative_positive = cumsum(as.numeric(adopter) - 1),
         cumulative_rate = cumulative_positive / max(cumulative_positive),
         percent_population = (1:n()) / n() * 100)

# Plot CRC with % of Population
plot(plot_df$percent_population, plot_df$cumulative_rate, type = "l", col = "blue", lwd = 2,
     xlab = "% of Population", ylab = "Cumulative Response Rate",
     main = "Cumulative Response Curve (CRC)")
abline(h = seq(0, 1, by = 0.2), col = "gray", lty = 3)
abline(v = seq(0, 100, by = 20), col = "gray", lty = 3)
lines(x = c(0, 100), y = c(0, 1), col = "red", lty = 2, lwd = 2)
legend("bottomright", legend = c("Model", "Random Predictor"),
       col = c("blue", "red"), lty = c(1, 2), lwd = 2)

# Save results
write_xlsx(data, "/Users/justinvarghese/Downloads/data_output.xlsx")
#Saving the tree
save(tree_model, file = "/Users/justinvarghese/Downloads/tree_model.RData")

