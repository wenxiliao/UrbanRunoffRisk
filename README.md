## README

<p xmlns:cc="http://creativecommons.org/ns#" >This work is licensed under <a href="https://creativecommons.org/licenses/by-nc/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">Creative Commons Attribution-NonCommercial 4.0 International<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1" alt=""><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1" alt=""><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/nc.svg?ref=chooser-v1" alt=""></a></p>

<!-- README.md is generated from README.Rmd. Please edit that file -->

## UrbanRunoffRisk

<!-- badges: start -->
<!-- badges: end -->

This package provides functions to calculate hazard and
risk of urban runoff with chemical mixtures using input from Excel files.

## Installation

You can install the development version of UrbanRunoffRisk following the 
steps below:

``` r
# Install devtools if not already installed
install.packages("devtools")

# Install the UrbanRunoffRisk package
devtools::install_github("wenxiliao/UrbanRunoffRisk")
```

### Prerequisites
Ensure you have the required packages installed and loaded:
```R
# Install required packages
install.packages("readxl")

library(UrbanRunoffRisk)
library(readxl)
```

## Example Usages

## Example 1: 
This is an example using metals as contaminants to demonstrate how to address a common analysis problem. The data in the example were collected from the article below: Helmreich B, Hilliges R, Schriewer A, Horn H. Runoff pollutants of a highly trafficked urban road – Correlation analysis and seasonal influences. Chemosphere. 2010 Aug 1;80(9):991–7.

### Read the example data file
``` r
# Read the Excel file
runoff_metals = read_excel("data/UrbanRunoff_Metals.xlsx")

# Inspect the first few rows
head(runoff_metals)

# Read and assign the file path
runoff_metals_path = "data/UrbanRunoff_Metals.xlsx"
```

### Calculate Risk Quotient (PEC/PNEC)
``` r
# Calculate RQ(PEC/PNEC)
RQ_PEC_PNEC = calculate_RQ_PEC_PNEC(runoff_metals_path)

# View the results
print(RQ_PEC_PNEC)
```


### Example output for Risk Quotient (PEC/PNEC) of runoff_metals data

=== Ecotoxicity Risk Quotient Calculation ===  

Input Data:
- PEC (Environmental Concentrations): 0.5 155 35 43 592 
- EC50 (Algae): 301 19 150 476 2700 
- EC50 (Daphnids): 65 9.8 510 694.57 100 
- EC50 (Fish): 10850 300 18990 26850 25880 
- Assessment Factors (AF): 1000 1000 1000 1000 1000 

Intermediate Calculations:
- Minimum EC50 values: 65 9.8 150 476 100 
- PNEC values: 0.065 0.0098 0.15 0.476 0.1 
- Individual RQ values: 7.692308 15816.33 233.3333 90.33613 5920 

Final Result:
- Total RQ (Sum of all contaminants): 22067.69

============================================

[1] 22067.69


### Calculate Risk Quotient (STU)
``` r
# Calculate RQ(STU)
RQ_STU = calculate_RQ_STU(runoff_metals_path)

# View the results
print(RQ_STU)
```

### Example output for Risk Quotient (STU) of runoff_metals data

=== Risk Quotient (RQ_STU) Calculation ===     

Input Data:
- PEC (Environmental Concentrations): 0.5 155 35 43 592 
- EC50 (Algae): 301 19 150 476 2700 
- EC50 (Daphnia): 65 9.8 510 694.57 100 
- EC50 (Fish): 10850 300 18990 26850 25880 
- Assessment Factor (AF): 1000 

Intermediate Calculations:
- STU (Algae): 8.702485 
- STU (Daphnia): 21.87456 
- STU (Fish): 0.5430321 
- RQ_STU (Equation 4): 21874.56 

Condition Met: RQ_STU > 1. Applying Equation 5.
- Total Ratio (Σ PEC/EC50): 31.12007 
- Maximum Ratio (max PEC/EC50): 15.81633 

Final Result:
- EC50IA / EC50CA ≤ 1.967592 

=========================================

[1] 1.967592




## Example 2: 
This is another example using organic contaminants to demonstrate how to address a common analysis problem. The data in the example were collected from the article below: xxx

### Read the example data file
``` r
# Read the Excel file
runoff_organic_contaminants = read_excel("data/UrbanRunoff_Commercial_OrganicContaminants.xlsx")

# Inspect the first few rows
head(runoff_organic_contaminants)

# Read and assign the file path
runoff_organic_contaminants_path = "data/UrbanRunoff_Commercial_OrganicContaminants.xlsx"
```

### Calculate Risk Quotient (PEC/PNEC)
``` r
# Calculate RQ(PEC/PNEC)
RQ_PEC_PNEC = calculate_RQ_PEC_PNEC(runoff_organic_contaminants_path)

# View the results
print(RQ_PEC_PNEC)
```


### Example output for Risk Quotient (PEC/PNEC) of runoff_organic_contaminants data

Warning: The data contains NA values. These will be ignored in calculations.

=== Ecotoxicity Risk Quotient Calculation ===

