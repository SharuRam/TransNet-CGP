# Load required libraries
# install.packages("Hmisc")
library(Hmisc)

# Read the CSV file into a data frame
# Replace "your_gene_expression_file.csv" with the actual file path
gene_data <- read.csv("D:/PROGRAMS/Comorbidity/CD-G/gene-exp-2.csv", header = FALSE, row.names = 1)


gene_data<-t(gene_data)
# Calculate Pearson correlation matrix
cor_matrix <- rcorr(as.matrix(gene_data), type = "pearson")

# Print the correlation matrix
cat("Pearson's Correlation Matrix:\n")
print(cor_matrix$r)

# Save the correlation matrix to a CSV file
write.csv(cor_matrix$r, file = "D:/PROGRAMS/Comorbidity/CD-G/gene_correlation_matrix.csv")

# Optionally, you can also save the p-values
write.csv(cor_matrix$P, file = "D:/PROGRAMS/Comorbidity/CD-G/gene_correlation_pvalues.csv")


data <- read.csv("D:/PROGRAMS/Comorbidity/CD-G/gene_correlation_matrix.csv", header = FALSE, row.names = 1)
data<-data[-1,]
num_rows1<-nrow(data)

rname<-rownames(data)

result_df <- data.frame(Row1 = character(), Row2 = character(), Correlation = numeric(), stringsAsFactors = FALSE)

# Calculate Pearson correlation between every two rows
for (i in 1:(num_rows1 - 1)) {
  for (j in 1:(num_rows1-1)) {
    result_df <- rbind(result_df, c(rname[i], rname[j], data[i,j]))
  }
}

# Rename the columns
colnames(result_df) <- c("Row1", "Row2", "Correlation")

# Write the output to a new CSV file
write.csv(result_df, file = "D:/PROGRAMS/Comorbidity/CD-G/your_output_file.csv", row.names = FALSE)


