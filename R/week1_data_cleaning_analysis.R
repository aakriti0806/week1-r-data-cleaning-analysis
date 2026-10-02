# ============================================================
# Week 1 Task: Data Cleaning and Preliminary Analysis with R
# Author: Aakriti
# Dataset: Titanic Passenger Dataset
# ============================================================

# ------------------------------------------------------------
# 1. Install and load required packages
# ------------------------------------------------------------

# Run these only once if packages are not installed
# install.packages("tidyverse")
# install.packages("ggplot2")
# install.packages("corrplot")

library(farver)
library(ggplot2)
library(tidyverse)
library(corrplot)
# ------------------------------------------------------------
# 2. Load dataset
# ------------------------------------------------------------

titanic <- read.csv("C:/Users/HP/Desktop/yuvaIntern/task1/data/titanic_dataset_Raw.csv")

# ------------------------------------------------------------
# 3. Initial inspection
# ------------------------------------------------------------

head(titanic)

str(titanic)

summary(titanic)

dim(titanic)

# ------------------------------------------------------------
# 4. Missing value analysis
# ------------------------------------------------------------

missing_values <- colSums(is.na(titanic))
print(missing_values)

missing_percentage <- round(
  colSums(is.na(titanic)) / nrow(titanic) * 100,
  2
)

print(missing_percentage)

# ------------------------------------------------------------
# 5. Handle missing values
# ------------------------------------------------------------

# Age - median imputation
titanic$Age[is.na(titanic$Age)] <-
  median(titanic$Age, na.rm = TRUE)

# Embarked - mode imputation
mode_embarked <- names(
  sort(table(titanic$Embarked), decreasing = TRUE)
)[1]

titanic$Embarked[
  is.na(titanic$Embarked)
] <- mode_embarked

# ------------------------------------------------------------
# 6. Check duplicate records
# ------------------------------------------------------------

duplicate_count <- sum(duplicated(titanic))

print(paste(
  "Number of duplicate rows:",
  duplicate_count
))

titanic <- titanic[!duplicated(titanic), ]

# ------------------------------------------------------------
# 7. Convert categorical variables
# ------------------------------------------------------------

titanic$Pclass <- as.factor(titanic$Pclass)

titanic$Sex <- as.factor(titanic$Sex)

titanic$Embarked <- as.factor(titanic$Embarked)

# ------------------------------------------------------------
# 8. Outlier detection using IQR
# ------------------------------------------------------------

Q1 <- quantile(titanic$Fare, 0.25)

Q3 <- quantile(titanic$Fare, 0.75)

IQR_value <- IQR(titanic$Fare)

lower_limit <- Q1 - 1.5 * IQR_value

upper_limit <- Q3 + 1.5 * IQR_value

fare_outliers <- titanic[
  titanic$Fare < lower_limit |
  titanic$Fare > upper_limit,
]

print("Fare Outliers:")
print(fare_outliers)

# ------------------------------------------------------------
# 9. Fare boxplot
# ------------------------------------------------------------

png(
  "outputs/fare_outliers.png",
  width = 800,
  height = 600
)

boxplot(
  titanic$Fare,
  main = "Fare Outlier Detection",
  ylab = "Fare"
)

dev.off()

# ------------------------------------------------------------
# 10. Normalization
# ------------------------------------------------------------

normalize <- function(x) {
  (x - min(x)) /
    (max(x) - min(x))
}

titanic$Age_norm <- normalize(titanic$Age)

titanic$Fare_norm <- normalize(titanic$Fare)

# ------------------------------------------------------------
# 11. Categorical encoding
# ------------------------------------------------------------

titanic$Sex_encoded <- ifelse(
  titanic$Sex == "male",
  1,
  0
)

titanic$Embarked_encoded <-
  as.numeric(factor(titanic$Embarked))

# ------------------------------------------------------------
# 12. Age distribution
# ------------------------------------------------------------

png(
  "outputs/age_distribution.png",
  width = 800,
  height = 600
)

hist(
  titanic$Age,
  breaks = 30,
  main = "Distribution of Passenger Age",
  xlab = "Age",
  ylab = "Frequency"
)

dev.off()

# ------------------------------------------------------------
# 13. Survival by Sex
# ------------------------------------------------------------

png(
  "outputs/survival_by_sex.png",
  width = 800,
  height = 600
)

ggplot(
  titanic,
  aes(
    x = Sex,
    fill = factor(Survived)
  )
) +
  geom_bar(position = "fill") +
  labs(
    title = "Survival Proportion by Sex",
    x = "Sex",
    y = "Proportion",
    fill = "Survived"
  )

dev.off()

# ------------------------------------------------------------
# 14. Survival by Passenger Class
# ------------------------------------------------------------

png(
  "outputs/survival_by_class.png",
  width = 800,
  height = 600
)

ggplot(
  titanic,
  aes(
    x = Pclass,
    y = Survived
  )
) +
  stat_summary(
    fun = mean,
    geom = "bar"
  ) +
  labs(
    title = "Survival Rate by Passenger Class",
    x = "Passenger Class",
    y = "Survival Rate"
  )

dev.off()

# ------------------------------------------------------------
# 15. Descriptive statistics
# ------------------------------------------------------------

print(
  summary(
    titanic[
      c(
        "Age",
        "SibSp",
        "Parch",
        "Fare"
      )
    ]
  )
)

# ------------------------------------------------------------
# 16. Correlation analysis
# ------------------------------------------------------------

correlation_data <- titanic[
  c(
    "Survived",
    "Age",
    "SibSp",
    "Parch",
    "Fare"
  )
]

correlation_matrix <- cor(
  correlation_data,
  use = "complete.obs"
)

print(correlation_matrix)

# ------------------------------------------------------------
# 17. Correlation visualization
# ------------------------------------------------------------

png(
  "outputs/correlation_matrix.png",
  width = 800,
  height = 600
)

corrplot(
  correlation_matrix,
  method = "number"
)

dev.off()

# ------------------------------------------------------------
# 18. Save cleaned dataset
# ------------------------------------------------------------

write.csv(
  titanic,
  "data/Titanic_Dataset_Cleaned.csv",
  row.names = FALSE
)

# ------------------------------------------------------------
# End of analysis
# ------------------------------------------------------------

print("Week 1 analysis completed successfully.")