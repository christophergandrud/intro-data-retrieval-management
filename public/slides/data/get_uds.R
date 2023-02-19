# Download UDS data and save to CSV

# For simplicity, store the URL in an object called 'URL'.
URL <- "http://bit.ly/1jXJgDh"

# Create a temporary file called 'temp' to put the zip file into.
temp <- tempfile()

# Download the compressed file into the temporary file.
download.file(URL, temp)

# Decompress the file and convert it into a data frame
UDSData <- read.csv(gzfile(temp, "uds_summary.csv"))

# Delete temp file
unlink(tmp)

# Save
write.csv(UDSData, file = "static/slides/data/uds_summary.csv") 
