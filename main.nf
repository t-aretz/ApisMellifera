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

    def readsCH = Channel.fromFilePairs(params.reads, checkIfExists: true)

	FASTP(readsCH)
}
