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

    // Combine read 1 and read 2 files into a single channel of tuples
    val read_pairs_ch = Channel.fromFilePairs(params.reads_1, params.reads_2, checkIfExists: true)

    FASTP( read_pairs_ch )
}
