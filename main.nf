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

    stringChannel = Channel.of("string1", "string2", "string3")

    combinedChannel = stringChannel.combine(read_pairs_unsplit_ch)
    combinedChannel.view()

    FASTP(combinedChannel )

}
