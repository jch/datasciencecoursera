# Data Scientist Toolbox

https://www.coursera.org/course/datascitoolbox

* answering questions from incomplete information, or from too much information
* intersection of math/science, programming, and experience
* have data that we previously didn't. can answer new interesting questions
* [How to ask questions the smart way](http://www.catb.org/esr/faqs/smart-questions.html)

## Process

* define the question
* define the ideal data set, obtain, filter
* exploratory data analysis
* statistical predication/modeling
* interpret results
* challenge results

## R programming language

* https://cran.r-project.org
* R, Rmd (R markdown)

```r
# inline docs
?rnorm
help.search("rnorm")
args("rnorm")

# shows the code
rnorm

# install packages
install.packages("slidify")

# another way to install packages
source("https://bioconductor.org/biocLite.R")
biocLite()

# loads a library, follows dependencies, no quotes
library(ggplot2)

# shows recently loaded libraries
search()
```

## Types of questions

**Descriptive**
* commonly applied to census data
* does not interpret, only describe
* census2010, books.google.com/ngrams

**Exploratory**
* discover new connections
* define future studies

**Inferential**
* infer something about a bigger population from a small sample

**Predictive**
* X predicts Y does not mean X causes Y
* more data + simple model works really well
* predication is really hard
* 538 election forecast, shopping history predicts pregnancy

**Causal**
* what happens to one variable when you make another variable change
* randomized studies to identity causation
* gold standard for analysis

**Mechanistic**
* exact changes in variables that lead to changes in other variables for individual objects
* rarely used
* physical/engineering sciences. e.g. pavement analysis

## What is data

* set of items: population
* variables: measurement or characteristic of item
* observations: rows of values. variables are columns
* qualitative / quantitative: country,sex,treatment / height,weight (ordered on a scale)

## Experimental design

* jtleek/datasharing
* formulate your question in advance
* population: everyone, usually too expensive to calculate
* probability: choose a subset of the population to give you a **sample**.
* descriptive statistics: to figure out stats for the sample
* inferential statistics: to predict the whole population
* variability: data is close, gives you a clear answer
* confounding: confounding variable is hidden that causes a relationship that you didn't expect. spurrious? correlation.
  * fix a variable: always the same value
  * stratify a variable: two phrases, two colors, use phrases equally on both colors
  * randomize: choose experimental units randomly
* prediction: sort results into training set, create a predication function to sort new samples as they come in. harder because the distributions need to be far enough apart in variability to tell things apart.
