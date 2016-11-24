
R/dynetNLAResistance
====================

R/dynetNLAResistance is an R package of method to resist neighbor label attack in a dynamic network.

Installation
------------

You can install the stable version of R/dynetNLAResistance from CRAN:

``` r
install.packages("dynetNLAResistance")
```

Example
-------

You can create a dynamic network by function make.virtual.dynamic.network. Then group it by function lw.grouping,and anonymize it by function anonymization.

``` r
library(dynetNLAResistance)
dynet <- make.virtual.dynamic.network()
dynet.grouped <- lw.grouping(dynet,l = 2, w = 1)
```

    ## candidates number:  21  selected id:  V83259 
    ## Grouping t1 50%
    ## candidates number:  19  selected id:  V101425 
    ## Grouping t1 100%
    ## merge.groups
    ## candidates number:  25  selected id:  V83259 
    ## Grouping t2 50%
    ## candidates number:  24  selected id:  V52658 
    ## Grouping t2 100%
    ## merge.groups
    ## candidates number:  28  selected id:  V12915 
    ## Grouping t3 33.33333%
    ## candidates number:  28  selected id:  V83259 
    ## Grouping t3 66.66667%
    ## candidates number:  27  selected id:  V52658 
    ## Grouping t3 100%
    ## merge.groups
    ## candidates number:  33  selected id:  V107009 
    ## Grouping t4 33.33333%
    ## candidates number:  32  selected id:  V83259 
    ## Grouping t4 66.66667%
    ## candidates number:  31  selected id:  V52658 
    ## Grouping t4 100%
    ## merge.groups
    ## candidates number:  38  selected id:  V107009 
    ## Grouping t5 33.33333%
    ## candidates number:  38  selected id:  V83259 
    ## Grouping t5 66.66667%
    ## candidates number:  37  selected id:  V52658 
    ## Grouping t5 100%
    ## merge.groups
    ## candidates number:  43  selected id:  V107009 
    ## Grouping t6 33.33333%
    ## candidates number:  43  selected id:  V83259 
    ## Grouping t6 66.66667%
    ## candidates number:  42  selected id:  V52658 
    ## Grouping t6 100%
    ## merge.groups
    ## candidates number:  46  selected id:  V107009 
    ## Grouping t7 25%
    ## candidates number:  47  selected id:  V70665 
    ## Grouping t7 50%
    ## candidates number:  45  selected id:  V52658 
    ## Grouping t7 75%
    ## candidates number:  45  selected id:  V45810 
    ## Grouping t7 100%
    ## merge.groups
    ## candidates number:  50  selected id:  V43683 
    ## Grouping t8 20%
    ## candidates number:  49  selected id:  V70665 
    ## Grouping t8 40%
    ## candidates number:  48  selected id:  V91392 
    ## Grouping t8 60%
    ## candidates number:  47  selected id:  V22987 
    ## Grouping t8 80%
    ## candidates number:  47  selected id:  V45810 
    ## Grouping t8 100%
    ## merge.groups
    ## candidates number:  54  selected id:  V43683 
    ## Grouping t9 20%
    ## candidates number:  54  selected id:  V70665 
    ## Grouping t9 40%
    ## candidates number:  54  selected id:  V91392 
    ## Grouping t9 60%
    ## candidates number:  53  selected id:  V22987 
    ## Grouping t9 80%
    ## candidates number:  54  selected id:  V45810 
    ## Grouping t9 100%
    ## merge.groups
    ## candidates number:  55  selected id:  V2716 
    ## Grouping t10 12.5%
    ## candidates number:  55  selected id:  V101191 
    ## Grouping t10 25%
    ## candidates number:  53  selected id:  V46066 
    ## Grouping t10 37.5%
    ## candidates number:  51  selected id:  V31762 
    ## Grouping t10 50%
    ## candidates number:  52  selected id:  V70665 
    ## Grouping t10 62.5%
    ## candidates number:  52  selected id:  V91392 
    ## Grouping t10 75%
    ## candidates number:  51  selected id:  V97632 
    ## Grouping t10 87.5%
    ## candidates number:  51  selected id:  V45810 
    ## Grouping t10 100%
    ## merge.groups

``` r
g5.a <- anonymization(dynet.grouped$t5, alpha = 1, beta = 2, gamma = 3)
```

    ## Merged group-set's size:  3 
    ## Vertex number:  43 
    ## iterating...
    ## Anonymized nodes with sensitive label:
    ##  V84209 
    ## 
    ## Merged group-set's size:  2 
    ## Vertex number:  45 
    ## iterating...
    ## Anonymized nodes with sensitive label:
    ##  V84209 V26130 
    ## 
    ## Merged group-set's size:  1 
    ## Vertex number:  47 
    ## iterating...
    ## Anonymized nodes with sensitive label:
    ##  V84209 V26130 V95940

License
-------

MIT
