nextflow.enable.dsl = 2

include { FASTP } from './modules/fastp.nf'

log.info """\
         RNAseq fastp analysis using NextFlow 
         =============================
         reads : ${params.reads}
         outdir: ${params.outdir}
         """
         .stripIndent()

workflow {

    // Create separate channels for read 1 and read 2
    //Channel.fromFilePairs(params.reads_1, checkIfExists: true).set( read1_ch )
    //Channel.fromFilePairs(params.reads_2, checkIfExists: true).set( read2_ch )

    Channel.fromFilePairs(params.reads, checkIfExists: true).set{ read_pairs_unsplit_ch }

    Channel.of( 'task1' , 'task2') | FASTP( read_pairs_unsplit_ch )
}
