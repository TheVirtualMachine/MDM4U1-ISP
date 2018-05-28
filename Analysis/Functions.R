# Calculate the cosine similarity between two vectors.
cosineSimilarity <- function(a, b) {
	return (sum(a * b) / (sqrt(sum(a^2)) * sqrt(sum(b^2))))
}
