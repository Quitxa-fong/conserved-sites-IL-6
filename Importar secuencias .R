##Como importar datos a r desde genbank
library(ape)
install.packages("rentrez")
library(rentrez)

## import the sequence list from a CSV file
## NO "strings as factor"
coi <- read.table("https://raw.githubusercontent.com/vbaliga/vbaliga.github.io/master/images/2019-11-26/COI_BaligaLaw2016.csv",
                  quote="\"", stringsAsFactors=FALSE)

## convertir caracteres a listas
as.list(coi)$V1 -> coi_list
str(coi_list)

##adquirir las secuencias 
coi_gen <- read.GenBank(coi_list, species.names = TRUE)
coi_gen

## now use species names, as found within the GenBank entry
names_coi <- data.frame(species = attr(coi_gen, "species"),
                        accs = names(coi_gen))
head(names_coi)

## add these names 
names(coi_gen) <- attr(coi_gen, "species")
## export the file to your working directory
## commenting out the line below so this post knits properly
## be sure to un-comment it so it actually runs:

write.dna(coi_gen, "my_COI_seqs.fasta", format = "fasta")
