context("Get GetNearGenes")

test_that("It maps correctly to hg38", {
  tssAnnot <- getTSS(genome = "hg38")
  geneAnnot <- TCGAbiolinks:::get.GRCh.bioMart(genome = "hg38",as.granges = TRUE)
  probe <- GRanges(seqnames = c("chr1"), 
                   row.names =  c("cg18108049"),
                   names =  c("cg18108049"),
                   range = IRanges(start = c(16058489), end= c(16058489)))
  # this are hg19 annotation 
  # chr1:16010827:16062808
  # chr1:16058489:16058489
  
  NearbyGenes <- ELMER:::getRegionNearGenes(TRange = probe,
                                       geneAnnot = geneAnnot,
                                       numFlankingGenes = 4)
  
  expect_equal(NearbyGenes[NearbyGenes$Side == "L2",]$GeneID , "ENSG00000184908")
  expect_equal(NearbyGenes[NearbyGenes$Side == "L1",]$GeneID, "ENSG00000185519")
  expect_equal(NearbyGenes[NearbyGenes$Side == "L2",]$Symbol, "CLCNKB")
  expect_equal(NearbyGenes[NearbyGenes$Side == "L1",]$Symbol, "FAM131C")
  expect_equal(NearbyGenes[NearbyGenes$Side == "R1",]$GeneID, "ENSG00000142627")
  expect_equal(NearbyGenes[NearbyGenes$Side == "R1",]$Symbol, "EPHA2")
  
  NearbyGenes <- GetNearGenes(numFlankingGenes = 4,
                              geneAnnot = geneAnnot,
                              TRange = probe)
  expect_equal(NearbyGenes[NearbyGenes$Side == "L2",]$GeneID, "ENSG00000184908")
  expect_equal(NearbyGenes[NearbyGenes$Side == "L1",]$GeneID, "ENSG00000185519")
  expect_equal(NearbyGenes[NearbyGenes$Side == "L2",]$Symbol, "CLCNKB")
  expect_equal(NearbyGenes[NearbyGenes$Side == "L1",]$Symbol, "FAM131C")
  expect_equal(NearbyGenes[NearbyGenes$Side == "R1",]$GeneID, "ENSG00000142627")
  expect_equal(NearbyGenes[NearbyGenes$Side == "R1",]$Symbol, "EPHA2")
})


test_that("It maps correctly to hg38 if more than one region", {
  tssAnnot <- getTSS(genome = "hg38")
  geneAnnot <- TCGAbiolinks:::get.GRCh.bioMart(genome = "hg38",as.granges = TRUE)
  probe <- getInfiniumAnnotation(genome = "hg19")[c("cg18108049","cg14008030","cg00381604","cg15254640","cg08417382")] 

  NearbyGenes <- ELMER:::getRegionNearGenes(TRange = probe,
                                            geneAnnot = geneAnnot,
                                            numFlankingGenes = 4)
  
  expect_equal(NearbyGenes[NearbyGenes$Side == "L2" & NearbyGenes$ID == "cg18108049",]$GeneID , "ENSG00000184908")
  expect_equal(NearbyGenes[NearbyGenes$Side == "L1"  & NearbyGenes$ID == "cg18108049",]$GeneID, "ENSG00000185519")
  expect_equal(NearbyGenes[NearbyGenes$Side == "L2" & NearbyGenes$ID == "cg18108049",]$Symbol, "CLCNKB")
  expect_equal(NearbyGenes[NearbyGenes$Side == "L1" & NearbyGenes$ID == "cg18108049",]$Symbol, "FAM131C")
  expect_equal(NearbyGenes[NearbyGenes$Side == "R1" & NearbyGenes$ID == "cg18108049",]$GeneID, "ENSG00000142627")
  expect_equal(NearbyGenes[NearbyGenes$Side == "R1" & NearbyGenes$ID == "cg18108049",]$Symbol, "EPHA2")
  
  NearbyGenes <- GetNearGenes(numFlankingGenes = 20,
                              geneAnnot = geneAnnot,
                              TRange = probe)
  expect_equal(NearbyGenes[NearbyGenes$Side == "L2" & NearbyGenes$ID == "cg18108049",]$GeneID, "ENSG00000184908")
  expect_equal(NearbyGenes[NearbyGenes$Side == "L1" & NearbyGenes$ID == "cg18108049",]$GeneID, "ENSG00000185519")
  expect_equal(NearbyGenes[NearbyGenes$Side == "L2" & NearbyGenes$ID == "cg18108049",]$Symbol, "CLCNKB")
  expect_equal(NearbyGenes[NearbyGenes$Side == "L1" & NearbyGenes$ID == "cg18108049",]$Symbol, "FAM131C")
  expect_equal(NearbyGenes[NearbyGenes$Side == "R1" & NearbyGenes$ID == "cg18108049",]$GeneID, "ENSG00000142627")
  expect_equal(NearbyGenes[NearbyGenes$Side == "R1" & NearbyGenes$ID == "cg18108049",]$Symbol, "EPHA2")
})

test_that("It maps correctly to hg19", {
  tssAnnot <- getTSS(genome = "hg19")
  geneAnnot <- TCGAbiolinks:::get.GRCh.bioMart(genome = "hg19",as.granges = TRUE)
  probe <- GRanges(seqnames = c("chr1"), 
                   row.names =  c("cg18108049"),
                   names =  c("cg18108049"),
                   range = IRanges(start = c(16058489), end= c(16058489)))
  # chr1:16010827:16062808
  # chr1:16058489:16058489
  NearbyGenes <- ELMER:::getRegionNearGenes(TRange = probe,
                                       geneAnnot = geneAnnot,
                                       numFlankingGenes = 30)
  
  expect_true(all(c("SLC25A34","RSC1A1","AGMAT","DDI2","PLEKHM2") %in% NearbyGenes$Symbol))
})