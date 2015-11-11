# R Programming

https://www.coursera.org/course/rprog

* dialect of S, from bell labs in the 70's. open sourced in 93
* bioconductor.org biological data analysis

## Types

* atomic classes: character, numeric (double precision real), integer (suffix with L), complex, logical (T/F)
* vector must has same type
* list can be mixed type
* Inf, NaN, NA (nullish value, `is.na`, `is.nan`)
* implicit coercion if mix types in vectors
* explicit coercion `as.numeric|character|logical|complex`

## Objects

* attributes: names, dimname (dimension name), class, length, user defined
* `class(x)` to display type
* `unclass(x)` to strip the type and see underlying representation

## Matrices

* vector with a `dimension` attribute `matrix(nrow=2, ncol=3)`. Use `dim` to add dimension attribute to an existing vector.
* constructed column-wise: `matrix(1:6, nrow=2, ncol=3)`
* `cbind`, `rbind` create matrix via vectors

## Factors

* categories: unordered: male / female, ordered: student, phd, postdoc
* self describing, better than enum of integers
* `factor(c("yes", "yes", "no", "yes"), levels=c("yes", "no"))`
* `table(f)` to count by levels

## Data frames

* tabular data. special type of list
* matrix has same type, but data frame can be mixed. `data.matrix` coerces
* `row.names`
* usually create with `read.table`, `read.csv`
* `data.frame(foo = 1:4, bar = c(T,T,F,F))`
* `mtcars` built in dataframe, so cool!

## Names

* user defined attributes on objects
* `names(v)` to view on vector
* `names(v) <- c('a', 'b', 'c')` to define on vector
* `list(a=1, b=2)`
* `dimnames(m) <- list(c('row1', 'row2'), c('col1', 'col2'))` on matrix

## Reading data

```r
# tabular data
read.table  # sep=" "
write.table
read.csv    # sep=",", header=T

read.table(
  file='',
  header=T,
  sep=',',
  colClasses=c("numeric", "numeric"), # faster than inferring from data
  stringsAsFactors=T,
  nrows=100,
  comment.char = "",  # faster without comments
)

# optimization: set colClasses
small <- read.table("db.txt", nrows=100)
classes <- sapply(small, class) # classes from a small set
read.table("db.txt", colClasses = classes)

# text file
readLines / writeLines

# R files
source / dget / dput

# workspace
load

# marshaling objects
unserialize / save, serialize

# Connections
con <- file("foo.txt", "r")
gzfile
bzfile
url

# alternative to reading by path
data <- read.csv(con)
close(con)
```

## Subsetting

```r
x <- c("a", "b", "c", "c", "d", "a")

# extracts the same type as the original object
x[1]       # "a" subset by numeric index
x[1:4]     # "a" "b" "c" "c" subset by range
x[x > "a"] # "b" "c" "c" "d" subset by conditional
u < x > "a"
x[u]       # same as above, subset by logicals


# extracts element, but not the same type, only selects one element
y <- list(foo = 1:5)
z <- "foo"
x[[z]] # returns vector

# $ will try to match named var
y <- list(aardvark = 1:5)
y$a  # returns 1:5

# matrices will drop dimension by default with [ operator
m <- matrix(1:6, nrow=2, ncol=3)
m[1,1]  # returns row 1, col 1, value 1, but is numeric, not matrix
m[2,2, drop = F]  # returns a matrix
m[1,]   # returns sequence, the first row

# remove NA's by subsetting vector of where NA's are positioned
x <- c(1, 2, NA, 4, NA, 5)
bad <- is.na(x)
x[!bad]

# subset out dataframe missing values
good <- complete.cases(data)
data[good,]
```

## Vectorized operations

* operators are aware of vectors. `+` will operate pairwise. `>` will compare against each element
* avoids writing your own loops
* matrix multiplication is `%*%`, `*` is just element by element multiplication

## Control structures

* apply functions are more useful in repl. These are for scripts.

```r
if(expression) {

} else if {

} else {

}

for(i in 1:10) { }
for(i in array_seq(x)) { }

while(expression) { }

# infinite loop, useful for iterating until convergence, but can use other
# structures to bound the number of iterations.
repeat {
  break  # force end

  next  # skip iteration
  return  # exit the calling function
}
```

## Functions

* functions are first class objects
* args are lazily evaluated

```r
add2 <- function(x, y) {
  x + y  # implicit return
}

# subset elements from vector x greater than n
above <- function(x, n = 10) {  # default value
  use <- x > 10
  x[use]
}

columnmean <- function(y, removeNA = TRUE) {  # named argument
  num_cols <- ncol(y)
  means <- numeric(num_cols)  # initialize empty numeric vector
  for(i in 1:num_cols) {
    means[i] <- mean(y[,i], na.rm = removeNA)
  }
  means
}

formals(columnmean)  # list of args for a function

foo <- function(x, y, z, garply = FALSE, bar = 3)

# args can be positional or named, mix and match is ok
foo(1, 2, 3, TRUE, 4)
foo(y = 2, x = 1, 3, TRUE, 4)

# args can be partially matched by name
foo(1, 2, 3, gar = TRUE, b = 5)

# args are lazily evaluated
f <- function(a, b) {
  print(a)  # this will print 45
  print(b)  # this will error when it's used
}
f(45)

# ... argument. also useful for generic functions for dispatch
myplot <- function(x, y, type = "l", ...) {
  plot(x, y, type = type, ...)
}

# ... argument: variable number of arguments. Remaining args must be named,
# and can't be partially matched
> args(cat)
function(..., sep = " ", collapse = NULL)
```

## Symbol binding

* search global environment (workspace, first in the search list)
* search the namespaces of each package in the search list. `search()` prints list
* `base` package is the last in the search list.
* separate namespaces for functions and non-functions. Can have object `c` and function `c`.
* loading a library inserts in search list after global env.
* lexical scoping: the values of free variables are searched for in the environment in which the function was defined.
  * environment: collection of (symbol, value) pairs
  * environments have parents, except the empty environment
  * function + environment is a *closure* or *function closure*
* dynamic scoping: the value of free variables are searched for in the calling environment (R: parent frame).

```r
f <- function(x, y) {
  # x, y are not free variables because they're args
  x^2 + y / z  # z is a "free variable"
}

make.power <- function(n) {
  pow <- function(x) { x^n }
  pow
}

cube <- make.power(3)
square <- make.power(2)

ls(environment(cube))
[1] "n" "pow"
get("n", environment(cube))
[1] 3

# takes a function, and tweaks parameters to estimate for optimum for a function
# don't understand this yet
optim
nlm
optimize
```

## Styleguide

* indent 8 spaces???, 4 minimum
* 80 columns

## Dates and times

* `Date` class
* Times in `POSIXct`, `POSIXlt` classes
* Dates are stored as days since 1970-01-01
* Times are stored as seconds since 1970-01-01
* tracks dst, leap years/seconds
* plotting functions are date time aware

```r
x <- as.Date("1970-01-01")
x
## [1] "1970-01-01"  # pretty printed
unclass(x)
## [1] 0

# POSIXct is a large number. the default
# POSIXlt is a list with information: day or week, day of year, month, day of month
x <- Sys.time()
p <- as.POSIXlt(x)
names(unclass(p))
p$sec

# format string to parse custom format
x <- strptime("January 10, 2012 10:40", "%B %d, %Y %H:%M")

# can't mix the two types. have to convert before operators
```
