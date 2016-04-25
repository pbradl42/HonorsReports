---
title       : Class of 2016
subtitle    : Basic demographics of Honors Class of 2016, Ferris State University
author      : Peter Bradley
job         : Profile of Honors Class of 2016
framework   : shower        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [quiz, bootstrap]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

```r
source("EnrollmentDescriptives.R")
```

```
## Warning in file(filename, "r", encoding = encoding): cannot open file
## 'EnrollmentDescriptives.R': No such file or directory
```

```
## Error in file(filename, "r", encoding = encoding): cannot open the connection
```

```r
fall2014 <- getorientation("201408")
```

```
## Error in eval(expr, envir, enclos): could not find function "getorientation"
```

```r
fall2015 <- getorientation("201508")
```

```
## Error in eval(expr, envir, enclos): could not find function "getorientation"
```

```r
fall2016 <- getorientation("201608")
```

```
## Error in eval(expr, envir, enclos): could not find function "getorientation"
```
## Ethnicity

```r
byethnicity16 <- table(fall2016$ethnicity)
```

```
## Error in table(fall2016$ethnicity): object 'fall2016' not found
```

```r
byethnicity15 <- table(fall2015$ethnicity)
```

```
## Error in table(fall2015$ethnicity): object 'fall2015' not found
```

```r
byethnicity14 <- table(fall2014$ethnicity)
```

```
## Error in table(fall2014$ethnicity): object 'fall2014' not found
```

```r
byethnicity16$year <- "2016"
```

```
## Error in byethnicity16$year <- "2016": object 'byethnicity16' not found
```

```r
byethnicity15$year <- "2015"
```

```
## Error in byethnicity15$year <- "2015": object 'byethnicity15' not found
```

```r
byethnicity14$year <- "2014"
```

```
## Error in byethnicity14$year <- "2014": object 'byethnicity14' not found
```

```r
ethnicityTotal <- cbind(byethnicity16, byethnicity15, byethnicity14)
```

```
## Error in cbind(byethnicity16, byethnicity15, byethnicity14): object 'byethnicity16' not found
```

```r
ethnicityTotal$ethnicity <- factor(ethnicityTotal$ethnicity)
```

```
## Error in factor(ethnicityTotal$ethnicity): object 'ethnicityTotal' not found
```

```r
ggplot(ethnicityTotal, aes(x=year, y=count, fill=ethnicity)) + geom_bar(position="stacked", stat="identity") -> p
```

```
## Error in eval(expr, envir, enclos): could not find function "ggplot"
```

```r
p
```

```
## Error in match.fun(FUN): object 'scale_clone' not found
```

![plot of chunk unnamed-chunk-2](assets/fig/unnamed-chunk-2-1.png)
--- .class #id 

## Non-White population, with comparrison


```r
nonWhite <- ethnicityTotal[-(ethnicityTotal$ethnicity = "White"),]
```

```
## Error in eval(expr, envir, enclos): object 'ethnicityTotal' not found
```

```r
ggplot(nonWhite, aes(x=year, y=count, fill=ethnicity)) + geom_bar(position="stacked", stat="identity") -> p
```

```
## Error in eval(expr, envir, enclos): could not find function "ggplot"
```

```r
p
```

```
## Error in match.fun(FUN): object 'scale_clone' not found
```

![plot of chunk unnamed-chunk-3](assets/fig/unnamed-chunk-3-1.png)

--- .class #id

## Gender comparrison


```
## Error in table(fall2016$gender): object 'fall2016' not found
```

```
## Error in table(fall2015$gender): object 'fall2015' not found
```

```
## Error in table(fall2014$gender): object 'fall2014' not found
```

```
## Error in bygender16$year <- "2016": object 'bygender16' not found
```

```
## Error in bygender15$year <- "2015": object 'bygender15' not found
```

```
## Error in bygender14$year <- "2014": object 'bygender14' not found
```

```
## Error in cbind(bygender16, bygender15, bygender14): object 'bygender16' not found
```

```
## Error in factor(genderTotal$gender): object 'genderTotal' not found
```

```
## Error in eval(expr, envir, enclos): could not find function "ggplot"
```

```
## Error in match.fun(FUN): object 'scale_clone' not found
```

![plot of chunk unnamed-chunk-4](assets/fig/unnamed-chunk-4-1.png)
--- .class #id

## By College

--- .class #id

## Out of State

--- .class #id

## Input Variables

--- .class #id

## Geography

--- .class #id

## What they are proud of:

--- .class #id