Input Data:
- PEC (Environmental Concentrations): 0.0092 0.0074 0.0072 0.0048 0.013 0.475 0.151 0.027 0.013 1.398 0 0 0 0.171 0.076 0.077 0.322 0.113 0.068 0.993 0 0.122 0 0.729 0.086 0 0.037 0 0.503 0.132 
- EC50 (Algae): 413.2 NA NA 4.3 NA 3880 14 630 52 NA 8 2173.8 930 192 237 49735.97 45000 51000 39000 NA 500 NA NA NA 2980 NA NA NA NA NA 
- EC50 (daphnids): 50410 NA NA 17900 16500 25000 136000 NA 1500 75000 23500 1000 5400 120 330 87 81000 381000 7900 38000 550 2590 NA 100 9510 60130 120000 NA NA 153 
- EC50 (Fish): 44300 NA NA 500 1292.6 138820 NA 36000 2880 75000 32000 6400 11000 12.2 375 871 96850 90000 5100 NA 700 65000 NA 1e+05 3890 NA 255000 NA 25 NA 
- Assessment Factors (AF): 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 

Intermediate Calculations:
- Minimum EC50 values: 413.2 NA NA 4.3 1292.6 3880 14 630 52 75000 8 1000 930 12.2 237 87 45000 51000 5100 38000 500 2590 NA 100 2980 60130 120000 NA 25 153 
- PNEC values: 0.4132 NA NA 0.0043 1.2926 3.88 0.014 0.63 0.052 75 0.008 1 0.93 0.0122 0.237 0.087 45 51 5.1 38 0.5 2.59 NA 0.1 2.98 60.13 120 NA 0.025 0.153 
- Individual RQ values: 0.02226525 NA NA 1.116279 0.01005725 0.1224227 10.78571 0.04285714 0.25 0.01864 0 0 0 14.01639 0.3206751 0.8850575 0.007155556 0.002215686 0.01333333 0.02613158 0 0.04710425 NA 7.29 0.02885906 0 0.0003083333 NA 20.12 0.8627451 

Final Result:
- Total RQ (Sum of all contaminants): 55.98821 

============================================
Warning messages:
1: In calculate_RQ_PEC_PNEC(runoff_organic_contaminants_path) :
  NAs introduced by coercion
2: In calculate_RQ_PEC_PNEC(runoff_organic_contaminants_path) :
  NAs introduced by coercion
3: In calculate_RQ_PEC_PNEC(runoff_organic_contaminants_path) :
  NAs introduced by coercion

=========================================

[1] 55.98821


### Calculate Risk Quotient (STU)
``` r
# Calculate RQ(STU)
RQ_STU = calculate_RQ_STU(runoff_organic_contaminants_path)

# View the results
print(RQ_STU)
```


### Example output for Risk Quotient (STU) of runoff_organic_contaminants data

Warning: The data contains NA values. These will be ignored in calculations.

=== Risk Quotient (RQ_STU) Calculation ===

Input Data:
- PEC (Environmental Concentrations): 0.0092 0.0074 0.0072 0.0048 0.013 0.475 0.151 0.027 0.013 1.398 0 0 0 0.171 0.076 0.077 0.322 0.113 0.068 0.993 0 0.122 0 0.729 0.086 0 0.037 0 0.503 0.132 
- EC50 (Algae): 413.2 NA NA 4.3 NA 3880 14 630 52 NA 8 2173.8 930 192 237 49735.97 45000 51000 39000 NA 500 NA NA NA 2980 NA NA NA NA NA 
- EC50 (Daphnia): 50410 NA NA 17900 16500 25000 136000 NA 1500 75000 23500 1000 5400 120 330 87 81000 381000 7900 38000 550 2590 NA 100 9510 60130 120000 NA NA 153 
- EC50 (Fish): 44300 NA NA 500 1292.6 138820 NA 36000 2880 75000 32000 6400 11000 12.2 375 871 96850 90000 5100 NA 700 65000 NA 1e+05 3890 NA 255000 NA 25 NA 
- Assessment Factor (AF): 1000 

Intermediate Calculations:
- STU (Algae): 0.01359236 
- STU (Daphnia): 0.01083723 
- STU (Fish): 0.03452399 
- RQ_STU (Equation 4): 34.52399 

Condition Met: RQ_STU > 1. Applying Equation 5.
- Total Ratio (Σ PEC/EC50): 0.05895358 
- Maximum Ratio (max PEC/EC50): 0.02012 

Final Result:
- EC50IA / EC50CA ≤ 2.930098 

=========================================
Warning messages:
1: In calculate_RQ_STU(runoff_organic_contaminants_path) :
  NAs introduced by coercion
2: In calculate_RQ_STU(runoff_organic_contaminants_path) :
  NAs introduced by coercion
3: In calculate_RQ_STU(runoff_organic_contaminants_path) :
  NAs introduced by coercion

=========================================

[1] 2.930098



## Note
Equations 4 and 5 are the equations noted in Fulgence et al. (in preparation).


## Citation
Fulgence M., Kalogerakis G., Quevedo A., Liao W., Hamilton B., Robinson S., & Tufenkji N. Urban runoff toxicity 
on aquatic species: physiological and biomarker responses with toxicant characterization. (in preparation).




