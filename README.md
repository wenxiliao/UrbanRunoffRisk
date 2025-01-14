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

## Example Usage

This is a basic example which shows you how to solve a common problem:

### Prerequisites
Ensure you have the required packages installed and loaded:
```R
# Install required packages
install.packages("readxl")

library(UrbanRunoffRisk)
library(readxl)
```

### Read the example data file
``` r
# Read the Excel file
runoff_metals = read_excel("data/UrbanRunoff_Metals.xlsx"")

# Inspect the first few rows
head(runoff_metals)
```

### Calculate Risk Quotient (PEC/PNEC)
``` r
# Calculate RQ(PEC/PNEC)
RQ_PEC_PNEC = calculate_RQ_PEC_PNEC(runoff_metals)

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
RQ_STU = calculate_RQ_STU(runoff_metals)

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
- Maximum STU (Equation 4): 21.87456 

Condition Met: RQ_STU > 1. Applying Equation 5.
- Total Ratio (Σ PEC/EC50): 31.12007 
- Maximum Ratio (max PEC/EC50): 15.81633 

Final Result:
- EC50IA / EC50CA ≤ 1.967592 
=========================================

[1] 1.967592


#### Note
Equations 4 and 5 are the equations noted in Fulgence et al. (in preparation).


## Citation
Fulgence M., Kalogerakis G., Quevedo A., Liao W., Hamilton B., Robinson S., & Tufenkji N. Urban runoff toxicity 
on aquatic species: physiological and biomarker responses with toxicant characterization. (in preparation).




