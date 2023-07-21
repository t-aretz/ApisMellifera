nextflow.enable.dsl = 2

include { FASTP } from './modules/fastp.nf'

log.info """\
         RNAseq fastp analysis using NextFlow 
         =============================
         reads_1 : ${params.reads_1}
         reads_2 : ${params.reads_2}
         outdir: ${params.outdir}
         """
         .stripIndent()

workflow {

    // Create separate channels for read 1 and read 2
    //Channel.fromFilePairs(params.reads_1, checkIfExists: true).set( read1_ch )
    //Channel.fromFilePairs(params.reads_2, checkIfExists: true).set( read2_ch )

    read1_ch = Channel.fromFilePairs(params.reads_1, checkIfExists: true)
    read2_ch = Channel.fromFilePairs(params.reads_2, checkIfExists: true)

    // Process read 1 and read 2 channels using FASTP
    FASTP(read1_ch, read2_ch)
}
