#' Calculate RQ_STU with Conditional Equation 5 Refinement
#'
#' This function calculates RQ_STU using Equation 4 and applies Equation 5 only if RQ_STU > 1.
#'
#' @param PEC A vector of Predicted Environmental Concentrations (PECi) (e.g., µg/L or mg/L).
#' @param EC50_algae A vector of EC50 values for algae (e.g., mg/L).
#' @param EC50_daphnids A vector of EC50 values for Daphnia sp. (e.g., mg/L).
#' @param EC50_fish A vector of EC50 values for fish (e.g., mg/L).
#' @param AF Assessment Factor (default = 1).
#' @param verbose Logical, if TRUE, prints detailed output (default = TRUE).
#' @return The final Risk Quotient (RQ_STU) value after applying conditions.
#' @export
calculate_RQ_STU <- function(input_file = NULL, AF = 1000, sheet = 1, verbose = TRUE) {
  if (!is.null(input_file)) {
    # Load data from Excel file
    data <- readxl::read_excel(input_file, sheet = sheet)
    PEC <- as.numeric(data$PEC)
    EC50_algae <- as.numeric(data$EC50_algae)
    EC50_daphnids <- as.numeric(data$EC50_daphnids)
    EC50_fish <- as.numeric(data$EC50_fish)

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
      length(PEC) != length(EC50_fish)) {
    stop("PEC, EC50_algae, EC50_daphnids, and EC50_fish must have the same length.")
  }

  # Step 1: Calculate STU for each species
  STU_algae <- sum(PEC / EC50_algae, na.rm = TRUE)
  STU_daphnids <- sum(PEC / EC50_daphnids, na.rm = TRUE)
  STU_fish <- sum(PEC / EC50_fish, na.rm = TRUE)

  # Step 2: Calculate RQ_STU using Equation 4
  max_STU <- max(STU_algae, STU_daphnids, STU_fish)
  RQ_STU <- max_STU * AF

  # Step 3: Apply Equation 5 if RQ_STU > 1
  if (RQ_STU > 1) {
    # Calculate the numerator (sum of PEC/EC50 across all species)
    total_ratio <- sum(PEC / EC50_algae, na.rm = TRUE) +
      sum(PEC / EC50_daphnids, na.rm = TRUE) +
      sum(PEC / EC50_fish, na.rm = TRUE)

    # Calculate the denominator (maximum PEC/EC50 across all species)
    max_ratio <- max(
      max(PEC / EC50_algae, na.rm = TRUE),
      max(PEC / EC50_daphnids, na.rm = TRUE),
      max(PEC / EC50_fish, na.rm = TRUE)
    )

    # Final RQ_STU using Equation 4
    RQ_STU <- total_ratio / max_ratio
  }

  # Verbose output for details
  if (verbose) {
    cat("=== Risk Quotient (RQ_STU) Calculation ===\n")
    cat("Input Data:\n")
    cat("- PEC (Environmental Concentrations):", PEC, "\n")
    cat("- EC50 (Algae):", EC50_algae, "\n")
    cat("- EC50 (Daphnia):", EC50_daphnids, "\n")
    cat("- EC50 (Fish):", EC50_fish, "\n")
    cat("- Assessment Factor (AF):", AF, "\n")
    cat("\nIntermediate Calculations:\n")
    cat("- STU (Algae):", STU_algae, "\n")
    cat("- STU (Daphnia):", STU_daphnids, "\n")
    cat("- STU (Fish):", STU_fish, "\n")
    cat("- Maximum STU (Equation 4):", max_STU, "\n")
    if (RQ_STU > 1) {
      cat("\nCondition Met: RQ_STU > 1. Applying Equation 5.\n")
      cat("- Total Ratio (Σ PEC/EC50):", total_ratio, "\n")
      cat("- Maximum Ratio (max PEC/EC50):", max_ratio, "\n")
      cat("\nFinal Result:\n")
      cat("- EC50IA / EC50CA ≤", RQ_STU, "\n")
    } else {
      cat("\nCondition Not Met: RQ_STU ≤ 1. Using Equation 4 result.\n")
      cat("\nFinal Result:\n")
      cat("- RQ_STU:", RQ_STU, "\n")
    }
    cat("=========================================\n")

  }

  return(RQ_STU)
}
