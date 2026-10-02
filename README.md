# Week 1 – Data Cleaning and Preliminary Analysis with R

## Project Overview

This project was completed as part of the Week 1 task on **Data Cleaning and Preliminary Analysis using R**.

The objective of this project is to demonstrate a complete introductory data-analysis workflow using a publicly available dataset. The analysis includes dataset inspection, missing-value handling, duplicate detection, outlier detection, normalization, categorical encoding, exploratory data analysis, descriptive statistics, correlation analysis, and visualization.

## Dataset

The project uses the publicly available **Titanic Passenger Dataset**.

The dataset contains information about passengers, including:

* Survival status
* Passenger class
* Sex
* Age
* Number of siblings/spouses aboard
* Number of parents/children aboard
* Fare
* Port of embarkation

The dataset contains both numerical and categorical variables and includes missing observations, making it suitable for data-cleaning practice.

## Objectives

The main objectives are:

1. Load and inspect the dataset using R.
2. Identify missing values.
3. Handle missing observations appropriately.
4. Check for duplicate records.
5. Detect potential outliers using the IQR method.
6. Normalize numerical variables.
7. Encode categorical variables.
8. Perform exploratory data analysis.
9. Generate descriptive statistics.
10. Analyze correlations between numerical variables.
11. Create visualizations.
12. Export the cleaned dataset.

## Technologies Used

* R
* RStudio
* tidyverse
* ggplot2
* corrplot
* CSV

## Project Structure

```text
week1-r-data-cleaning-analysis/
│
├── README.md
├── Week_1_Data_Cleaning_Preliminary_Analysis_R_Aakriti_Gupta.docx
│
├── data/
│   ├── Titanic_Dataset_Raw.csv
│   └── Titanic_Dataset_Cleaned.csv
│
├── R/
│   └── week1_data_cleaning_analysis.R
│
├── outputs/
│   ├── age_distribution.png
│   ├── fare_outliers.png
│   ├── survival_by_sex.png
│   ├── survival_by_class.png
│   └── correlation_matrix.png
│
└── screenshots/
    ├── data_structure.png
    ├── missing_values.png
    ├── summary_statistics.png
    └── r_visualizations.png
```

## Data Cleaning Process

### Missing Values

Missing values were identified using:

```r
colSums(is.na(titanic))
```

For the `Age` variable, missing observations were replaced using the median because the median is less affected by extreme values.

For `Embarked`, missing observations were replaced using the mode because it is a categorical variable.

### Duplicate Detection

Duplicate rows were identified using:

```r
sum(duplicated(titanic))
```

Duplicate records were removed where necessary.

### Outlier Detection

The Interquartile Range method was used to identify potential outliers in the `Fare` variable.

The lower and upper boundaries were calculated using:

```r
Q1 - 1.5 * IQR
Q3 + 1.5 * IQR
```

Potential outliers were investigated rather than automatically deleted because extreme fares may represent genuine passenger records.

### Normalization

Min-max normalization was applied to selected numerical variables:

```r
(x - min(x)) / (max(x) - min(x))
```

This converts values to a range between 0 and 1.

### Categorical Encoding

Categorical variables were converted into appropriate factor representations. Binary encoding was also demonstrated for the `Sex` variable.

## Exploratory Data Analysis

The project includes:

* Age distribution histogram
* Fare outlier boxplot
* Survival analysis by sex
* Survival analysis by passenger class
* Correlation matrix

## Initial Insights

The preliminary analysis indicates that:

* Missing observations require appropriate preprocessing before analysis.
* Age contains missing values and requires imputation.
* Fare contains high-value observations that can be detected using the IQR method.
* Passenger sex shows a substantial difference in survival proportions.
* Passenger class is associated with differences in survival rates.
* Numerical normalization can make variables more comparable for subsequent machine-learning workflows.
* Correlation analysis provides useful information about linear relationships between numerical variables but does not establish causation.

## How to Run the Project

### Step 1: Install R

Install R from the official R website.

### Step 2: Install RStudio

Open the project in RStudio.

### Step 3: Install Required Packages

Run:

```r
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("corrplot")
```

### Step 4: Run the Analysis

Open:

```text
R/week1_data_cleaning_analysis.R
```

Run the complete script.

The generated charts will be saved in:

```text
outputs/
```

The cleaned dataset will be saved in:

```text
data/Titanic_Dataset_Cleaned.csv
```

## Report

The detailed Word report containing methodology, R code, outputs, visualizations, descriptive statistics, and conclusions is available as:

```text
Week_1_Data_Cleaning_Preliminary_Analysis_R_Aakriti.docx
```

## Author

**Aakriti**

B.Tech Computer Science and Artificial Intelligence

## Project Type

Academic / Internship Week 1 Data Analysis Task
