/*
Subworkflow for fastqc from raw data, fastp trimming, then fastqc again
Requries set params:

params.fastp_q  = Q score for trimming

*/


include { FASTQC_SE as RAW_FASTQC } from '../modules/FASTQC.nf'
//include { FASTP_SE as FASTP } from '../modules/FASTP.nf'
//include { FASTQC_SE as FASTP_FASTQC } from '../modules/FASTQC.nf'
//include { SCYTHE_SE as SCYTHE } from '../modules/SCYTHE.nf'
//include { FASTQC_SE as SCYTHE_FASTQC } from '../modules/FASTQC.nf'
//include { CUTADAPT_SE as CUTADAPT } from '../modules/CUTADAPT.nf'
//include { FASTQC_SE as CUTADAPT_FASTQC } from '../modules/FASTQC.nf'
include { BBDUK_SE as BBDUK } from '../modules/BBDUK.nf'
include { FASTQC_SE as BBDUK_FASTQC } from '../modules/FASTQC.nf'
include { SICKLE_SE as SICKLE } from '../modules/SICKLE.nf'
include { FASTQC_SE as SICKLE_FASTQC } from '../modules/FASTQC.nf'



workflow SINGLE_END {
    take:
        ch_fastqs                                          // channel: [val(sample), [fastq_1, fastq_2]]
    main:

        ch_adapter_fasta = Channel.fromPath(params.adapters_fasta)
        ch_adapter_tsv = Channel.fromPath(params.adapters_tsv)


        RAW_FASTQC(ch_fastqs)

        //FASTP(ch_fastqs)
        //FASTP_FASTQC(FASTP.out.trimmed_fastq)

        //SCYTHE(ch_fastqs)
        //SCYTHE_FASTQC(SCYTHE.out.)

        //CUTADAPT(ch_fastqs)
        //CUTADAPT_FASTQC(CUTADAPT.out.)

        ch_for_bbduk = ch_fastqs.join(ch_adapter_fasta)
        BBDUK(ch_for_bbduk)
        ch_for_bbduk_fastqc = BBDUK.out.trim.join(ch_adapter_tsv)
        BBDUK_FASTQC(ch_for_fastqc)

        SICKLE(BBDUK.out.trim)
        ch_for_sickle_fastqc = SICKLE.out.trim.join(ch_adapter_tsv)
        SICKLE_FASTQC(ch_for_sickle_fastqc)


    emit:
        ch_trimmed_fastq    =  FASTP.out.trimmed_fastq  //   channel: [ val(sample), fastq_1, fastq_2]

}