#' Calculate RQ_PEC/PNEC
#'
#' This function calculates Ecotoxicity Risk Quotient (RQ) PEC/PNEC
#'
#' This function calculates the Risk Quotient (RQ) for contaminants based on their
#' Predicted Environmental Concentration (PEC), EC50 (or LC50) values for multiple species,
#' and an Assessment Factor (AF).
#'
#' @param PEC A vector of Predicted Environmental Concentrations (e.g., µg/L or mg/L).
#' @param EC50_algae A vector of EC50 values for algae (e.g., µg/L or mg/L).
#' @param EC50_daphnids A vector of EC50 values for Daphnia sp. (e.g.,µg/L or mg/L).
#' @param EC50_fish A vector of EC50 values for fish (e.g., µg/L or mg/L).
#' @param AF A vector of Assessment Factors for each contaminant (e.g., AF = 1000).
#' @param verbose Logical, if TRUE, prints detailed output (default = TRUE).
#' @return The Risk Quotient (RQ) as a numeric value.
#' @export
calculate_RQ_PEC_PNEC <- function(input_file = NULL, sheet = 1, verbose = TRUE) {
  if (!is.null(input_file)) {
    # Load data from the Excel file
    data <- readxl::read_excel(input_file, sheet = sheet)
    PEC <- as.numeric(data$PEC)
    EC50_algae <- as.numeric(data$EC50_algae)
    EC50_daphnids <- as.numeric(data$EC50_daphnids)
    EC50_fish <- as.numeric(data$EC50_fish)
    AF <- as.numeric(data$AF)

    # Check for NA values and inform the user
    if (any(is.na(c(PEC, EC50_algae, EC50_daphnids, EC50_fish)))) {
      cat("Warning: The data contains NA values. These will be ignored in calculations.\n")
    }
  } else {
    # Prompt user for inputs
    cat("Enter PEC (comma-separated): ")
    PEC <- as.numeric(unlist(strsplit(readline(), ",")))
    cat("Enter EC50_algae (comma-separated): ")
    EC50_algae <- as.numeric(unlist(strsplit(readline(), ",")))
    cat("Enter EC50_daphnids (comma-separated): ")
    EC50_daphnids <- as.numeric(unlist(strsplit(readline(), ",")))
    cat("Enter EC50_fish (comma-separated): ")
    EC50_fish <- as.numeric(unlist(strsplit(readline(), ",")))
    cat("Enter AF (comma-separated): ")
    AF <- as.numeric(unlist(strsplit(readline(), ",")))

    if (any(is.na(c(PEC, EC50_algae, EC50_daphnids, EC50_fish)))) {
      cat("Warning: The input contains NA values. These will be ignored in calculations.\n")
    }
  }

  # Input validation
  if (length(PEC) != length(EC50_algae) ||
      length(PEC) != length(EC50_daphnids) ||
      length(PEC) != length(EC50_fish))
    # length(PEC) != length(AF))
  {
    stop("All input vectors (PEC, EC50_algae, EC50_daphnids, EC50_fish, AF) must have the same length.")
  }

  # Calculate the minimum EC50 for each contaminant
  min_EC50 <- pmin(EC50_algae, EC50_daphnids, EC50_fish, na.rm = TRUE)

  # Calculate the PNEC for each contaminant
  PNEC <- min_EC50 * 1/AF

  # Calculate RQ for each contaminant
  RQ_values <- PEC / PNEC

  # Sum the RQs to get the final Risk Quotient
  total_RQ <- sum(RQ_values, na.rm = TRUE)

  # Verbose output for details
  if (verbose) {
    cat("=== Ecotoxicity Risk Quotient Calculation ===\n")
    cat("Input Data:\n")
    cat("- PEC (Environmental Concentrations):", PEC, "\n")
    cat("- EC50 (Algae):", EC50_algae, "\n")
    cat("- EC50 (daphnids):", EC50_daphnids, "\n")
    cat("- EC50 (Fish):", EC50_fish, "\n")
    cat("- Assessment Factors (AF):", AF, "\n")
    cat("\nIntermediate Calculations:\n")
    cat("- Minimum EC50 values:", min_EC50, "\n")
    cat("- PNEC values:", PNEC, "\n")
    cat("- Individual RQ values:", RQ_values, "\n")
    cat("\nFinal Result:\n")
    cat("- Total RQ (Sum of all contaminants):", total_RQ, "\n")
    cat("============================================\n")
  }

  return(total_RQ)
}
