# element_cleanup
element_cleanup is a simple Nextflow pipeline designed to clean up sequencing data generated on the Aviti Element platform. The pipeline comes pre-configured with known Aviti-specific contaminants that commonly arise from the protocols used.

While a default contaminant FASTA is included, it is highly recommended to either review this file or provide a custom contaminant FASTA tailored to your specific experimental setup.

# Running `element_cleanup`

`element_cleanup` is supplied with a configuration file optimized for the SciNet Ceres cluster.

> ⚠️ **Note:** This pipeline currently supports only **paired-end** data. If you would like to use single-end data, please submit a ticket.

---

### 📄 Sample Sheet Format

The input sample sheet should be a CSV file with the following format:

```csv
sample,r1,r2
Sample_01,/full/path/to/Sample_01_R1.fastq.gz,/full/path/to/Sample_01_R2.fastq.gz
Sample_02,/full/path/to/Sample_02_R1.fastq.gz,/full/path/to/Sample_02_R2.fastq.gz
```

### Paired-End Cleanup Command

To run the pipeline on Ceres:

```bash
nextflow run element_cleanup/ -c element_cleanup/configs/ceres/ceres.cfg \
    --project_name Project_Name \
    --sample_sheet /full/path/to/samplesheet.csv \
    --workflow_opt cleanup_pe
```
