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

    Channel.fromFilePairs(params.reads, checkIfExists: true).set{ read_pairs_unsplit_ch }

    stringChannel = Channel.of([["task1", "task2", "task3"]])

    combinedChannel = read_pairs_unsplit_ch.combine(stringChannel)
    combinedChannel.view()

    FASTP( combinedChannel )
}
