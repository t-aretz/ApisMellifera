nextflow.enable.dsl = 2

include { FASTP } from './modules/fastp.nf'
include { STAR_INDEX_REFERENCE ; STAR_ALIGN } from './modules/star.nf'

log.info """\
         RNAseq fastp analysis using NextFlow 
         =============================
         reads : ${params.reads}
         outdir: ${params.outdir}
         """
         .stripIndent()


workflow {

    Channel.fromFilePairs(params.reads, checkIfExists: true).set{ read_pairs_unsplit_ch }

	FASTP( read_pairs_unsplit_ch )

    STAR_INDEX_REFERENCE( params.reference_genome, params.reference_annotation )
    STAR_ALIGN( read_pairs_unsplit_ch, STAR_INDEX_REFERENCE.out, params.reference_annotation )
}
