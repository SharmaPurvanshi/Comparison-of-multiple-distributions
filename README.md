# Maternal Smoking and Babies' Birth Weight

## Description
This project involves the analysis of a dataset related to newborns and their mothers, focusing on the relationship between maternal smoking and babies' birth weight. The dataset contains 1236 samples and 23 independent variables, including:

- Infant survival
- Birth weight
- Date of birth
- Sex
- Mother’s ethnicity
- Age
- Education level
- Height
- Weight
- Smoking status

The dataset is available at [Stat Labs](https://www.stat.berkeley.edu/users/statlabs/labs.html), with a clean version uploaded on Moodle.

## Project Objective
The primary focus of this project is to investigate the relationship between maternal smoking and babies' birth weight. Specifically, we aim to determine if different smoking statuses among mothers lead to changes in the birth weight of their babies.

### Key Variables
- **wt**: Babies' birth weight in ounces (999 = unknown)
- **smoke**: Mothers' smoking history
  - 0 = never
  - 1 = smokes now
  - 2 = until current pregnancy
  - 3 = once did, not now
  - 9 = unknown (excluded from analysis)

## Data Analysis
The analysis covers:
- Descriptive statistics of the dataset
- Visualizations to illustrate the distribution of birth weights across different smoking statuses
- Statistical tests to evaluate the significance of differences in birth weights among groups
- Potential confounders and their impact on the analysis

### Descriptive Analysis
- **Five-number summary**: Provides insights into the distribution of birth weights for different smoking categories.
- **Histograms and Box Plots**: Visualize the distribution and central tendency of birth weights.

### Inferential Analysis
- **Shapiro-Wilk Test**: Assesses the normality of birth weight data for different smoking categories.
- **ANOVA Test**: Determines if there are significant differences in mean birth weight among smoking status groups.
- **Levene's Test**: Checks for homogeneity of variances among groups.
- **Pairwise Comparisons**: Conducted using t-tests, Bonferroni correction, and Tukey's HSD test to identify specific group differences.

### Key Findings
- Significant differences in birth weights were found among different smoking status groups.
- Mothers who never smoked and those who currently smoke have significantly different mean birth weights compared to other groups.
- No significant differences were observed between mothers who smoked until pregnancy and those who smoked once.

## Dependencies


### R Packages
All R dependencies are listed in the `requirements.txt` file. To install them, you can use the following R script:

```R
# Read the required packages from the file and install them
packages <- readLines("requirements.txt")
install.packages(packages)

```

